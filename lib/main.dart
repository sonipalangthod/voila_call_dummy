import 'package:flutter/material.dart';
import 'screens/dialpad_screen.dart';

void main() {
  runApp(CallLogApp());
}

class CallLogApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Call Log App',
      debugShowCheckedModeBanner: false,
      home: DialpadScreen(), // Navigate to DialpadScreen
    );
  }
}
