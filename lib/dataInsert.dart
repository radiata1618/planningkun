import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'firebase_config.dart';
import 'tabs_page.dart';
import 'userInsert.dart';


class DataInsert extends StatefulWidget {
  @override
  final argumentEmail;

  DataInsert({this.argumentEmail});
  _DataInsert createState() => _DataInsert();
}

class _DataInsert extends State<DataInsert> {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
  FirebaseAnalyticsObserver(analytics: analytics);

  Future<void> _insertMessage() async {
    // addによるドキュメントIDを指定しない追加
    // この場合は、ドキュメントIDはハッシュ値が払い出されます
    FirebaseFirestore.instance.collection('messages').add(
      {'email': widget.argumentEmail, 'content': content},
    );
  }

  String content="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(32),
          child: Column(
            children: <Widget>[
              ElevatedButton(
                onPressed: () async {
                      await Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) {
                          return UserInsert();
                        }),
                      );
                },
                child: const Text('ユーザ情報登録'),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
