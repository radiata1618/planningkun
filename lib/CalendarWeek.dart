import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'firebase_config.dart';
import 'tabs_page.dart';

//Future<void> calendarWeek() async {
//  WidgetsFlutterBinding.ensureInitialized();
//  await Firebase.initializeApp(options: DefaultFirebaseConfig.platformOptions);
//  runApp(const MyApp());
//}

class CalendarWeek extends StatefulWidget {
  @override
  _CalendarWeek createState() => _CalendarWeek();
}

class _CalendarWeek extends State<CalendarWeek> {
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
