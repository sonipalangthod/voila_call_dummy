// main.dart
import 'package:flutter/material.dart';
import 'package:voila_call_dummy/screens/call_log_screen.dart';
import 'package:voila_call_dummy/screens/dialpad_screen.dart';
import 'package:voila_call_dummy/screens/voila_call_screen.dart';

void main() {
  runApp(CallLogApp());
}

class CallLogApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Call Log App',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Voila_Call'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Call Log'),
              Tab(text: 'Dialpad'),
              Tab(text: 'Status of call'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            CallLogScreen(),
            DialpadScreen(),
            VoilaCallScreen(),
          ],
        ),
      ),
    );
  }
}
