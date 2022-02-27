import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:planningkun/routes/friendProfile.dart';
import 'commonEntity/friendEntity.dart';
import 'commonEntity/userEntity.dart';
import 'commonLogic/commonUI.dart';
import 'config/chatMessageDatabase.dart';
import 'join_channel_video.dart';
import 'chatPageLogic.dart';
import 'confirmCall.dart';

class ChatPage extends ConsumerWidget {
  String friendUserDocId;
  String friendUserName;
  Image? friendPhoto;

  ChatPage({
    required this.friendUserDocId,
    required this.friendUserName,
    this.friendPhoto,
    Key? key,
  }) : super(key: key);


  String content="";

  @override
  Widget build(BuildContext context, WidgetRef ref) {

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
        elevation: 0.6,
        title: Container(
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
              ref.watch(friendDataProvider).friendData[friendUserDocId]==null
            ?friendUserName
          :ref.watch(friendDataProvider).friendData[friendUserDocId]![
                    "friendUserName"]!,
                style: TextStyle(color: Colors.black87),
              ),
              Container(
                  width: 40,
                  child: Align(
                      alignment: Alignment.center,
                      child: GestureDetector(
                          onTap: () async {

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

  Padding rightBalloon(ChatMessage chatMessage) {
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
                  child: Text(chatMessage.content,
                      style: TextStyle(
                        color: Colors.white,
                      ))))),
    );
  }

  Padding leftBalloon(ChatMessage chatMessage) {
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
                      Text(chatMessage.content, style: TextStyle(color: Colors.black54))))),
    );
  }

  Container textInputWidget(WidgetRef ref) {
    var _controller = TextEditingController();

    return Container(
      height: 68,
      child: Row(children: [
        graySmallIconButton(icon: Icons.camera_alt_outlined, onPressed: () {  }),
        graySmallIconButton(icon: Icons.photo_outlined, onPressed: () {  }),
        Expanded(
            child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(40)),
          child: TextField(
            autofocus: true,
            controller: _controller,
            decoration: InputDecoration(border: InputBorder.none),
            onChanged: (String value) {
                content = value;
            },
          ),
        )),
        graySmallIconButton(
            icon: Icons.arrow_forward_ios_rounded,
            onPressed: () async {
              await insertChat(ref,content,friendUserDocId);
              _controller.clear();
            }),
        graySmallIconButton(icon: Icons.mic, onPressed: () {  }),
      ]),
    );
  }

  Widget buildMessageList(String userDocId, String friendUserDocId) {

    //TODO　ORDERで日付順にする。、時間を表示、
    var isarInstance = Isar.getInstance();
    Query<ChatMessage>? chatMessageDataQuery = isarInstance?.chatMessages.filter()
        .userDocIdEqualTo(userDocId)
        .friendUserDocIdEqualTo(friendUserDocId)
        .build();

    return StreamBuilder<List<ChatMessage>>(
      stream: chatMessageDataQuery?.watch(initialReturn: true),
      builder: (context, AsyncSnapshot<List<ChatMessage>> chatMessagesList) {
        if (!chatMessagesList.hasData) {
          return const Center(
            child: const CircularProgressIndicator(),
          );
        }
        if (chatMessagesList.hasError) {
          return const Text('Something went wrong');
        }
        return ListView(
          shrinkWrap: true, //エラー対策
          children: chatMessagesList.data!.map((ChatMessage chatMessge) {
            if (chatMessge.receiveSendType == "send") {
              return rightBalloon(chatMessge);
            } else {
              return leftBalloon(chatMessge);
            }
          }).toList(),
        );
      },
    );
  }
}
