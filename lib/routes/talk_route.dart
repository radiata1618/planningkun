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

  Talk({this.argumentEmail});

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
      body: buildTalkList(widget.argumentEmail),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FriendList(
                  argumentEmail: widget.argumentEmail),
            ),
          );
        },
        child: const Icon(Icons.tab),
      ),
    );
  }

  Future<void> _MoveToChat(String email,
      String oppositeUserEmail, BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Chat(
            argumentOppositeEmail: oppositeUserEmail,
            argumentEmail: email),
      ),
    );
  }


  // Future<void> CheckQuery(
  //     String email) async {
  //   QuerySnapshot snapshot = await FirebaseFirestore.instance
  //       .collection('talks')
  //       .where('userEmail', isEqualTo: email)
  //       .orderBy('lastTime', descending: true)
  //       .get();
  //
  //   if (snapshot.size == 0) {
  //     email=email;
  //   }
  //
  // }



  Widget buildTalkList(String email) {

    //CheckQuery(email);

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('talks')
          .where('userEmail', isEqualTo: email)
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
                subtitle: Text(data['lastMessageContent']),
                onTap: () {
                  _MoveToChat(email,data['oppositeUserEmail'], context);
                },
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
