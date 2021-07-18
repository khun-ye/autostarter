
import 'dart:async';

import 'package:flutter/services.dart';

class Autostarter {
  static const MethodChannel _channel = const MethodChannel('autostarter');

  static Future<bool?> isAutoStartPermissionAvailable() async{
    final bool? autoStartAvailable = await _channel.invokeMethod('isAutoStartPermissionAvailable');
    return autoStartAvailable;
  }

  static Future<void> getAutoStartPermission() async{
    await _channel.invokeMethod('getAutoStartPermission');
  }
}
