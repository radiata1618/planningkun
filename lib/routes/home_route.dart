//import 'dart:html';

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
  DateTime? endDateTime;

  int status = 1; //1:スタート時間を選択中、2:エンド時間を選択中

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(child:Container(
            child: SfCalendar(
              view: CalendarView.month,
      //        dataSource: EventDataSource(_getDataSource()),
              monthViewSettings: MonthViewSettings(showAgenda: true),
            ))));
  }
}



//
//
//   List<Event> _getDataSource() {
//
// //データをまとめるリスト
// //    final List<Event> event = <Event>[];
//
// //データの用意
//     final DateTime today = DateTime.now();
//     final DateTime startTime =
//     DateTime(today.year, today.month, today.day, 9, 0, 0);
//     final DateTime endTime = startTime.add(const Duration(hours: 2));
//
// //データをリストに追加
//     //event.add(Event('イベント', startTime, endTime, const Color(0xFF0F8644), false));
//
//     return event;
//   }
//
// }
//
// class EventDataSource extends CalendarDataSource {
//
//   EventDataSource(List<Event> event) {
//     appointments = event;
//   }
//
// //イベントのカラー
//   @override
//   Color getColor(int index) {
//     return appointments![index].background;
//   }
//
// //イベントの終了時間
//   @override
//   DateTime getEndTime(int index) {
//     return appointments![index].to;
//   }
//
// //イベントの開始時間
//   @override
//   DateTime getStartTime(int index) {
//     return appointments![index].from;
//   }
//
// //イベントの名前
//   @override
//   String getSubject(int index) {
//     return appointments![index].eventName;
//   }
//
//   @override
//   bool isAllDay(int index) {
//     return appointments![index].isAllDay;
//   }
// }