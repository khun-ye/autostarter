package com.ytn.autostarter

import android.content.Context
import androidx.annotation.NonNull
import com.judemanutd.autostarter.AutoStartPermissionHelper
import io.flutter.embedding.android.FlutterActivity

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** AutostarterPlugin */
class AutostarterPlugin: FlutterPlugin, MethodCallHandler, FlutterActivity() {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var context : Context

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "autostarter")
    channel.setMethodCallHandler(this)
    context = flutterPluginBinding.applicationContext
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if(call.method == "isAutoStartPermissionAvailable"){
      val autoStartAvailable = AutoStartPermissionHelper.getInstance().isAutoStartPermissionAvailable(context)
      result.success(autoStartAvailable)
    } else if(call.method == "getAutoStartPermission"){
      val arguments = call.arguments as HashMap<String, Boolean>
      val open: Boolean = arguments["open"] as Boolean
      val newTask: Boolean =  arguments["newTask"] as Boolean

      if(open){
        val success = AutoStartPermissionHelper.getInstance().getAutoStartPermission(context, open = true)
        result.success(success)
      }else if(newTask){
        val success = AutoStartPermissionHelper.getInstance().getAutoStartPermission(context, newTask = true)
        result.success(success)
      }else if(open && newTask){
        val success = AutoStartPermissionHelper.getInstance().getAutoStartPermission(context, open = true, newTask = true)
        result.success(success)
      }else{
        val success = AutoStartPermissionHelper.getInstance().getAutoStartPermission(context)
        result.success(success)
      }


    }
    else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
