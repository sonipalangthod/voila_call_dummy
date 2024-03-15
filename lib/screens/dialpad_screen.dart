import 'package:flutter/material.dart';
import 'package:call_log/call_log.dart';
import 'package:url_launcher/url_launcher.dart'; // Import the url_launcher package
import 'package:voila_call_dummy/services/call_service.dart'; // Update with your actual project directory
import 'package:voila_call_dummy/widgets/custom_dialpad.dart'; // Import your custom dialpad widget

class DialpadScreen extends StatefulWidget {
  @override
  _DialpadScreenState createState() => _DialpadScreenState();
}

class _DialpadScreenState extends State<DialpadScreen> {
  List<CallLogEntry> _callLogs = [];
  List<String> _enteredDigits = [];

  @override
  void initState() {
    super.initState();
    _fetchCallLogs();
  }

  Future<void> _fetchCallLogs() async {
    List<CallLogEntry> callLogs = await CallLogService.getCallLogs();
    setState(() {
      _callLogs = callLogs;
    });
  }

  void _handleDigitPressed(String digit) {
    setState(() {
      _enteredDigits.add(digit);
    });
  }

  void _handleClearPressed() {
    setState(() {
      if (_enteredDigits.isNotEmpty) {
        _enteredDigits.removeLast();
      }
    });
  }

  void _makeCall() {
    String phoneNumber = _enteredDigits.join();
    // Use the url_launcher package to make the call
    launch('tel:$phoneNumber');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dialpad'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _callLogs.length,
              itemBuilder: (context, index) {
                CallLogEntry log = _callLogs[index];
                return ListTile(
                  title: Text(log.name ?? 'Unknown'),
                  subtitle: Text(log.number ?? 'Unknown'),
                  trailing: Text(log.timestamp?.toString() ?? 'Unknown'),
                );
              },
            ),
          ),
          Text(
            _enteredDigits.join(), // Display entered digits
            style: TextStyle(fontSize: 20),
          ),
          CustomDialpad(
            onDigitPressed: _handleDigitPressed,
            onClearPressed: _handleClearPressed,
            onCallPressed: _makeCall,
          ),
        ],
      ),
    );
  }
}
