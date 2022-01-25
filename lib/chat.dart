import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'firebase_config.dart';
import 'tabs_page.dart';


class Chat extends StatefulWidget {
  @override
  final argumentEmail;

  Chat({this.argumentEmail});
  _Chat createState() => _Chat();
}

class _Chat extends State<Chat> {
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
              TextFormField(
                // テキスト入力のラベルを設定
                decoration: InputDecoration(labelText: "メッセージ"),
                onChanged: (String value) {
                  setState(() {
                    content = value;
                  });
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    _insertMessage();
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //     builder: (context) => Chat(
                    //       argumentEmail: email,
                    //       //argumentBusinessYear: year,
                    //     ),
                    //   ),
                    // );
                  } catch (e) {}
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
