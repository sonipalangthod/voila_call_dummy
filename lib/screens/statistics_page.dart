import 'package:flutter/material.dart';
import 'package:call_log/call_log.dart';
import 'package:pie_chart/pie_chart.dart';
import 'leads_information_page.dart';
import 'package:flutter/material.dart';


class StatisticsPage extends StatefulWidget {
  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  List<CallLogEntry> _callLogs = [];
  int _totalDialedCalls = 0;
  int _totalConnectedCalls = 0;
  int _totalNotConnectedCalls = 0;
  int _totalTalkTime = 0;
  double _averageTalkTime = 0;

  @override
  void initState() {
    super.initState();
    _fetchCallLogs();
  }

  Future<void> _fetchCallLogs() async {
    Iterable<CallLogEntry> callLogs = await CallLog.get();
    setState(() {
      _callLogs = callLogs.toList();
      _computeStatistics();
    });
  }

  void _computeStatistics() {
    _totalDialedCalls = _callLogs.length;
    _totalConnectedCalls = _callLogs.where((call) => (call.duration ?? 0) > 0).length;
    _totalNotConnectedCalls = _callLogs.where((call) => (call.duration ?? 0) == 0).length;

    _totalTalkTime = _callLogs.fold(0, (total, call) => total + (call.duration ?? 0));
    if (_totalDialedCalls > 0) {
      _averageTalkTime = _totalTalkTime / _totalDialedCalls;
    } else {
      _averageTalkTime = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Set the length property to 2
      child: Scaffold(
        appBar: AppBar(
          title: Text('Statistics'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Connected Calls'),
              Tab(text: 'Incoming/Outgoing Calls'),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: TabBarView(
                children: [
                  _buildConnectedCallsTab(),
                  _buildInOutCallsTab(),
                ],
              ),
            ),
            _buildCommonStatistics(),
            TextButton(
              onPressed: _navigateToLeadsInformationPage,
              child: Text('View Leads Information'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConnectedCallsTab() {
    Map<String, double> connectedCallsData = {
      'Connected': _totalConnectedCalls.toDouble(),
      'Not Connected': _totalNotConnectedCalls.toDouble(),
    };
    List<Color> colorList = [
      Colors.green, // Color for 'Incoming' segment
      Colors.red, // Color for 'Outgoing' segment
    ];

    return Padding(
      padding: EdgeInsets.all(16.0),
      child: PieChart(
        dataMap: connectedCallsData,
        animationDuration: Duration(milliseconds: 800),
        chartLegendSpacing: 32,
        chartRadius: MediaQuery.of(context).size.width / 2,
        initialAngleInDegree: 0,
        chartType: ChartType.ring,
        ringStrokeWidth: 32,
        centerText: "CALL STATUS",
        legendOptions: LegendOptions(
          showLegendsInRow: false,
          legendPosition: LegendPosition.bottom,
          showLegends: true,
          legendTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        chartValuesOptions: ChartValuesOptions(
          showChartValueBackground: true,
          showChartValues: true,
          showChartValuesInPercentage: false,
          showChartValuesOutside: false,
          decimalPlaces: 0,
        ),
        colorList: colorList,
      ),
    );
  }

  Widget _buildInOutCallsTab() {
    int totalIncomingCalls = _callLogs.where((call) => call.callType == CallType.incoming).length;
    int totalOutgoingCalls = _callLogs.where((call) => call.callType == CallType.outgoing).length;

    Map<String, double> inOutCallsData = {
      'Incoming': totalIncomingCalls.toDouble(),
      'Outgoing': totalOutgoingCalls.toDouble(),
    };
    List<Color> colorList = [
      Colors.blue, // Color for 'Incoming' segment
      Colors.green, // Color for 'Outgoing' segment
    ];
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: PieChart(
        dataMap: inOutCallsData,
        animationDuration: Duration(milliseconds: 800),
        chartLegendSpacing: 32,
        chartRadius: MediaQuery.of(context).size.width / 2,
        initialAngleInDegree: 0,
        chartType: ChartType.ring,
        ringStrokeWidth: 32,
        centerText: "CALL TYPE",
        legendOptions: LegendOptions(
          showLegendsInRow: false,
          legendPosition: LegendPosition.bottom,
          showLegends: true,
          legendTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        chartValuesOptions: ChartValuesOptions(
          showChartValueBackground: true,
          showChartValues: true,
          showChartValuesInPercentage: false,
          showChartValuesOutside: false,
          decimalPlaces: 0,
        ),
        colorList: colorList,
      ),
    );
  }

  Widget _buildCommonStatistics() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 10),
          _buildStatisticTile(Icons.phone, 'Total Dialed Calls', _totalDialedCalls),
          _buildStatisticTile(Icons.av_timer, 'Average Talk Time', _averageTalkTime),
          _buildStatisticTile(Icons.check_circle, 'Connected Calls', _totalConnectedCalls),
          _buildStatisticTile(Icons.cancel, 'Not Connected Calls', _totalNotConnectedCalls),
          _buildStatisticTile(Icons.timer, 'Total Talk Time', _totalTalkTime),
        ],
      ),
    );
  }

  Widget _buildStatisticTile(IconData icon, String title, dynamic value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).primaryColor),
          SizedBox(width: 10),
          Text(
            '$title: $value',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToLeadsInformationPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LeadsInformationPage()),
    );
  }
}