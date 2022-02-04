import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
class Home extends StatefulWidget {
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
  FirebaseAnalyticsObserver(analytics: analytics);


  DateTime? startDateTime;
  DateTime? endDateTime ;
  int status = 1;//1:スタート時間を選択中、2:エンド時間を選択中

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: SfCalendar(
              view: CalendarView.week,
            )));
  }
}