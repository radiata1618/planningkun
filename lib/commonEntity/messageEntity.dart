import 'dart:async';
import 'dart:core';
import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:planningkun/commonEntity/userEntity.dart';

final messageDataProvider = ChangeNotifierProvider(
      (ref) => MessageDataNotifier(),
);

class MessageDataNotifier extends ChangeNotifier {
  Stream<QuerySnapshot>? _callStream;
  final controller = StreamController<bool>();
  StreamSubscription<QuerySnapshot>? streamSub;

  Future<void> readMessagePhotoFromFirebaseToDirectory(String messageDocId,String senderUserDocId,String fileNameSuffix) async {

    if (fileNameSuffix != "" ) {
      FirebaseStorage storage = FirebaseStorage.instance;
      try {
        Reference fileRef =
        storage.ref().child("messages").child(senderUserDocId).child(
            messageDocId + fileNameSuffix);
        //log("XXXXXX before getdownloadurl");
        var data = await fileRef.getData();
        File downLoadFile = new File.fromRawPath(data!);

        //log("XXXXXX before appdocdir");
        Directory appDocDir = await getApplicationDocumentsDirectory();
        await downLoadFile.copy(
            "${appDocDir.path}/messages/" + senderUserDocId + "/" +
                messageDocId + fileNameSuffix);
      } catch (e) {
        //写真があるはずなのになぜかエラーだった
        log("XXXXXXXXXXXXXXXファイル保存ERROR");
      }
    }else{
      log("XXXXXXXXXXXXXXXファイル保存しない");

    }
  }
  void closeStream() async {
    streamSub!.cancel();

  }

  void clearHiveAndDirectory()async {

    var boxSetting = Hive.box('setting');
    await boxSetting.put("messagesUpdateCheck",DateTime(2022, 1, 1, 0, 0));
    var boxMessages = Hive.box('messages');
    await boxMessages.deleteFromDisk();
    await Hive.openBox('messages');
    final messagesDir = Directory((await getApplicationDocumentsDirectory()).path+"/messages");

    List<FileSystemEntity> files;
    files = messagesDir.listSync(recursive: true,followLinks: false);
    for (var file in files) {
      file.deleteSync(recursive: true);
    }

  }

  void controlStreamOfReadMessageNewDataFromFirebaseToHive(WidgetRef ref,String userDocId)async {

    //最初は必ず呼び出し
    //log("XXXXXXXXXXXXX初回readMessageNewDataFromFirebaseToHiveAndMemorycallする");
    streamSub=await readMessageNewDataFromFirebaseToHive(ref,userDocId);
    //log("XXXXXXXXXXXXX初回readMessageNewDataFromFirebaseToHiveAndMemorycallした");

    if(controller.hasListener){

    }else{
      //log("XXXXXXXXXXXXXControlListener開始");
      //2回目以降は新しいデータを更新するたびに起動
      controller.stream.listen((value)  async{
        streamSub!.cancel();
        //log("XXXXXXXXXXXXXreadMessageNewDataFromFirebaseToHiveAndMemorycallする");
        streamSub=await readMessageNewDataFromFirebaseToHive(ref,userDocId);
        //log("XXXXXXXXXXXXXreadMessageNewDataFromFirebaseToHiveAndMemorycallした");
      });
    }

  }

  Future<StreamSubscription<QuerySnapshot>> readMessageNewDataFromFirebaseToHive(WidgetRef ref,String userDocId) async {
    var boxSetting = Hive.box('setting');
    DateTime messageUpdatedTime = await boxSetting.get("messagesUpdateCheck");

    ////log("XXXXXXXXXXXXXQueryする"+messageUpdatedTime.toString());
    _callStream = FirebaseFirestore.instance
        .collection('messages')
        .where('userDocId', isEqualTo: userDocId)
        .where('updateTime',
        isGreaterThan: Timestamp.fromDate(messageUpdatedTime))
        .where('readableFlg', isEqualTo: true)
        .orderBy('updateTime', descending: false)
        .snapshots();


    StreamSubscription<QuerySnapshot> streamSub=_callStream!.listen((QuerySnapshot snapshot) async {
      if (snapshot.size != 0) {
        log("XXXXXXXXXXXXXXXXXXXXXXXXXXXMessageSize" + snapshot.size.toString());

        Map<String, dynamic> tmpData={};
        var boxMessage = Hive.box('messages');
        for(int i=0;i<snapshot.size;i++){

          if(snapshot.docs[i].get("deleteFlg")){

            if(boxMessage.get(snapshot.docs[i].id)!=null){
              await boxMessage.delete(snapshot.docs[i].id);
              if(snapshot.docs[i].get("fileNameSuffix")!=""){
                deleteMessageFileFromDirectory(snapshot.docs[i].id+snapshot.docs[i].get("fileNameSuffix"));
              }
            }

          }else{

            tmpData = {
              'userDocId': snapshot.docs[i].get("userDocId"),
              'friendUserDocId': snapshot.docs[i].get("friendUserDocId"),
              'content': snapshot.docs[i].get("content"),
              'receiveSendType': snapshot.docs[i].get("receiveSendType"),
              'messageType': snapshot.docs[i].get("messageType"),
              'sendTime': snapshot.docs[i].get("sendTime").toDate(),
              'callChannelId': snapshot.docs[i].get("callChannelId"),
              'fileNameSuffix': snapshot.docs[i].get("fileNameSuffix"),
              'insertUserDocId': snapshot.docs[i].get("insertUserDocId"),
              'insertProgramId': snapshot.docs[i].get("insertProgramId"),
              'insertTime': snapshot.docs[i].get("insertTime").toDate(),
              'updateUserDocId': snapshot.docs[i].get("updateUserDocId"),
              'updateProgramId': snapshot.docs[i].get("updateProgramId"),
              'updateTime': snapshot.docs[i].get("updateTime").toDate(),
              'readableFlg': snapshot.docs[i].get("readableFlg"),
              'deleteFlg': snapshot.docs[i].get("deleteFlg"),
            };

            await boxMessage.put(snapshot.docs[i].id, tmpData);
            await readMessagePhotoFromFirebaseToDirectory(snapshot.docs[i].id
                ,snapshot.docs[i].get("receiveSendType")=="send"?snapshot.docs[i].get("userDocId"):snapshot.docs[i].get("friendUserDocId")
                ,snapshot.docs[i].get("fileNameSuffix"));


          }
          log("XXXXXXXXXXXXXDateリセットするMessage"+messageUpdatedTime.toString()+">>>>"+snapshot.docs[i].get("updateTime").toDate().toString());
          if (snapshot.docs[i].get("updateTime").toDate().isAfter(messageUpdatedTime)) {
            messageUpdatedTime = snapshot.docs[i].get("updateTime").toDate();
            await boxSetting.put("messagesUpdateCheck", messageUpdatedTime);
          }

        }
        notifyListeners();

        log("XXXXXXXXXXXXXADDするMessage");
        controller.sink.add(true);
        log("XXXXXXXXXXXXXADDしたMessage");
      }

    });
    return streamSub;

  }

  void deleteMessageFileFromDirectory(String fileName)async{

    final messagesPhotoFile = File((await getApplicationDocumentsDirectory()).path+"/messages/"+fileName);
    messagesPhotoFile.deleteSync(recursive: true);
    //log("filedeletefinish"+fileName);

  }
}
