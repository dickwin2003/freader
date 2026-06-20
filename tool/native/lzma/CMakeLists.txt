cmake_minimum_required(VERSION 3.10)
project(sz7 C)

set(CMAKE_C_STANDARD 11)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

set(SZ7_DIR ${CMAKE_CURRENT_SOURCE_DIR}/C)

add_library(sz7 SHARED
  extract7z.c
  ${SZ7_DIR}/7zArcIn.c
  ${SZ7_DIR}/7zBuf.c
  ${SZ7_DIR}/7zDec.c
  ${SZ7_DIR}/7zCrc.c
  ${SZ7_DIR}/7zCrcOpt.c
  ${SZ7_DIR}/7zStream.c
  ${SZ7_DIR}/7zFile.c
  ${SZ7_DIR}/LzmaDec.c
  ${SZ7_DIR}/Lzma2Dec.c
  ${SZ7_DIR}/Bcj2.c
  ${SZ7_DIR}/Bra.c
  ${SZ7_DIR}/Bra86.c
  ${SZ7_DIR}/BraIA64.c
  ${SZ7_DIR}/Delta.c
  ${SZ7_DIR}/CpuArch.c
  ${SZ7_DIR}/7zAlloc.c
  ${SZ7_DIR}/Alloc.c
)

target_include_directories(sz7 PRIVATE ${SZ7_DIR})
target_compile_definitions(sz7 PRIVATE _7ZIP_LARGE_PAGES Z7_ST)
target_compile_options(sz7 PRIVATE -Wno-unused-result -Wno-unused-function)

find_library(log-lib log)
target_link_libraries(sz7 ${log-lib})
