# autostarter

A Flutter Plugin for bringing up the autostart permission of a phone.

## Getting Started

Add Dependency

    dependencies:
  	    autostarter: ^0.0.1

Import
    
    import 'package:autostarter/autostarter.dart';
    
   
Example
        
    class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _messangerKey = GlobalKey<ScaffoldMessengerState>();
  @override
  void initState() {
    super.initState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> getAutoStartPermission() async {
    try {
      bool? isAvailable = await Autostarter.isAutoStartPermissionAvailable();
      if (isAvailable!) {
        await Autostarter.getAutoStartPermission();
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
 
 Thanks to Android Native Author :
 
    https://github.com/judemanutd/AutoStarter

# autostarter
