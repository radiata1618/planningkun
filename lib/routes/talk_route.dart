import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../chat.dart';
import '../FriendList.dart';
import '../common.dart';


class Talk extends StatefulWidget {
  Map<String, String>  argumentUserData;
  Map<String, String> argumentMasterData;
  Map<String,Map<String,String>>  argumentFriendData;


  Talk({required this.argumentUserData,required this.argumentMasterData,required this.argumentFriendData});

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
      body: buildTalkList(widget.argumentUserData["userDocId"]!),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FriendList(
                  argumentUserData: widget.argumentUserData,
                  argumentMasterData:widget.argumentMasterData,
                  argumentFriendData:widget.argumentFriendData),
            ),
          );
        },
        child: const Icon(Icons.tab),
      ),
    );
  }

  Future<void> _MoveToChat(String userDocId,
      String friendUserDocId, BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Chat(
            argumentUserData: widget.argumentUserData,
            argumentMasterData:widget.argumentMasterData,
            argumentFriendData:widget.argumentFriendData,
            argumentFriendUserDocId:friendUserDocId
        ),
      ),
    );
  }


  Widget buildTalkList(String userDocId) {


    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('friends')
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
                title: Text(data['friendUserName']),

                subtitle: Text(data['lastMessageContent']),
                onTap: () {
                  _MoveToChat(userDocId,data['friendUserDocId'], context);
                },
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
