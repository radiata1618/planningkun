import 'dart:async';
import 'dart:core';
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
        Reference imageRef =  storage.ref().child("topics").child(topicDocId+photoNameSuffix);
        String imageUrl = await imageRef.getDownloadURL();
        _topicPhotoData[topicDocId] = Image.network(imageUrl,width:90);

        Directory appDocDir = await getApplicationDocumentsDirectory();
        File downloadToFile = File("${appDocDir.path}/topics/"+topicDocId+photoNameSuffix);

        await imageRef.writeToFile(downloadToFile);

      }catch(e){
        //写真があるはずなのになぜかエラーだった
        _topicPhotoData[topicDocId] =null;
      }

  }


  Future<void> readTopicNewDataFromFirebaseToHiveAndMemory() async {

    var boxSetting = await Hive.openBox('setting');
    DateTime topicUpdatedTime=await boxSetting.get("topicUpdateCheck");

    var boxTopic = await Hive.openBox('topics');

    final Stream<QuerySnapshot> _callStream = FirebaseFirestore.instance
        .collection('topics')
        .where('updateTime', isGreaterThan: Timestamp.fromDate(topicUpdatedTime))
        .snapshots();

    _callStream.listen((QuerySnapshot snapshot) async{
      if(snapshot.size!=0){
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
            'deleteFlg': doc.get("deleteFlg"),
          };

          await boxTopic.put(doc.id, tmpData);
          _topicData[doc.id]=tmpData;
          await readTopicPhotoFromFirebaseToDirectoryAndMemory(doc.id);

          if(doc.get("updateTime").toDate().isAfter(topicUpdatedTime)){
            topicUpdatedTime=doc.get("updateTime").toDate();
          }
          await boxSetting.put("topics",topicUpdatedTime);
        });


      }

    });

    notifyListeners();

  }
}

