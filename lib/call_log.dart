import 'package:call_log/call_log.dart';

class CallLogService {
  static Future<List<CallLogEntry>> getCallLogs() async {
    try {
      Iterable<CallLogEntry> callLogs = await CallLog.get();
      return callLogs.toList();
    } catch (e) {
      print('Error fetching call logs: $e');
      return [];
    }
  }
}
