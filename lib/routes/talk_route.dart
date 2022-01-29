import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../chat.dart';
import '../FriendList.dart';

class Talk extends StatefulWidget {
  final argumentEmail;
  final argumentUserDocId;

  Talk({this.argumentEmail,this.argumentUserDocId});

  @override
  _Talk createState() => _Talk();
}

class _Talk extends State<Talk> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: buildTalkList(widget.argumentUserDocId),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FriendList(
                  argumentEmail: widget.argumentEmail,
                  argumentUserDocId: widget.argumentUserDocId),
            ),
          );
        },
        child: const Icon(Icons.tab),
      ),
    );
  }

  Future<void> _MoveToChat(String userDocId,
      String oppositeUserEmail, BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Chat(
            argumentUserDocId: widget.argumentUserDocId,
            argumentOppositeUserDocId: userDocId),
      ),
    );
  }


  Widget buildTalkList(String userDocId) {


    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('talks')
          .where('userDocId', isEqualTo: userDocId)
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
                title: Text(data['oppositeUserDocId']),
                subtitle: Text(data['lastMessageContent']),
                onTap: () {
                  _MoveToChat(userDocId,data['oppositeUserDocId'], context);
                },
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
