import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planningkun/routes/friendProfile.dart';

import 'commonEntity/commonEntity.dart';
import 'commonEntity/friendEntity.dart';
import 'commonEntity/userData.dart';
import 'join_channel_video.dart';
import 'confirmCall.dart';

class Chat extends ConsumerWidget {
  var friendUserDocId;

  Chat({
    required this.friendUserDocId,
    Key? key,
  }) : super(key: key);


  Future<void> _insertMessage(WidgetRef ref,
      String messageContent) async {

    FirebaseFirestore.instance.collection('messages').add({
      'content': messageContent,
      'userDocId': ref.watch(userDataProvider).userData["userDocId"]!,
      'oppositeUserDocId':friendUserDocId ,
      'receiveSend': "send",
      'sendTime': DateTime.now().toString(),
      'messageType':"chat",
      'callChannelId':"",
    'insertUserDocId':ref.watch(userDataProvider).userData["userDocId"]!,
    'insertProgramId': "Chat",
    'insertTime': DateTime.now().toString(),
    });

    FirebaseFirestore.instance.collection('messages').add({
      'content': messageContent,
      'userDocId': friendUserDocId,
      'oppositeUserDocId': ref.watch(userDataProvider).userData["userDocId"]!,
      'receiveSend': "receive",
      'sendTime': DateTime.now().toString(),
      'messageType':"chat",
      'callChannelId':"",
      'insertUserDocId':ref.watch(userDataProvider).userData["userDocId"]!,
      'insertProgramId': "Chat",
      'insertTime': DateTime.now().toString(),
    });

    //TODO トークデータを更新
  }

  String content = "";



  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final Stream<QuerySnapshot> _callStream = FirebaseFirestore.instance
        .collection('calls')
        .where('sender', isEqualTo: friendUserDocId)
        .where('receiver', isEqualTo: ref.watch(userDataProvider).userData["userDocId"]!)
        .where('status', isEqualTo: "yet")
        .snapshots();

    _callStream.listen((QuerySnapshot snapshot) async{
      if(snapshot.size!=0){

        await Navigator.of(context).push(
          MaterialPageRoute(builder: (context) {
            return confirmCall(
              argumentFriendUserDocId: friendUserDocId,
              argumentChannelId: snapshot.docs[0].id,
            );
          }),
        );

      }

    });

    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: CircleAvatar(
              backgroundImage: ref.watch(friendDataProvider).friendPhotoData[friendUserDocId] ==null
                  ? null
                  : ref.watch(friendDataProvider).friendPhotoData[friendUserDocId]!.image,
              backgroundColor: Colors.transparent, // 背景色
              radius: 16, // 表示したいサイズの半径を指定
            ),
            onPressed:()async{
              await Navigator.of(context).push(
                MaterialPageRoute(builder: (context) {
                  return FriendProfile(
                    argumentFriendUserDocId:friendUserDocId,
                  );
                }),
              );
            },
          ),
        backgroundColor: Theme.of(context).canvasColor,
        elevation: .6,
        title: Container(
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                ref.watch(friendDataProvider).friendData[friendUserDocId]![
                    "friendUserName"]!,
                style: TextStyle(color: Colors.black87),
              ),
              Container(
                  width: 40,
                  child: Align(
                      alignment: Alignment.center,
                      child: GestureDetector(
                          onTap: () async {

                            //String channelId =await call();
                            //userSearch(algolia);
                            await Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) {
                                return JoinChannelVideo(
                                  argumentChannelId: "",
                                  argumentFriendUserDocId: friendUserDocId,
                                );
                              }),
                            );

                          },
                          child: Icon(Icons.call_sharp,
                              color: Colors.black87, size: 26))))
            ],
          ),
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
                buildMessageList(ref.watch(userDataProvider).userData["userDocId"]!,
                    friendUserDocId),
              ],
            ),
          ),
        ),
        textInputWidget(ref),
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

  Container textInputWidget(WidgetRef ref) {
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
                content = value;
            },
          ),
        )),
        IconButton(
          icon: Icon(Icons.arrow_forward_ios_rounded),
          iconSize: 28,
          color: Colors.black54,
          onPressed: () {
            _insertMessage(ref,content);
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
