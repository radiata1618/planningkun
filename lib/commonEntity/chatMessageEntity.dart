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
import 'package:isar/isar.dart';
import 'package:planningkun/config/chatMessageDatabase.dart';


final chatMessagesDataProvider = ChangeNotifierProvider(
      (ref) => ChatMessageDataNotifier(),
);

class ChatMessageDataNotifier extends ChangeNotifier {
  Stream<QuerySnapshot>? _callStream;
  final controller = StreamController<bool>();
  StreamSubscription<QuerySnapshot>? streamSub;

  Future<void> readChatMessagePhotoFromFirebaseToDirectory(String chatMessageDocId,String senderUserDocId,String fileNameSuffix) async {

    if (fileNameSuffix != "" ) {
      FirebaseStorage storage = FirebaseStorage.instance;
      try {
        Reference fileRef =
        storage.ref().child("chatMessages").child(senderUserDocId).child(
            chatMessageDocId + fileNameSuffix);
        //log("XXXXXX before getdownloadurl");
        var data = await fileRef.getData();
        File downLoadFile = new File.fromRawPath(data!);

        //log("XXXXXX before appdocdir");
        Directory appDocDir = await getApplicationDocumentsDirectory();
        await downLoadFile.copy(
            "${appDocDir.path}/chatMessages/" + senderUserDocId + "/" +
                chatMessageDocId + fileNameSuffix);
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

  void clearIsarAndDirectory()async {

    //TODO　削除の処理を登録
    var boxSetting = Hive.box('setting');
    await boxSetting.put("chatMessagesUpdateCheck",DateTime(2022, 1, 1, 0, 0));
    var isarInstance = Isar.getInstance();
    // isarInstance?.messages.clear();
    await isarInstance?.writeTxn((isar) async {
      isar.chatMessages.clear();
    });

    final chatMessagesDir = Directory((await getApplicationDocumentsDirectory()).path+"/chatMessages");

    List<FileSystemEntity> files;
    files = chatMessagesDir.listSync(recursive: true,followLinks: false);
    for (var file in files) {
      file.deleteSync(recursive: true);
    }

  }

  void controlStreamOfReadChatMessageNewDataFromFirebaseToIsar(WidgetRef ref,String userDocId)async {

    //最初は必ず呼び出し
    //log("XXXXXXXXXXXXX初回readMessageNewDataFromFirebaseToHiveAndMemorycallする");
    streamSub=await readChatMessageNewDataFromFirebaseToIsar(ref,userDocId);
    //log("XXXXXXXXXXXXX初回readMessageNewDataFromFirebaseToHiveAndMemorycallした");

    if(controller.hasListener){

    }else{
      //log("XXXXXXXXXXXXXControlListener開始");
      //2回目以降は新しいデータを更新するたびに起動
      controller.stream.listen((value)  async{
        streamSub!.cancel();
        //log("XXXXXXXXXXXXXreadMessageNewDataFromFirebaseToHiveAndMemorycallする");
        streamSub=await readChatMessageNewDataFromFirebaseToIsar(ref,userDocId);
        //log("XXXXXXXXXXXXXreadMessageNewDataFromFirebaseToHiveAndMemorycallした");
      });
    }

  }

  Future<StreamSubscription<QuerySnapshot>> readChatMessageNewDataFromFirebaseToIsar(WidgetRef ref,String userDocId) async {
    var boxSetting = Hive.box('setting');
    DateTime chatMessageUpdatedTime = await boxSetting.get("chatMessagesUpdateCheck");

    ////log("XXXXXXXXXXXXXQueryする"+messageUpdatedTime.toString());
    _callStream = FirebaseFirestore.instance
        .collection('chatMessages')
        .where('userDocId', isEqualTo: userDocId)
        .where('updateTime',
        isGreaterThan: Timestamp.fromDate(chatMessageUpdatedTime))
        .where('readableFlg', isEqualTo: true)
        .orderBy('updateTime', descending: false)
        .snapshots();


    StreamSubscription<QuerySnapshot> streamSub=_callStream!.listen((QuerySnapshot snapshot) async {
      if (snapshot.size != 0) {
        log("XXXXXXXXXXXXXXXXXXXXXXXXXXXMessageSize" + snapshot.size.toString());

        for(int i=0;i<snapshot.size;i++){

          if(snapshot.docs[i].get("deleteFlg")){

            var isarInstance = Isar.getInstance();
            await isarInstance?.writeTxn((isar) async {

              int result = await isar.chatMessages.filter()
                .chatMessageDocIdEqualTo(snapshot.docs[i].id)
                .deleteAll();

              if(result>0){
                if(snapshot.docs[i].get("fileNameSuffix")!=""){
                  deleteChatMessageFileFromDirectory(snapshot.docs[i].id+snapshot.docs[i].get("fileNameSuffix"));
                }
              }
            });


          }else{


            var isarInstance = Isar.getInstance();
            await isarInstance?.writeTxn((isar) async {
              List<ChatMessage> resultList = await isar.chatMessages.filter()
                  .chatMessageDocIdEqualTo(snapshot.docs[i].id)
                  .findAll();

              if(resultList.length==0){
                //新規登録

                final newChatMessage = new ChatMessage(
                    snapshot.docs[i].id,
                    snapshot.docs[i].get("userDocId"),
                    snapshot.docs[i].get("friendUserDocId"),
                    snapshot.docs[i].get("content"),
                    snapshot.docs[i].get("receiveSendType"),
                    snapshot.docs[i].get("messageType"),
                    snapshot.docs[i].get("sendTime").toDate(),
                    snapshot.docs[i].get("callChannelId"),
                    snapshot.docs[i].get("fileNameSuffix"),
                    snapshot.docs[i].get("insertUserDocId"),
                    snapshot.docs[i].get("insertProgramId"),
                    snapshot.docs[i].get("insertTime").toDate(),
                    snapshot.docs[i].get("updateUserDocId"),
                    snapshot.docs[i].get("updateProgramId"),
                    snapshot.docs[i].get("updateTime").toDate(),
                    snapshot.docs[i].get("readableFlg"),
                    snapshot.docs[i].get("deleteFlg"));
                newChatMessage.id = await isar.chatMessages.put(newChatMessage);// insert

              }else{
                resultList[0].chatMessageDocId=snapshot.docs[i].id;
                resultList[0].userDocId=snapshot.docs[i].get("userDocId");
                resultList[0].friendUserDocId=snapshot.docs[i].get("friendUserDocId");
                resultList[0].content=snapshot.docs[i].get("content");
                resultList[0].receiveSendType=snapshot.docs[i].get("receiveSendType");
                resultList[0].messageType=snapshot.docs[i].get("messageType");
                resultList[0].sendTime=snapshot.docs[i].get("sendTime").toDate();
                resultList[0].callChannelId=snapshot.docs[i].get("callChannelId");
                resultList[0].fileNameSuffix=snapshot.docs[i].get("fileNameSuffix");
                resultList[0].insertUserDocId=snapshot.docs[i].get("insertUserDocId");
                resultList[0].insertProgramId=snapshot.docs[i].get("insertProgramId");
                resultList[0].insertTime=snapshot.docs[i].get("insertTime").toDate();
                resultList[0].updateUserDocId=snapshot.docs[i].get("updateUserDocId");
                resultList[0].updateProgramId=snapshot.docs[i].get("updateProgramId");
                resultList[0].updateTime=snapshot.docs[i].get("updateTime").toDate();
                resultList[0].readableFlg=snapshot.docs[i].get("readableFlg");
                resultList[0].deleteFlg=snapshot.docs[i].get("deleteFlg");
                await isar.chatMessages.put(resultList[0]);// insert
              }

            });

            await readChatMessagePhotoFromFirebaseToDirectory(snapshot.docs[i].id
                ,snapshot.docs[i].get("receiveSendType")=="send"?snapshot.docs[i].get("userDocId"):snapshot.docs[i].get("friendUserDocId")
                ,snapshot.docs[i].get("fileNameSuffix"));


          }
          log("XXXXXXXXXXXXXDateリセットするMessage"+chatMessageUpdatedTime.toString()+">>>>"+snapshot.docs[i].get("updateTime").toDate().toString());
          if (snapshot.docs[i].get("updateTime").toDate().isAfter(chatMessageUpdatedTime)) {
            chatMessageUpdatedTime = snapshot.docs[i].get("updateTime").toDate();
            await boxSetting.put("chatMessagesUpdateCheck", chatMessageUpdatedTime);

          }

        }
        notifyListeners();

        log("XXXXXXXXXXXXXADDするMessage");
        controller.sink.add(true);
        log("XXXXXXXXXXXXXADDしたMessage");
      }

    });
    var isarInstance = Isar.getInstance();
    final chatMessages = await isarInstance?.chatMessages.where().findAll();
    log("XXXXXXXXXXXXXXXXXXXXXXX");
    return streamSub;
  }

  void deleteChatMessageFileFromDirectory(String fileName)async{

    final chatMessagesPhotoFile = File((await getApplicationDocumentsDirectory()).path+"/chatMessages/"+fileName);
    chatMessagesPhotoFile.deleteSync(recursive: true);
    //log("filedeletefinish"+fileName);

  }
}
