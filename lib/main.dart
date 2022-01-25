// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_config.dart';
import 'tabs_page.dart';
import 'calendarWeek.dart';
import 'login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseConfig.platformOptions);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
  FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Analytics Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorObservers: <NavigatorObserver>[observer],
      home: MyHomePage(
        title: 'Firebase Analytics Demo',
        analytics: analytics,
        observer: observer,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key? key,
    required this.title,
    required this.analytics,
    required this.observer,
  }) : super(key: key);

  final String title;
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _message = '';


  List<String> _contents=[];
  @override
  void initState(){
  }


  Future<void> _insertMessage() async {
    // addによるドキュメントIDを指定しない追加
    // この場合は、ドキュメントIDはハッシュ値が払い出されます
    FirebaseFirestore.instance.collection('message').add({'content': _message});
  }


    void _deleteMessage() async {
      final messages = await FirebaseFirestore.instance.collection("message").get();
      for (var message in messages.docs) {
        print(message.reference.id);
        FirebaseFirestore.instance.collection("message").doc(message.reference.id).delete();
      }
    }
  void _selectMessage() async {


    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('message').get();
    for(var i = 0; i < snapshot.docs.length; i++){
      _contents.add(snapshot.docs[i].get('content'));
      print(_contents[i]);
    }

    setState((){});

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Text(
            "",
            style: const TextStyle(color: Color.fromARGB(255, 0, 155, 0)),
          ),
          TextFormField(
            onChanged: (value) {
              _message = value;
            },),
          MaterialButton(
            onPressed: _insertMessage,
            child: const Text('メッセージ登録'),
          ),
          MaterialButton(
            onPressed: _deleteMessage,
            child: const Text('メッセージ削除'),
          ),
          MaterialButton(
            onPressed: _selectMessage,
            child: const Text('メッセージ表示')//,
          ),
          MaterialButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CalendarWeek(
                        //argumentMode: 2,
                        //argumentBusinessYear: year,
                    ),
                  ),
                );
              },
              child: const Text('カレンダー画面')//,
          ),
          MaterialButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => login(
                      //argumentMode: 2,
                      //argumentBusinessYear: year,
                    ),
                  ),
                );
              },
              child: const Text('ログイン画面')//,
          ),
          ListView.builder(
            padding: EdgeInsets.all(36.0),
            shrinkWrap: true,
            itemCount: _contents.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                color: Colors.green,
                child: Text(
                  _contents[index],
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25.0),
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute<TabsPage>(
              settings: const RouteSettings(name: TabsPage.routeName),
              builder: (BuildContext context) {
                return TabsPage(widget.observer);
              },
            ),
          );
        },
        child: const Icon(Icons.tab),
      ),
    );
  }
}