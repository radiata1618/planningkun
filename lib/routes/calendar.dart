import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../commonLogic/commonLogic.dart';
import '../commonLogic/commonUI.dart';
import 'calendarEntity.dart';
import 'calendarLogic.dart';

class Calendar extends ConsumerWidget {
  Calendar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                        ref.watch(calendarDataProvider).meetingListData),
                    onTap: (calendarDetails) {
                      _fabPressed(context, calendarDetails,ref);
                    }))));
  }

  void _fabPressed(BuildContext context, CalendarTapDetails calendarDetails,WidgetRef ref) {
    String title = "";
    ref.read(calendarDataProvider.notifier).setSelectedDateTimeFrom(calendarDetails.date!);
    ref.read(calendarDataProvider.notifier).setSelectedDateTimeTo(calendarDetails.date!.add(Duration(hours: 1)));

    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: 200,
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              graySmallIconButton(
                  icon: Icons.clear,
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
              smallOrangeRoundButton(text: "save", onPressed: () {}),
            ]),
            borderedTextBox(
              text: "title",
              onChanged: (String value) {
                title = value;
              },
              passwordSecure: false,
            ),
            dateTimeRow(ref,context,"from"),
            dateTimeRow(ref,context,"to"),
          ],
        ),
      ),
    );
  }
}


Widget dateTimeRow(WidgetRef ref,BuildContext context,String fromTo){

  DateTime dateTime =(fromTo=="from"?ref.watch(calendarDataProvider).selectedDateTimeFrom:ref.watch(calendarDataProvider).selectedDateTimeTo);
  return    Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical:8),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      GestureDetector(
          child: grayBiggerTextRight(
            text: fromDateToYearMonthDayText(dateTime),
          ),
          onTap: () async{
            final DateTime? d = await showDatePicker(
              context: context,
                initialDate: dateTime,
                firstDate: DateTime(dateTime.add(Duration(days:-30)).year,dateTime.add(Duration(days:-30)).month,dateTime.add(Duration(days:-30)).day),
                lastDate: DateTime(dateTime.add(Duration(days:30)).year,dateTime.add(Duration(days:30)).month,dateTime.add(Duration(days:30)).day),
            );
            if (d != null) {
              if(fromTo=="from"){
                ref.read(calendarDataProvider.notifier).setSelectedDateTimeFrom(new DateTime(d.year,d.month,d.day,dateTime.hour,dateTime.minute));
              }else{
                ref.read(calendarDataProvider.notifier).setSelectedDateTimeTo(new DateTime(d.year,d.month,d.day,dateTime.hour,dateTime.minute));
              }
            }

          }
          ),
      GestureDetector(
          child: grayBiggerTextRight(
            text: fromDateToHourMinuteText(dateTime),
          ),
          onTap: () async{
            final TimeOfDay? t = await showTimePicker(
              context: context,
              initialTime: TimeOfDay(hour: dateTime.hour, minute: dateTime.minute ),
            );
            if (t != null) {
              dateTime=new DateTime(dateTime.year,dateTime.month,dateTime.day,t.hour,t.minute);
            }

          }),
    ]),
  );
}