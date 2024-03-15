import 'package:flutter/material.dart';
import 'screens/dialpad_screen.dart';
import 'screens/call_log_screen.dart';

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
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: Text('Voila_Call'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Call Log'),
              Tab(text: 'Dialpad'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            CallLogScreen(),
            DialpadScreen(),
          ],
        ),
      ),
    );
  }
}
