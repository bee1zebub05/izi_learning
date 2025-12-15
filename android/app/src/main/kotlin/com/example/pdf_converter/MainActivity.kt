package com.fau.pdf_converter

import android.content.Intent
import android.os.Bundle
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant 

class MainActivity : FlutterActivity(){

    //FileManagerPlugin
    private val FILE_MANAGER_CHANNEL = "com.fau.pdf_converter"
    private lateinit var fileManagerPlugin: FileManagerPlugin
    private val TAG = "MainActivity"

    override fun onCreate(savedInstanceState: Bundle?) {
        // Change back to normal theme before creating the view
        // This prevents the default Android splash screen from showing
        setTheme(R.style.NormalTheme)
        super.onCreate(savedInstanceState)
        Log.d(TAG, "MainActivity created")
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        Log.d(TAG, "Configuring Flutter Engine")

        //pluginFlutter ( url_launcher ..)
        //GeneratedPluginRegistrant.registerWith(flutterEngine)
        
        // Initialize and register FileManagerPlugin
        fileManagerPlugin = FileManagerPlugin(applicationContext)
        fileManagerPlugin.setActivity(this)
        fileManagerPlugin.onAttachedToEngine(flutterEngine, FILE_MANAGER_CHANNEL)
        
        Log.d(TAG, "FileManagerPlugin initialized with channel: $FILE_MANAGER_CHANNEL")
    }
    
    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        Log.d(TAG, "onActivityResult: requestCode=$requestCode, resultCode=$resultCode")
        val handled = fileManagerPlugin.onActivityResult(requestCode, resultCode, data)
        Log.d(TAG, "Activity result handled by plugin: $handled")
    }

    override fun onDestroy() {
        super.onDestroy()
        fileManagerPlugin.onDetachedFromEngine()
        Log.d(TAG, "MainActivity destroyed")
    }
}