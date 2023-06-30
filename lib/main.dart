import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:clima_app/screens/loading_screen.dart';

void main() {
  // Set log level to 'warning' to see warning and error messages in the console
  debugPrint = (String? message, {int? wrapWidth}) {
    debugPrintThrottled(message, wrapWidth: wrapWidth);
  };
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: LoadingScreen(),
    );
  }
}
