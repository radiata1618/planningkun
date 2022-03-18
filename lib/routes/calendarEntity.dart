import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planningkun/routes/calendarLogic.dart';

import '../commonEntity/userEntity.dart';

final calendarDataProvider = ChangeNotifierProvider(
      (ref) => CalendarNotifier(),
);
class CalendarNotifier extends ChangeNotifier {
  List<Meeting> _appointmentListData = [];
  get appointmentListData => _appointmentListData;

  bool _initialProcessFlg =true;
  get initialProcessFlg=> _initialProcessFlg;

  String _calendarTitle = "";
  get calendarTitle=> _calendarTitle;


  DateTime _selectedDateTimeFrom =new DateTime.now() ;
  DateTime _selectedDateTimeTo =new DateTime.now() ;

  get selectedDateTimeFrom=> _selectedDateTimeFrom;
  get selectedDateTimeTo=> _selectedDateTimeTo;

  setCalendarTitle(String calendarTitle){
    _calendarTitle=calendarTitle;
  }

  setSelectedDateTimeFrom(DateTime dateTime){
    _selectedDateTimeFrom=dateTime;
  }

  setSelectedDateTimeTo(DateTime dateTime){
    _selectedDateTimeTo=dateTime;
  }

  void initialize(){
    _initialProcessFlg=false;

    final DateTime today = DateTime.now();
    final DateTime startTime =
    DateTime(today.year, today.month, today.day, 9, 0, 0);
    final DateTime endTime = startTime.add(const Duration(hours: 2));
    _appointmentListData.add(Meeting(
        'Conference', startTime, endTime, const Color(0xFF0F8644), false));
  }

  Future<void> insertAppointmentData(WidgetRef ref )async {
    await FirebaseFirestore.instance.collection('appointments').add(
      {'userDocId':ref.watch(userDataProvider).userData["userDocId"],
        'friendUserDocId': "friendId",
        'friendUserName': "フレンド",
        'title': _calendarTitle,
        'fromTime': Timestamp.fromDate(_selectedDateTimeFrom),
        'toTime': Timestamp.fromDate(_selectedDateTimeTo),
        'lastMessageTime': FieldValue.serverTimestamp(),
        'insertUserDocId':ref.watch(userDataProvider).userData["userDocId"],
        'insertProgramId': "calendar",
        'insertTime': FieldValue.serverTimestamp(),
        'updateUserDocId':ref.watch(userDataProvider).userData["userDocId"],
        'updateProgramId': "calendar",
        'updateTime': FieldValue.serverTimestamp(),
        'readableFlg': true,
        'deleteFlg': false,
      },
    );

  }

}

