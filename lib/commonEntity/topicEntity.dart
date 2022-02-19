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

final topicDataProvider = ChangeNotifierProvider(
      (ref) => TopicDataNotifier(),
);


class TopicDataNotifier extends ChangeNotifier {
  Map<String,Map<String,dynamic>> _topicData={};
  get topicData => _topicData ;

  Map<String, Image?> _topicPhotoData = {};
  get topicPhotoData => _topicPhotoData;

  Future<void> readTopicPhotoFromFirebaseToDirectoryAndMemory(String topicDocId) async {

    String photoNameSuffix = _topicData[topicDocId]!["photoNameSuffix"]!;

      FirebaseStorage storage =  FirebaseStorage.instance;
      try {
        Reference imageRef =   storage.ref().child("topics").child(topicDocId+photoNameSuffix);
        String imageUrl = await imageRef.getDownloadURL();
        _topicPhotoData[topicDocId] = Image.network(imageUrl,width:90);

        Directory appDocDir = await getApplicationDocumentsDirectory();
        File downloadToFile = File("${appDocDir.path}/topics/"+topicDocId+photoNameSuffix);
        log(imageUrl.toString());
        await imageRef.writeToFile(downloadToFile);

      }catch(e){
        //写真があるはずなのになぜかエラーだった
        _topicPhotoData[topicDocId] =null;
      }

  }


  // Future<void> callStreamReadTopicNewDataFromFirebaseToHiveAndMemory() async {
  //
  // }

  Future<void> readTopicNewDataFromFirebaseToHiveAndMemory() async {

    var boxSetting = await Hive.openBox('setting');
    DateTime topicUpdatedTime=await boxSetting.get("topicUpdateCheck");


    Stream<QuerySnapshot> _callStream = FirebaseFirestore.instance
        .collection('topics')
        .where('updateTime', isGreaterThan: Timestamp.fromDate(topicUpdatedTime))
        .where('readableFlg', isEqualTo: true)
        .snapshots();


    _callStream.listen((QuerySnapshot snapshot) async{
      if(snapshot.size!=0){

        var boxTopic = await Hive.openBox('topics');

        snapshot.docs.forEach((doc) async{

          Map<String,dynamic> tmpData= {
            'categoryDocId':doc.get("categoryDocId") ,
            'categoryName':doc.get("categoryName"),
            'photoNameSuffix':doc.get("photoNameSuffix"),
            'photoUpdateCnt':doc.get("photoUpdateCnt"),
            'topicName':doc.get("topicName"),
            'insertUserDocId':doc.get("insertUserDocId"),
            'insertProgramId': doc.get("insertProgramId"),
            'insertTime': doc.get("insertTime"),
            'updateUserDocId':doc.get("updateUserDocId"),
            'updateProgramId': doc.get("updateProgramId"),
            'updateTime': doc.get("updateTime").toDate(),
            'readableFlg': doc.get("readableFlg"),
            'deleteFlg': doc.get("deleteFlg"),
          };

          await boxTopic.put(doc.id, tmpData);
          _topicData[doc.id]=tmpData;

          await readTopicPhotoFromFirebaseToDirectoryAndMemory(doc.id);

          if(doc.get("updateTime").toDate().isAfter(topicUpdatedTime)){
            topicUpdatedTime=doc.get("updateTime").toDate();
            await boxSetting.put("topicUpdateCheck",topicUpdatedTime);
          }
        });


        await boxTopic.close();
        // _callStream.
      // _callStream.
      // // _callStream = FirebaseFirestore.instance
      // //     .collection('topics')
      // //     .where('updateTime', isGreaterThan: Timestamp.fromDate(topicUpdatedTime))
      // //     .snapshots();
      // なぜか画像DLでエラーになる
      // 検索条件の日付を更新できない
      }

      notifyListeners();
      // _callStream = FirebaseFirestore.instance
      //     .collection('topics')
      //     .where('updateTime', isGreaterThan: Timestamp.fromDate(topicUpdatedTime))
      //     .where('readableFlg', isEqualTo: true)
      //     .snapshots();
    });


  }
}

