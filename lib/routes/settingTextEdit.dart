import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../firebase_config.dart';
import '../tabs_page.dart';

class SettingTextEdit extends StatefulWidget {
  final argumentItem;
  final argumentValue;

  SettingTextEdit({this.argumentItem,this.argumentValue});

  @override
  _SettingTextEdit createState() => _SettingTextEdit();
}

class _SettingTextEdit extends State<SettingTextEdit> {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
  FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    //TODO ChangeNotifierProviderによる変わった値のウィジェットのみを再生成する
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .canvasColor,
        elevation: .6,
        title: Text(
          widget.argumentItem,
          style: TextStyle(color: Colors.black87),
        ),
        iconTheme: IconThemeData(color: Colors.black87),
      ),

      body: SafeArea(
          child: Text("")),
    );
  }
}