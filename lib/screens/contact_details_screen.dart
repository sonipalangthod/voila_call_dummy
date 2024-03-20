import 'package:flutter/material.dart';
import 'package:call_log/call_log.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class ContactDetailsScreen extends StatefulWidget {
  final CallLogEntry call;

  ContactDetailsScreen(this.call);

  @override
  _ContactDetailsScreenState createState() => _ContactDetailsScreenState();
}

class _ContactDetailsScreenState extends State<ContactDetailsScreen> {
  late List<CallLogEntry> callLogEntries;

  @override
  void initState() {
    super.initState();
    _fetchCallLogEntries();
  }

  Future<void> _fetchCallLogEntries() async {
    Iterable<CallLogEntry> callLogs = await CallLog.get();
    setState(() {
      callLogEntries = callLogs.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.call.name ?? 'Unknown'),
      ),
      body: ListView.builder(
        itemCount: callLogEntries.length,
        itemBuilder: (context, index) {
          final callLogEntry = callLogEntries[index];
          return _buildCallHistoryTile(callLogEntry);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _makeCall(widget.call.number ?? '');
        },
        child: Icon(Icons.call),
      ),
    );
  }

  Widget _buildCallHistoryTile(CallLogEntry callLogEntry) {
    IconData icon;
    Color iconColor;
    String status;
    if (callLogEntry.callType == CallType.incoming) {
      icon = Icons.phone;
      iconColor = Colors.green;
      status = callLogEntry.duration == 0 ? 'Missed' : 'Answered';
    } else {
      icon = Icons.call_made; // Change to Icons.call_made for outgoing calls
      iconColor = Colors.red;
      status = callLogEntry.duration == 0 ? 'Rejected' : 'Answered';
    }

    return Column(
      children: [
        ListTile(
          title: Text(_formatDateTime(callLogEntry.timestamp ?? 0)),
          subtitle: Text('Duration: ${_formatDuration(callLogEntry.duration)} | Status: $status'),
          trailing: Icon(
            icon,
            color: iconColor,
          ),
        ),
        Divider(
          height: 1,
          color: Colors.grey,
          thickness: 1,
          indent: 16,
          endIndent: 16,
        ),
      ],
    );
  }



  String _formatDuration(int? durationInSeconds) {
    if (durationInSeconds == null) {
      return 'Unknown';
    }
    final Duration d = Duration(seconds: durationInSeconds);
    return '${d.inHours.toString().padLeft(2, '0')}:${d.inMinutes.remainder(60).toString().padLeft(2, '0')}:${d.inSeconds.remainder(60).toString().padLeft(2, '0')}';
  }

  String _formatDateTime(int timestamp) {
    final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return '${DateFormat('EEEE, MMMM d, y').format(dateTime)} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}';
  }

  void _makeCall(String number) {
    launch('tel:$number');
  }
}
