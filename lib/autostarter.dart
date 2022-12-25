
import 'dart:async';

import 'package:flutter/services.dart';

class Autostarter {
  static const MethodChannel _channel = const MethodChannel('autostarter');

  static Future<bool?> isAutoStartPermissionAvailable() async{
    final bool? autoStartAvailable = await _channel.invokeMethod('isAutoStartPermissionAvailable');
    return autoStartAvailable;
  }

  /// [open] : If true, it will attempt to open the activity,
  /// otherwise it will just check its existence
  ///
  /// [newTask] : if true, the activity is attempted to be opened
  /// it will add FLAG_ACTIVITY_NEW_TASK to the intent
  static Future<void> getAutoStartPermission({
    bool open = false,
    bool newTask = false,
  }) async {
    Map<String, dynamic> args = <String, dynamic>{};
    args.putIfAbsent("open", () => open);
    args.putIfAbsent("newTask", () => newTask);

    await _channel.invokeMethod('getAutoStartPermission', args);
  }

  static Future<bool?> checkAutoStartState()async{
    return await _channel.invokeMethod("checkAutoStartPermissionState");
  }

  static Future<List<String>> getWhitelistedPackages() async{
    return List<String>.from(await _channel.invokeMethod("getWhitelistedPackages"));
  }

  static Future<dynamic> giveAutoStartPermission() async{
    return await _channel.invokeMethod("giveAutoStartPermission");
  }
}
