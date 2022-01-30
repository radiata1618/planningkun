import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_config.dart';
import 'tabs_page.dart';

class Chat extends StatefulWidget {
  final argumentUserDocId;
  final argumentOppositeUserDocId;

  Chat({this.argumentUserDocId,this.argumentOppositeUserDocId});

  @override
  _Chat createState() => _Chat();
}

class _Chat extends State<Chat> {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  Future<void> _insertMessage(

      //相手ユーザの画面にトークデータがなかったら新規作成する
      String userDocId, String oppositeUserDocId, String messageContent) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('talks')
        .where('oppositeUserDocId', isEqualTo: userDocId)
        .where('userDocId', isEqualTo: oppositeUserDocId)
        .get();

    if (snapshot.size == 0) {
      FirebaseFirestore.instance.collection('talks').add({
        'lastMessageContent': "あああ",
        'lastMessageDocId': "",
        'lastTime': Timestamp.fromDate(DateTime.now()),
        'oppositeUserDocId': userDocId,
        'userDocId': oppositeUserDocId
      });
    }

    FirebaseFirestore.instance.collection('messages').add({
      'content': messageContent,
      'userDocId': userDocId,
      'oppositeUserDocId': oppositeUserDocId,
      'receiveSend': "send",
      'sendTime': Timestamp.fromDate(DateTime.now()),
    });

    FirebaseFirestore.instance.collection('messages').add({
      'content': messageContent,
      'userDocId': oppositeUserDocId,
      'oppositeUserDocId': userDocId,
      'receiveSend': "receive",
      'sendTime': Timestamp.fromDate(DateTime.now()),
    });

    //TODO トークデータを更新
  }

  String content = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        elevation: .6,
        title: Text(
          widget.argumentOppositeUserDocId,
          //TODO IDを名前に変更
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
                buildMessageList(
                    widget.argumentUserDocId, widget.argumentOppositeUserDocId),
              ],
            ),
          ),
        ),
        textInputWidget(),
      ])),
    );
  }

  Padding rightBalloon(String content) {
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
                  child: Text(content,
                      style: TextStyle(
                        color: Colors.white,
                      ))))),
    );
  }

  Padding leftBalloon(String content) {
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
                  child:
                      Text(content, style: TextStyle(color: Colors.black54))))),
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
            decoration: InputDecoration(border: InputBorder.none),
            onChanged: (String value) {
              setState(() {
                content = value;
              });
            },
          ),
        )),
        IconButton(
          icon: Icon(Icons.arrow_forward_ios_rounded),
          iconSize: 28,
          color: Colors.black54,
          onPressed: () {
            _insertMessage(
                widget.argumentUserDocId, widget.argumentOppositeUserDocId, content);
          },
        ),
        IconButton(
          icon: Icon(Icons.mic),
          iconSize: 28,
          color: Colors.black54,
          onPressed: () {},
        ),
      ]),
    );
  }

  Widget buildMessageList(String userDocId, String oppositeUserDocId) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('messages')
          .where('userDocId', isEqualTo: userDocId)
          .where('oppositeUserDocId', isEqualTo: oppositeUserDocId)
          .orderBy('sendTime', descending: false)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: const CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        return ListView(
          shrinkWrap: true, //エラー対策
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            final data = document.data()! as Map<String, dynamic>;
            if (data['receiveSend'] == "send") {
              return rightBalloon(data['content']);
            } else {
              return leftBalloon(data['content']);
            }
          }).toList(),
        );
      },
    );
  }
}
