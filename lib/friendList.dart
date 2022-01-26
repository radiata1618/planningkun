import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'firebase_config.dart';
import 'tabs_page.dart';
import 'friendList.dart';
import 'Chat.dart';

class FriendList extends StatelessWidget {
  final argumentEmail;
  final argumentOppositeEmail;

  FriendList({this.argumentEmail,this.argumentOppositeEmail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: buildFriendList(),
    );
  }


  Future<void> _insertOrMoveTalks(String email,BuildContext context) async {
    // addによるドキュメントIDを指定しない追加
    // この場合は、ドキュメントIDはハッシュ値が払い出されます
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('talks')
        .where('oppositeUserEmail', isEqualTo: email)
        .where('userEmail', isEqualTo: argumentEmail)
        .get();

    if(snapshot.size==0){
      FirebaseFirestore.instance.collection('talks').add({
        'LastMessageContent': "あああ",
        'LastMessageDocId': "",
        'lastTime': Timestamp.fromDate(DateTime.now()),
        'oppositeUserEmail': email,
        'userEmail': argumentEmail
      });
    }
    Navigator.push(
      context,MaterialPageRoute(
        builder: (context) => Chat(
          argumentOppositeEmail: email,
            argumentEmail: argumentEmail
        ),
      ),
    );



  }


  Widget buildFriendList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .orderBy('name', descending: true)
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
                trailing: Text(data['age'].toString()),
                title: Text(data['email']),
                subtitle: Text(data['name']),
                onTap: () {
                  _insertOrMoveTalks(data['email'],context);
                },
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

