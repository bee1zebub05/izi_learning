package com.fau.pdf_converter

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.provider.DocumentsContract
import android.provider.MediaStore
import android.util.Log
import androidx.documentfile.provider.DocumentFile
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry
import java.io.File
import java.io.FileOutputStream
import java.io.IOException

class FileManagerPlugin(private val context: Context) : MethodCallHandler, PluginRegistry.ActivityResultListener {
    private lateinit var channel: MethodChannel
    private var activity: Activity? = null
    private var pendingResult: Result? = null
    private val REQUEST_CODE_PICK_FILE = 1001
    private val TAG = "FileManagerPlugin"

    fun onAttachedToEngine(flutterEngine: FlutterEngine, channelName: String) {
        channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channelName)
        channel.setMethodCallHandler(this)
        Log.d(TAG, "Plugin attached to engine with channel: $channelName")
    }
    
    fun setActivity(activity: Activity?) {
        this.activity = activity
        Log.d(TAG, "Activity set: ${activity != null}")
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        Log.d(TAG, "Method called: ${call.method}")
        
        when (call.method) {
            "pickFile" -> {
                pickFile(result)
            }
            "saveFile" -> {
                try {
                    val content = call.argument<String>("content") ?: ""
                    val path = call.argument<String>("path") ?: ""
                    
                    Log.d(TAG, "Saving file to: $path")
                    Log.d(TAG, "Content length: ${content.length}")
                    
                    // Check if the path is a content URI
                    if (path.startsWith("content://")) {
                        saveToContentUri(content, Uri.parse(path), result)
                    } else {
                        saveFileToStorage(content, path, result)
                    }
                } catch (e: Exception) {
                    Log.e(TAG, "Error saving file: ${e.message}", e)
                    result.error("SAVE_ERROR", "Failed to save file: ${e.message}", null)
                }
            }
            else -> result.notImplemented()
        }
    }
    
    private fun pickFile(result: Result) {
        Log.d(TAG, "Starting pickFile method")
        if (activity == null) {
            Log.e(TAG, "No activity available")
            result.error("NO_ACTIVITY", "No activity available", null)
            return
        }
        
        pendingResult = result
        
        try {
            // IMPORTANT: Use ACTION_OPEN_DOCUMENT instead of ACTION_GET_CONTENT to get writable URIs
            val intent = Intent(Intent.ACTION_OPEN_DOCUMENT).apply {
                addCategory(Intent.CATEGORY_OPENABLE)
                
                // Set type to any file to show all files
                type = "*/*"
                
                // Specify the MIME types with more permissive options
                putExtra(Intent.EXTRA_MIME_TYPES, arrayOf(
                    "application/x-ipynb+json",
                    "application/json",
                    "text/plain",
                    "application/octet-stream",
                    "*/*"
                ))
                
                // CRITICAL FLAGS for getting write permissions:
                addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
                addFlags(Intent.FLAG_GRANT_WRITE_URI_PERMISSION)
                addFlags(Intent.FLAG_GRANT_PERSISTABLE_URI_PERMISSION)
            }
            
            Log.d(TAG, "Launching ACTION_OPEN_DOCUMENT intent with permission flags")
            activity?.startActivityForResult(intent, REQUEST_CODE_PICK_FILE)
        } catch (e: Exception) {
            Log.e(TAG, "Error launching file picker: ${e.message}", e)
            pendingResult?.error("LAUNCH_ERROR", "Failed to launch file picker: ${e.message}", null)
            pendingResult = null
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
        Log.d(TAG, "onActivityResult: requestCode=$requestCode, resultCode=$resultCode")
        
        if (requestCode == REQUEST_CODE_PICK_FILE) {
            if (resultCode == Activity.RESULT_OK && data != null) {
                val uri = data.data
                Log.d(TAG, "File URI: $uri")
                
                if (uri != null) {
                    try {
                        // CRITICAL: Take persistent permissions right after getting the URI
                        try {
                            val takeFlags = data.flags and 
                                (Intent.FLAG_GRANT_READ_URI_PERMISSION or
                                Intent.FLAG_GRANT_WRITE_URI_PERMISSION)
                                
                            // This is critical for being able to write later
                            context.contentResolver.takePersistableUriPermission(uri, takeFlags)
                            Log.d(TAG, "Successfully took persistable permissions for URI")
                        } catch (e: Exception) {
                            Log.e(TAG, "Failed to take persistable permissions: ${e.message}", e)
                            // Continue anyway as we might still be able to read
                        }
                        
                        // Check if we can actually write to this URI
                        val documentFile = DocumentFile.fromSingleUri(context, uri)
                        val canWrite = documentFile?.canWrite() ?: false
                        Log.d(TAG, "URI write permission check: canWrite=$canWrite")
                        
                        val path = getPathFromUri(uri)
                        Log.d(TAG, "File path: $path")
                        
                        val content = readTextFromUri(uri)
                        Log.d(TAG, "File content length: ${content.length}")
                        
                        // Return as a map with originalUri included for newer clients
                        // but maintain backward compatibility with list format
                        val uriString = uri.toString()
                        Log.d(TAG, "Returning URI string: $uriString")
                        pendingResult?.success(listOf(path, content, uriString))
                    } catch (e: Exception) {
                        Log.e(TAG, "Error reading file: ${e.message}", e)
                        pendingResult?.error("FILE_READ_ERROR", "Failed to read file: ${e.message}", null)
                    }
                } else {
                    Log.e(TAG, "URI is null")
                    pendingResult?.error("URI_ERROR", "Failed to get URI from file picker", null)
                }
            } else {
                Log.d(TAG, "File picking was cancelled or failed")
                pendingResult?.error("CANCELLED", "File picking was cancelled", null)
            }
            pendingResult = null
            return true
        }
        return false
    }
    
    private fun saveToContentUri(content: String, uri: Uri, result: Result) {
        try {
            Log.d(TAG, "Saving directly to content URI: $uri")
            
            // Get DocumentFile from URI to verify permissions
            val documentFile = DocumentFile.fromSingleUri(context, uri)
            
            if (documentFile == null) {
                Log.e(TAG, "DocumentFile is null, cannot access URI")
                result.error("URI_ERROR", "Cannot access file URI", null)
                return
            }
            
            // Check write permission
            if (!documentFile.canWrite()) {
                Log.e(TAG, "No write permission for URI")
                
                // Try to re-take permission as a last attempt
                try {
                    val takeFlags = Intent.FLAG_GRANT_READ_URI_PERMISSION or 
                                    Intent.FLAG_GRANT_WRITE_URI_PERMISSION
                    context.contentResolver.takePersistableUriPermission(uri, takeFlags)
                    Log.d(TAG, "Attempted to re-take URI permissions")
                } catch (e: Exception) {
                    Log.e(TAG, "Failed to take permissions: ${e.message}", e)
                }
                
                // Check again after trying to re-take permission
                if (!documentFile.canWrite()) {
                    result.error("PERMISSION_ERROR", "No write permission for this file. Please try opening the file again.", null)
                    return
                }
            }
            
            // Use "wt" mode to truncate the file (write, truncate)
            context.contentResolver.openOutputStream(uri, "wt")?.use { outputStream ->
                outputStream.write(content.toByteArray())
                outputStream.flush()
                Log.d(TAG, "Successfully wrote to content URI")
                result.success("File updated successfully")
            } ?: run {
                Log.e(TAG, "Failed to open output stream")
                result.error("IO_ERROR", "Failed to open file for writing", null)
            }
        } catch (e: SecurityException) { // Fixed: Added proper type annotation
            Log.e(TAG, "Security exception: ${e.message}", e)
            result.error("SECURITY_ERROR", "Security exception: ${e.message}", null)
        } catch (e: Exception) {
            Log.e(TAG, "Error writing to content URI: ${e.message}", e)
            result.error("WRITE_ERROR", "Failed to write to file: ${e.message}", null)
        }
    }
    
    private fun saveFileToStorage(content: String, path: String, result: Result) {
        Log.d(TAG, "Saving file to storage path: $path")
        
        try {
            val file = File(path)
            val parentDir = file.parentFile
            
            // Create directories if needed
            if (parentDir != null && !parentDir.exists()) {
                val created = parentDir.mkdirs()
                Log.d(TAG, "Created parent directories: $created")
                
                if (!created) {
                    Log.e(TAG, "Could not create parent directories")
                    result.error("IO_ERROR", "Could not create directories", null)
                    return
                }
            }
            
            // Write to file
            FileOutputStream(file).use { outputStream ->
                outputStream.write(content.toByteArray())
                outputStream.flush()
                Log.d(TAG, "Successfully wrote to file: $path")
                result.success("File saved successfully to $path")
            }
        } catch (e: Exception) {
            Log.e(TAG, "Error saving to path: ${e.message}", e)
            
            // If we can't write to the original path, try app storage as fallback
            try {
                val fileName = File(path).name
                val notebooksDir = File(context.getExternalFilesDir(null), "notebooks")
                if (!notebooksDir.exists()) {
                    notebooksDir.mkdirs()
                }
                
                val newFile = File(notebooksDir, fileName)
                FileOutputStream(newFile).use { outputStream ->
                    outputStream.write(content.toByteArray())
                    outputStream.flush()
                }
                
                Log.d(TAG, "Saved to app storage instead: ${newFile.absolutePath}")
                result.success("Saved to app storage: ${newFile.absolutePath}")
            } catch (fallbackError: Exception) {
                Log.e(TAG, "Even fallback failed: ${fallbackError.message}")
                result.error("SAVE_ERROR", "Failed to save file: ${e.message}", null)
            }
        }
    }
    
    private fun getPathFromUri(uri: Uri): String {
        // Try to get the display name from the URI
        val contentResolver = context.contentResolver
        val cursor = contentResolver.query(uri, null, null, null, null)
        
        cursor?.use {
            if (it.moveToFirst()) {
                val displayNameIndex = it.getColumnIndex(DocumentsContract.Document.COLUMN_DISPLAY_NAME)
                if (displayNameIndex >= 0) {
                    val displayName = it.getString(displayNameIndex)
                    Log.d(TAG, "Found display name: $displayName")
                    return displayName
                }
            }
        }
        
        // Fallbacks if we can't get the display name
        val lastPathSegment = uri.lastPathSegment
        if (!lastPathSegment.isNullOrEmpty()) {
            return lastPathSegment
        }
        
        return "document.ipynb"
    }
    
    private fun readTextFromUri(uri: Uri): String {
        Log.d(TAG, "Reading text from URI: $uri")
        
        return context.contentResolver.openInputStream(uri)?.use { inputStream ->
            inputStream.bufferedReader().use { it.readText() }
        } ?: ""
    }

    fun onDetachedFromEngine() {
        channel.setMethodCallHandler(null)
    }
}
