import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_config.dart';
import 'tabs_page.dart';

class Chat extends StatefulWidget {
  final argumentEmail;
  final argumentOppositeEmail;

  Chat({this.argumentEmail, this.argumentOppositeEmail});

  @override
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

  String content = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        elevation: .6,
        title: Text(
          widget.argumentOppositeEmail,
          style: TextStyle(color: Colors.black87),
        ),
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      body: SafeArea(
          child: Column(children: <Widget>[
        Expanded(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
            child: Column(
              children: <Widget>[
                rightBalloon(),
                leftBalloon(),
                rightBalloon(),
                leftBalloon(),
              ],
            ),
          ),
        ),
        textInputWidget(),
      ])),
    );
  }

  Padding rightBalloon(){
    return Padding(
      padding: const EdgeInsets.only(bottom: 28.0),
      child: Align(
          alignment: Alignment.centerRight,
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40),
                    topLeft: Radius.circular(40),
                    bottomLeft: Radius.circular(40),
                  ),
                  gradient: LinearGradient(
                      begin: FractionalOffset.topLeft,
                      end: FractionalOffset.bottomRight,
                      colors: [
                        const Color.fromARGB(255, 108, 132, 235),
                        const Color.fromARGB(255, 132, 199, 250),
                      ],
                      stops: const [
                        0.0,
                        1.0,
                      ])),
              child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text('メッセージ',
                      style: TextStyle(
                        color: Colors.white,
                      ))))),
    );
  }




  Padding leftBalloon(){
    return Padding(
      padding: const EdgeInsets.only(bottom: 28.0),
      child: Align(
          alignment: Alignment.centerLeft,
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40),
                    topLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                  gradient: LinearGradient(
                      begin: FractionalOffset.topLeft,
                      end: FractionalOffset.bottomLeft,
                      colors: [
                        const Color.fromARGB(255, 240, 240, 240),
                        const Color.fromARGB(255, 240, 240, 240),
                      ],
                      stops: const [
                        0.0,
                        1.0,
                      ])),
              child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text('メッセージ',
                      style: TextStyle(
                        color: Colors.black54
                      ))))),
    );
  }

  Container textInputWidget() {
    return Container(
      height: 68,
      child: Row(children: [
        IconButton(
          icon: Icon(Icons.camera_alt_outlined),
          iconSize: 28,
          color: Colors.black54,
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.photo_outlined),
          iconSize: 28,
          color: Colors.black54,
          onPressed: () {},
        ),
        Expanded(
            child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(40)),
          child: TextField(
              autofocus: true,
              decoration: InputDecoration(border: InputBorder.none)),
        )),
        IconButton(
          icon: Icon(Icons.mic),
          iconSize: 28,
          color: Colors.black54,
          onPressed: () {},
        ),
      ]),
    );
  }
}
