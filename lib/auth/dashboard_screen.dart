import 'package:flutter/material.dart';
import 'package:voila_call_dummy/screens/call_log_screen.dart';
import 'package:voila_call_dummy/screens/dialpad_screen.dart';
import 'package:voila_call_dummy/screens/voila_call_screen.dart';
import 'package:voila_call_dummy/screens/statistics_page.dart';
import 'package:voila_call_dummy/auth/login_screen.dart';

class DashboardScreen extends StatelessWidget {
  final String username;

  DashboardScreen({required this.username});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Voila_Call $username',style: TextStyle(color: Colors.white),),
          backgroundColor: Color(0xFF5E17EB), // Set AppBar color here
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              color: Color(-3404496),
              onPressed: () {
                _logout(context);
              },
            ),
          ],
          bottom: TabBar(
            tabs: [
              Tab (child: Text(
            'Call Log',
            style: TextStyle(color: Colors.white), // Set text color here
          ),
        ),
              Tab(child: Text(
                'Dial Pad',
                style: TextStyle(color: Colors.white), // Set text color here
              ),),
              Tab(child: Text(
                'CallStatus',
                style: TextStyle(color: Colors.white), // Set text color here
              ),),
              Tab(child: Text(
                'Statistics',
                style: TextStyle(color: Colors.white), // Set text color here
              ),),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            CallLogScreen(),
            DialpadScreen(),
            VoilaCallScreen(phoneNumber: '0000000000', callDuration: 0),
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
