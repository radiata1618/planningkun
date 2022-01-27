import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'rootWidget.dart';

class Root extends StatefulWidget {
  final argumentEmail;

  Root({this.argumentEmail});

  @override
  _Root createState() => _Root();
}

class _Root extends State<Root> {
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
    return RootWidget(argumentEmail:widget.argumentEmail);
  }
}
