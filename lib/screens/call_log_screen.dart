import 'package:flutter/material.dart';
import 'package:call_log/call_log.dart';
import 'contact_details_screen.dart'; // Import the ContactDetailsScreen

class CallLogScreen extends StatefulWidget {
  @override
  _CallLogScreenState createState() => _CallLogScreenState();
}

class _CallLogScreenState extends State<CallLogScreen> {
  List<CallLogEntry> _callLogs = [];

  @override
  void initState() {
    super.initState();
    _fetchCallLogs();
  }

  Future<void> _fetchCallLogs() async {
    // Fetch call logs using the call_log package
    Iterable<CallLogEntry> callLogs = await CallLog.get();
    setState(() {
      _callLogs = callLogs.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Call Log'),
      ),
      body: ListView.builder(
        itemCount: _callLogs.length,
        itemBuilder: (context, index) {
          final call = _callLogs[index];
          return ListTile(
            title: Text(call.name ?? 'Unknown'),
            subtitle: Text(call.number ?? 'Unknown'),
            trailing: Text(_formatTimestamp(call.timestamp)),

            onTap: () {
              // Navigate to ContactDetailsScreen when tapped
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ContactDetailsScreen(call),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

String _formatTimestamp(int? timestamp) {
  if (timestamp == null) {
    return 'Unknown';
  }
  final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
  return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}';
}