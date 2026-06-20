package io.freader

import android.content.Intent
import android.net.Uri
import android.provider.OpenableColumns
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File
import java.io.FileOutputStream
import java.io.InputStream

class MainActivity : FlutterFragmentActivity() {
    private val INTENT_CHANNEL = "io.freader/intent"
    private var intentChannel: MethodChannel? = null
    private var pendingUri: String? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // Intent 处理通道
        intentChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, INTENT_CHANNEL)
        intentChannel!!.setMethodCallHandler { call, result ->
            when (call.method) {
                "getInitialUri" -> {
                    val uri = resolveIntentUri(intent)
                    if (uri != null) pendingUri = uri
                    result.success(pendingUri)
                    pendingUri = null
                }
                else -> result.notImplemented()
            }
        }

        // Handle cold start
        val uri = resolveIntentUri(intent)
        if (uri != null) pendingUri = uri
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        setIntent(intent)
        val uri = resolveIntentUri(intent)
        if (uri != null) {
            intentChannel?.invokeMethod("onNewUri", uri)
        }
    }

    // ===== Intent URI 解析 =====

    private fun resolveIntentUri(intent: Intent?): String? {
        if (intent == null) return null
        if (intent.action != Intent.ACTION_VIEW) return null
        val data: Uri? = intent.data ?: return null
        return when (data?.scheme) {
            "content" -> copyContentToFile(data)
            "file" -> data.path
            else -> null
        }
    }

    private fun copyContentToFile(uri: Uri): String? {
        return try {
            var fileName = "imported_file"
            val cursor = contentResolver.query(uri, null, null, null, null)
            if (cursor != null) {
                val nameIndex = cursor.getColumnIndex(OpenableColumns.DISPLAY_NAME)
                if (nameIndex >= 0 && cursor.moveToFirst()) {
                    fileName = cursor.getString(nameIndex)
                }
                cursor.close()
            }
            val cacheDir = File(cacheDir, "imported")
            if (!cacheDir.exists()) cacheDir.mkdirs()
            val outFile = File(cacheDir, "${System.currentTimeMillis()}_$fileName")
            val inputStream: InputStream? = contentResolver.openInputStream(uri)
            if (inputStream != null) {
                val outputStream = FileOutputStream(outFile)
                val buffer = ByteArray(8192)
                var bytesRead: Int
                while (inputStream.read(buffer).also { bytesRead = it } != -1) {
                    outputStream.write(buffer, 0, bytesRead)
                }
                inputStream.close()
                outputStream.close()
                outFile.absolutePath
            } else null
        } catch (e: Exception) { e.printStackTrace(); null }
    }

    override fun onDestroy() {
        super.onDestroy()
        intentChannel?.setMethodCallHandler(null)
        intentChannel = null
    }
}
