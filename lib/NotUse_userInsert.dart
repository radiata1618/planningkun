import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'firebase_config.dart';
import 'NotUse_tabs_page.dart';


class UserInsert extends StatefulWidget {
  @override
  final argumentEmail;

  UserInsert({this.argumentEmail});
  _UserInsert createState() => _UserInsert();
}

class _UserInsert extends State<UserInsert> {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
  FirebaseAnalyticsObserver(analytics: analytics);


  Future<void> _insertUser() async {
    // addによるドキュメントIDを指定しない追加
    // この場合は、ドキュメントIDはハッシュ値が払い出されます
    FirebaseFirestore.instance.collection('users').add(
      {'email': email, 'name': name, 'age': age},
    );
  }

  String email="";
  String name="";
  int age=0;

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
                decoration: InputDecoration(labelText: "メールアドレス"),
                onChanged: (String value) {
                  setState(() {
                    email = value;
                  });
                },
              ),
              TextFormField(
                // テキスト入力のラベルを設定
                decoration: InputDecoration(labelText: "名前"),
                onChanged: (String value) {
                  setState(() {
                    name = value;
                  });
                },
              ),
              const SizedBox(height: 8),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "年齢"),
                obscureText: true,
                onChanged: (String value) {
                  setState(() {
                    age = int.parse(value);
                  });
                },
              ),
              ElevatedButton(
                onPressed: _insertUser,
                child: const Text('ユーザ情報登録'),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
