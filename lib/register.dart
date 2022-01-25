import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'chat.dart';

class Register extends StatefulWidget {
  @override
  final argumentEmail;

  Register({this.argumentEmail});

  _Register createState() => _Register();
}

class _Register extends State<Register> {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  String email = "";
  String name = "";
  int age = 0;

  Future<void> _insertUser() async {
    // addによるドキュメントIDを指定しない追加
    // この場合は、ドキュメントIDはハッシュ値が払い出されます
    FirebaseFirestore.instance.collection('users').add(
      {'email': widget.argumentEmail, 'name': name, 'age': age},
    );
  }

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
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () async {
                  try {
                    onPressed:
                    _insertUser;
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Chat(
                            argumentEmail: email,
                            //argumentBusinessYear: year,
                            ),
                      ),
                    );
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
