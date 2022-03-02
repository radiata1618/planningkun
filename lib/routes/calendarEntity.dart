import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planningkun/routes/calendarLogic.dart';

final calendarDataProvider = ChangeNotifierProvider(
      (ref) => CalendarNotifier(),
);
class CalendarNotifier extends ChangeNotifier {
  List<Meeting> _meetingListData = [];
  get meetingListData => _meetingListData;

  bool _initialProcessFlg =true;
  get initialProcessFlg=> _initialProcessFlg;

  DateTime _selectedDateTimeFrom =new DateTime.now() ;
  DateTime _selectedDateTimeTo =new DateTime.now() ;

  get selectedDateTimeFrom=> _selectedDateTimeFrom;
  get selectedDateTimeTo=> _selectedDateTimeTo;

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
    _meetingListData.add(Meeting(
        'Conference', startTime, endTime, const Color(0xFF0F8644), false));
  }
}

