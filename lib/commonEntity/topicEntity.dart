import 'dart:async';
import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

final topicDataProvider = ChangeNotifierProvider(
      (ref) => TopicDataNotifier(),
);


class TopicDataNotifier extends ChangeNotifier {
  Map<String,Map<String,dynamic>> _topicData={};
  get topicData => _topicData ;


  Future<void> readTopicNewDataFromFirebaseToHiveAndMemory() async {

    var boxSetting = await Hive.openBox('setting');
    DateTime topicUpdatedTime=await boxSetting.get("topic");

    var boxTopic = await Hive.openBox('topics');

    final Stream<QuerySnapshot> _callStream = FirebaseFirestore.instance
        .collection('topics')
        .where('updateTime', isGreaterThan: topicUpdatedTime.toString())
        .snapshots();

    _callStream.listen((QuerySnapshot snapshot) async{
      if(snapshot.size!=0){
        snapshot.docs.forEach((doc) async{

          Map<String,dynamic> tmpData= {
            'categoryDocId':doc.get("categoryDocId") ,
            'categoryName':doc.get("categoryName"),
            'photoPath':doc.get("photoPath"),
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

          if(doc.get("updateTime")>topicUpdatedTime){
            topicUpdatedTime=doc.get("updateUserDocId");
          }
          await boxSetting.put("topic",topicUpdatedTime);
        });


      }

    });

    notifyListeners();

  }
}

