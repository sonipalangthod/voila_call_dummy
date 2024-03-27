import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:call_log/call_log.dart';
import 'package:voila_call_dummy/widgets/custom_dialpad.dart';
import 'package:voila_call_dummy/screens/voila_call_screen.dart';
import 'package:voila_call_dummy/services/call_service.dart';

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

  void _makeCall() async {
    String phoneNumber = _enteredDigits.join();

    bool? res = await FlutterPhoneDirectCaller.callNumber(phoneNumber);
    if (!res!) {
      // Handle error if call couldn't be initiated
      print('Error making call');
      return;
    }

    // Once the call is made, navigate to the VoilaCallScreen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VoilaCallScreen(phoneNumber: phoneNumber,callDuration: 0),
      ),
    );
  }

  void _makeCallToContact(String phoneNumber) async {
    bool? res = await FlutterPhoneDirectCaller.callNumber(phoneNumber);
    if (!res!) {
      // Handle error if call couldn't be initiated
      print('Error making call');
      return;
    }

    // Once the call is made, navigate to the VoilaCallScreen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VoilaCallScreen(phoneNumber: phoneNumber,callDuration: 0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dialpad'),
        automaticallyImplyLeading: false,
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
                  trailing: Text(_formatTimestamp(log.timestamp) ?? 'Unknown'),
                  onTap: () {
                    _makeCallToContact(log.number ?? '');
                  },
                );
              },
            ),
          ),

          CustomDialpad(
            onDigitPressed: _handleDigitPressed,
            onClearPressed: _handleClearPressed,
            onCallPressed: _makeCall,
            enteredDigits: _enteredDigits,// Assign the _makeCall function here
          ),
        ],
      ),
    );
  }
}

String? _formatTimestamp(int? timestamp) {
  if (timestamp == null) return null;
  final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
  final String hours = '${dateTime.hour}'.padLeft(2, '0');
  final String minutes = '${dateTime.minute}'.padLeft(2, '0');
  final String seconds = '${dateTime.second}'.padLeft(2, '0');
  return '$hours:$minutes:$seconds';
}