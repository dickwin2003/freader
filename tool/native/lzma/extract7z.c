/* extract7z.c — 7z 解压 wrapper（library），供 dart:ffi 调用。
 * 基于 LZMA SDK 的 C/Util/7z/7zMain.c 改写为单函数 extract7z(arcPath, outDir)。
 * 返回解压文件数（>=0）；负值表示错误码。*/
#include "7z.h"
#include "7zAlloc.h"
#include "7zCrc.h"
#include "7zFile.h"

#include <stdio.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/types.h>

static const ISzAlloc g_Alloc = { SzAlloc, SzFree };
#define kInputBufSize ((size_t)1 << 20)

/* UTF-16 LE → UTF-8（覆盖 BMP） */
static int utf16_to_utf8(const UInt16 *src, char *dst, int max) {
  int n = 0;
  for (int i = 0; src[i] != 0 && n < max - 4; i++) {
    unsigned int c = src[i];
    if (c < 0x80) dst[n++] = (char)c;
    else if (c < 0x800) { dst[n++] = (char)(0xC0 | (c >> 6)); dst[n++] = (char)(0x80 | (c & 0x3F)); }
    else { dst[n++] = (char)(0xE0 | (c >> 12)); dst[n++] = (char)(0x80 | ((c >> 6) & 0x3F)); dst[n++] = (char)(0x80 | (c & 0x3F)); }
  }
  dst[n] = 0;
  return n;
}

static void make_dirs(const char *path) {
  char tmp[3072];
  strncpy(tmp, path, sizeof(tmp) - 1);
  tmp[sizeof(tmp) - 1] = 0;
  for (char *p = tmp + 1; *p; p++) {
    if (*p == '/') { *p = 0; mkdir(tmp, 0777); *p = '/'; }
  }
  mkdir(tmp, 0777);
}

int extract7z(const char *arcPath, const char *outDir) {
  CFileInStream arcStream;
  CLookToRead2 lookStream;
  CSzArEx db;
  SRes res = SZ_OK;
  UInt32 blockIndex = 0xFFFFFFFF;
  Byte *outBuffer = 0;
  size_t outBufferSize = 0;
  int count = 0;

  WRes wres = InFile_Open(&arcStream.file, arcPath);
  if (wres != 0) return -1;
  FileInStream_CreateVTable(&arcStream);
  arcStream.wres = 0;
  LookToRead2_CreateVTable(&lookStream, False);
  lookStream.buf = (Byte *)ISzAlloc_Alloc(&g_Alloc, kInputBufSize);
  if (!lookStream.buf) { File_Close(&arcStream.file); return -2; }
  lookStream.bufSize = kInputBufSize;
  lookStream.realStream = &arcStream.vt;
  LookToRead2_INIT(&lookStream)

  CrcGenerateTable();
  SzArEx_Init(&db);
  res = SzArEx_Open(&db, &lookStream.vt, &g_Alloc, &g_Alloc);
  if (res == SZ_OK) {
    UInt32 i;
    for (i = 0; i < db.NumFiles; i++) {
      size_t offset = 0, outSizeProcessed = 0;
      UInt16 nameW[1024];
      char rel[2048], full[3072], dir[3072];
      char *slash;
      FILE *f;
      if (SzArEx_IsDir(&db, i)) continue;
      SzArEx_GetFileNameUtf16(&db, i, nameW);
      utf16_to_utf8(nameW, rel, sizeof(rel));
      for (char *p = rel; *p; p++) if (*p == '\\') *p = '/';
      snprintf(full, sizeof(full), "%s/%s", outDir, rel);
      strncpy(dir, full, sizeof(dir) - 1); dir[sizeof(dir) - 1] = 0;
      slash = strrchr(dir, '/');
      if (slash) { *slash = 0; make_dirs(dir); }
      res = SzArEx_Extract(&db, &lookStream.vt, i, &blockIndex,
          &outBuffer, &outBufferSize, &offset, &outSizeProcessed, &g_Alloc, &g_Alloc);
      if (res != SZ_OK) break;
      f = fopen(full, "wb");
      if (f) { fwrite(outBuffer + offset, 1, outSizeProcessed, f); fclose(f); count++; }
    }
  }
  SzArEx_Free(&db, &g_Alloc);
  ISzAlloc_Free(&g_Alloc, lookStream.buf);
  File_Close(&arcStream.file);
  return (res == SZ_OK) ? count : -(int)res;
}
