import 'package:flutter/material.dart';
import 'package:call_log/call_log.dart';

class ContactDetailsScreen extends StatelessWidget {
  final CallLogEntry call;

  ContactDetailsScreen(this.call);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(call.name ?? 'Unknown'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Number'),
            subtitle: Text(call.number ?? 'Unknown'),
          ),
          ListTile(
            title: Text('Duration'),
            subtitle: Text(_formatDuration(call.duration)),
          ),
          ListTile(
            title: Text('Timestamp'),
            subtitle: Text(_formatDateTime(call.timestamp ?? 0)),
          ),
          ListTile(
            title: Text('Status'),
            subtitle: Text(_getCallStatus(call)),
          ),
        ],
      ),
    );
  }

  String _formatDuration(int? durationInSeconds) {
    if (durationInSeconds == null) {
      return 'Unknown';
    }
    // Format duration into HH:MM:SS format
    final Duration d = Duration(seconds: durationInSeconds);
    return '${d.inHours.toString().padLeft(2, '0')}:${d.inMinutes.remainder(60).toString().padLeft(2, '0')}:${d.inSeconds.remainder(60).toString().padLeft(2, '0')}';
  }

  String _formatDateTime(int timestamp) {
    // Format timestamp into HH:MM:SS format
    final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}';
  }

  String _getCallStatus(CallLogEntry call) {
    // Determine call status based on duration and call type
    if (call.duration == 0) {
      if (call.callType == CallType.incoming) {
        return 'Missed';
      } else {
        return 'Rejected';
      }
    } else {
      return 'Answered';
    }
  }
}
