import 'package:flutter/material.dart';
import 'package:voila_call_dummy/screens/call_log_screen.dart';
import 'package:voila_call_dummy/screens/dialpad_screen.dart';
import 'package:voila_call_dummy/screens/voila_call_screen.dart';
import 'package:voila_call_dummy/screens/statistics_page.dart';
import 'package:voila_call_dummy/auth/login_screen.dart'; // Import your login screen

class DashboardScreen extends StatelessWidget {
  final String username;

  DashboardScreen({required this.username});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Voila_Call $username'),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                _logout(context);
              },
            ),
          ],
          bottom: TabBar(
            tabs: [
              Tab(text: 'Call Log'),
              Tab(text: 'Dialpad'),
              Tab(text: 'Status of call'),
              Tab(text: 'Statistics'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            CallLogScreen(),
            DialpadScreen(),
            VoilaCallScreen(phoneNumber: '0000000000'),
            StatisticsPage(),
          ],
        ),
      ),
    );
  }

  void _logout(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

}