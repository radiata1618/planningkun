import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../commonLogic/commonLogic.dart';
import '../commonLogic/commonUI.dart';
import 'calendarEntity.dart';
import 'calendarLogic.dart';

class Calendar extends ConsumerStatefulWidget  {
  Calendar({
    Key? key,
  }) : super(key: key);

  @override
  CalendarState createState() => CalendarState();
}

class CalendarState extends ConsumerState<Calendar> {

  @override
  void initState() {
    super.initState();

    //必要に応じ初期処理追加
  }

  @override
  Widget build(BuildContext context) {
    if (ref.watch(calendarDataProvider).initialProcessFlg) {
      ref.read(calendarDataProvider.notifier).initialize();
    }

    return Scaffold(
        body: SafeArea(
            child: Container(
                child: SfCalendar(
                    view: CalendarView.week,
                    monthViewSettings: MonthViewSettings(showAgenda: true),
                    dataSource: MeetingDataSource(
                        ref.watch(calendarDataProvider).appointmentListData),
                    onTap: (calendarDetails) {
                      _fabPressed(context, calendarDetails,ref);
                    }))));
  }

  void _fabPressed(BuildContext context, CalendarTapDetails calendarDetails,WidgetRef ref) {
    ref.read(calendarDataProvider.notifier).setCalendarTitle("");
    ref.read(calendarDataProvider.notifier).setSelectedDateTimeFrom(calendarDetails.date!);
    ref.read(calendarDataProvider.notifier).setSelectedDateTimeTo(calendarDetails.date!.add(Duration(hours: 1)));

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, StateSetter setState) {
            return Container(
              height: 200,
              child: Column(
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    graySmallIconButton(
                        icon: Icons.clear,
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                    smallOrangeRoundButton(text: "save", onPressed: () async{
                      await ref.read(calendarDataProvider.notifier).insertAppointmentData(ref);
                      Navigator.of(context).pop();
                    }),
                  ]),
                  borderedTextBox(
                    text: "title",
                    onChanged: (String value) {
                      ref.read(calendarDataProvider.notifier).setCalendarTitle(value);
                    },
                    passwordSecure: false,
                  ),
                  dateTimeRow(ref,context,"from",setState),
                  dateTimeRow(ref,context,"to",setState),
                ],
              ),
            );
          },
        );
      },
    );
  }
}


Widget dateTimeRow(WidgetRef ref,BuildContext context,String fromTo,StateSetter setState){

  log("XXXXXXX構築");
  DateTime dateTime =(fromTo=="from"?ref.watch(calendarDataProvider).selectedDateTimeFrom:ref.watch(calendarDataProvider).selectedDateTimeTo);
  return    Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical:8),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      GestureDetector(
          child: grayBiggerTextRight(
            text: fromDateToYearMonthDayText(dateTime),
          ),
          onTap: () async{
            log("XXXXXXXタップした　日付");
            final DateTime? d = await showDatePicker(
              context: context,
                initialDate: dateTime,
                firstDate: DateTime(dateTime.add(Duration(days:-30)).year,dateTime.add(Duration(days:-30)).month,dateTime.add(Duration(days:-30)).day),
                lastDate: DateTime(dateTime.add(Duration(days:30)).year,dateTime.add(Duration(days:30)).month,dateTime.add(Duration(days:30)).day),
            );
            if (d != null) {
              setState(() {
              if(fromTo=="from"){
                ref.read(calendarDataProvider.notifier).setSelectedDateTimeFrom(new DateTime(d.year,d.month,d.day,dateTime.hour,dateTime.minute));
                ref.read(calendarDataProvider.notifier).setSelectedDateTimeTo(new DateTime(d.year,d.month,d.day,dateTime.hour,dateTime.minute));
              }else{

                ref.read(calendarDataProvider.notifier).setSelectedDateTimeTo(new DateTime(d.year,d.month,d.day,dateTime.hour,dateTime.minute));
              }
              });
            }


          }
          ),
      GestureDetector(
          child: grayBiggerTextRight(
            text: fromDateToHourMinuteText(dateTime),
          ),
          onTap: () async{
            log("XXXXXXXタップした　時間");
            final TimeOfDay? t = await showTimePicker(
              context: context,
              initialTime: TimeOfDay(hour: dateTime.hour, minute: dateTime.minute ),
            );
            if (t != null) {
              setState(() {
              if(fromTo=="from"){
                log("XXXXXXXFrom時間修正");
                ref.read(calendarDataProvider.notifier).setSelectedDateTimeFrom(new DateTime(dateTime.year,dateTime.month,dateTime.day,t.hour,t.minute));
                //ref.read(calendarDataProvider.notifier).setSelectedDateTimeTo(new DateTime(dateTime.year,dateTime.month,dateTime.day,t.hour,t.minute)).add(Duration(hours: 1));
              }else{
                ref.read(calendarDataProvider.notifier).setSelectedDateTimeTo(new DateTime(dateTime.year,dateTime.month,dateTime.day,t.hour,t.minute));
              }
              });
            }

          }),
    ]),
  );
}