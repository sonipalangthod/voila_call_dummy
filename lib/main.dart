import 'package:flutter/material.dart';
import 'package:voila_call_dummy/screens/call_log_screen.dart';
import 'package:voila_call_dummy/screens/dialpad_screen.dart';
import 'package:voila_call_dummy/screens/voila_call_screen.dart';
import 'package:voila_call_dummy/screens/statistics_page.dart'; // Import your statistics page
import 'package:voila_call_dummy/screens/call_log_screen.dart';
void main() {
  runApp(CallLogApp() as Widget);
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
      length: 4, // Increase the length to accommodate the new tab
      child: Scaffold(
        appBar: AppBar(
          title: Text('Voila_Call'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Call Log'),
              Tab(text: 'Dialpad'),
              Tab(text: 'Status of call'),
              Tab(text: 'Statistics'), // Add a new tab for the statistics page
            ],
          ),
        ),
        body: TabBarView(
          children: [
            CallLogScreen(),
            DialpadScreen(),
            VoilaCallScreen(phoneNumber: '0000000000'),
            StatisticsPage(), // Add the statistics page as a tab
          ],
        ),
      ),
    );
  }
}