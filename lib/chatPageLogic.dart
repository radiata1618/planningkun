import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'commonEntity/userEntity.dart';

Future<void> insertChat(WidgetRef ref,
    String messageContent,String friendUserDocId) async {

  FirebaseFirestore.instance.collection('chatMessages').add({
    'userDocId': ref.watch(userDataProvider).userData["userDocId"]!,
    'friendUserDocId':friendUserDocId ,
    'content': messageContent,
    'receiveSendType': "send",
    'messageType':"chat",
    'sendTime': FieldValue.serverTimestamp(),
    'callChannelId':"",
    'fileNameSuffix': "",
    'insertUserDocId':ref.watch(userDataProvider).userData["userDocId"],
    'insertProgramId': "chatPage",
    'insertTime': FieldValue.serverTimestamp(),
    'updateUserDocId':ref.watch(userDataProvider).userData["userDocId"],
    'updateProgramId': "chatPage",
    'updateTime': FieldValue.serverTimestamp(),
    'readableFlg': true,
    'deleteFlg': false,
  });

  FirebaseFirestore.instance.collection('chatMessages').add({
    'userDocId': friendUserDocId ,
    'friendUserDocId':ref.watch(userDataProvider).userData["userDocId"]!,
    'content': messageContent,
    'receiveSendType': "receive",
    'messageType':"chat",
    'sendTime': FieldValue.serverTimestamp(),
    'callChannelId':"",
    'fileNameSuffix': "",
    'insertUserDocId':ref.watch(userDataProvider).userData["userDocId"],
    'insertProgramId': "chatPage",
    'insertTime': FieldValue.serverTimestamp(),
    'updateUserDocId':ref.watch(userDataProvider).userData["userDocId"],
    'updateProgramId': "chatPage",
    'updateTime': FieldValue.serverTimestamp(),
    'readableFlg': true,
    'deleteFlg': false,
  });

  //TODO トークデータを更新
}