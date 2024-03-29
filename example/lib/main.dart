import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:autostarter/autostarter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _messangerKey = GlobalKey<ScaffoldMessengerState>();

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> getAutoStartPermission() async {
    try {
      bool? isAvailable = await Autostarter.isAutoStartPermissionAvailable();
      if (isAvailable!) {
        var status = await Autostarter.checkAutoStartState();
        print(status);
        if(status == null){

        }else{
          if(status == false){
              await Autostarter.getAutoStartPermission(
                newTask: true,
              );
            }else{
               _messangerKey.currentState?.showSnackBar(
                SnackBar(content: Text('You have already allowed the AutoStart Permission'))
              );
            }
        }
            


      } else {
        _messangerKey.currentState!.showSnackBar(SnackBar(
            content: Text(
                'Your phone don\'t need to request Auto Start Permission')));
      }
    } on PlatformException {
      _messangerKey.currentState!.showSnackBar(
          SnackBar(content: Text('Failed to get platform version')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: _messangerKey,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('AutoStarter Plugin example app'),
        ),
        body: Center(
          child: TextButton(
            style: TextButton.styleFrom(
                backgroundColor: Colors.blue, primary: Colors.white),
            onPressed: () {
              getAutoStartPermission();
            },
            child: Text('Request Auto Start Permission'),
          ),
        ),
      ),
    );
  }
}
