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
import 'common.dart';

class FriendList extends StatefulWidget {
  Map<String, String>  argumentUserData;
  Map<String, String> argumentMasterData;
  Map<String, String> argumentFriendData;

  FriendList({required this.argumentUserData,required this.argumentMasterData,required this.argumentFriendData});

  @override
  _FriendList createState() => _FriendList();
}
class _FriendList extends State<FriendList> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: buildFriendList(widget.argumentUserData["email"]!),
    );
  }


  Future<void> _insertOrMoveTalks(String friendUserDocId,BuildContext context) async {
    // addによるドキュメントIDを指定しない追加
    // この場合は、ドキュメントIDはハッシュ値が払い出されます
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('talks')
        .where('oppositeUserDocId', isEqualTo: friendUserDocId)
        .where('userDocId', isEqualTo: widget.argumentUserData["userDocId"])
        .get();

    if(snapshot.size==0){
      FirebaseFirestore.instance.collection('talks').add({
        'lastMessageContent': "あああ",
        'lastMessageDocId': "",
        'lastTime': Timestamp.fromDate(DateTime.now()),
        'oppositeUserDocId': friendUserDocId,
        'userDocId': widget.argumentUserData["userDocId"]
      });
    }
    Navigator.push(
      context,MaterialPageRoute(
        builder: (context) => Chat(
            argumentUserData: widget.argumentUserData,
            argumentMasterData:widget.argumentMasterData,
            argumentFriendData:widget.argumentFriendData,
            argumentfriendUserDocId:friendUserDocId
        ),
      ),
    );



  }


  Widget buildFriendList(String email) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
      //TODO ドキュメントIDをもとに自ユーザを省くように変更する
          .where('email', isNotEqualTo: email)
          //.orderBy('name', descending: true)
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
                  _insertOrMoveTalks(document.id,context);
                },
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

