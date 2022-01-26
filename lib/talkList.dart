import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'firebase_config.dart';
import 'tabs_page.dart';
import 'friendList.dart';
import 'chat.dart';

class TalkList extends StatelessWidget {
  final argumentEmail;

  TalkList({this.argumentEmail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: buildTalkList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => FriendList(
                argumentEmail: argumentEmail,
                //argumentBusinessYear: year,
              ),
            ),
          );
        },
        child: const Icon(Icons.tab),
      ),
    );
  }


  Future<void> _MoveToTalks(String oppositeUserEmail,BuildContext context) async {
    // addによるドキュメントIDを指定しない追加
    // この場合は、ドキュメントIDはハッシュ値が払い出されます
    Navigator.push(
      context,MaterialPageRoute(
      builder: (context) => Chat(
          argumentOppositeEmail: oppositeUserEmail,
          argumentEmail: argumentEmail
      ),
    ),
    );



  }

  Widget buildTalkList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('talks')
          .orderBy('lastTime', descending: true)
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
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            final data = document.data()! as Map<String, dynamic>;
            return Card(
              child: ListTile(
                leading: CircleAvatar(),
                trailing: Text(data['lastTime'].toDate().toString()),
                title: Text(data['oppositeUserEmail']),
                subtitle: Text(data['LastMessageContent']),
                onTap: () {
                  _MoveToTalks(data['oppositeUserEmail'],context);
                },
                  ),
            );
          }).toList(),
        );
      },
    );
  }
}