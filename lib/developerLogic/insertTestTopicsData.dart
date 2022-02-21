import 'dart:developer';
import 'dart:io' as io;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../commonEntity/userEntity.dart';
import '../commonLogic/commonLogic.dart';

Future<void> insertTestData(WidgetRef ref) async {

  insertTopicTestData(ref
      ,"insertTestTopicsData"
      ,"Vermeer"
      ,"art"
      ,"https://upload.wikimedia.org/wikipedia/commons/4/46/Cropped_version_of_Jan_Vermeer_van_Delft_002.jpg");
}

Future<void> insertTopicTestData(WidgetRef ref
    ,String programId
    ,String topicName
    ,String categoryName
    ,String photoURL)async {
  String insertedDocId="";

  QuerySnapshot<Map<String, dynamic>> categoryData=await FirebaseFirestore.instance
      .collection('categories')
      .where('categoryName', isEqualTo: categoryName)
      .get();

  await FirebaseFirestore.instance.collection('topics').add(
      {
        'topicName': topicName,
        'categoryDocId': categoryData.docs[0].id,
        'categoryName': categoryName,
        'photoNameSuffix':photoURL.substring(photoURL.lastIndexOf('.')),
        'photoUpdateCnt': 0,
        'insertUserDocId':ref.watch(userDataProvider).userData["userDocId"],
        'insertProgramId': programId,
        'insertTime': FieldValue.serverTimestamp(),
        'updateUserDocId':ref.watch(userDataProvider).userData["userDocId"],
        'updateProgramId': programId,
        'updateTime': FieldValue.serverTimestamp(),
        'readableFlg': true,
        'deleteFlg': false,
      }).then((value){
    insertedDocId=value.id;
  });

  FirebaseStorage storage = FirebaseStorage.instance;
  try {
    await storage
        .ref("topics/" +insertedDocId+ photoURL.substring(photoURL.lastIndexOf('.')))
        .putFile(await urlToFile(photoURL));
  }catch(e){
    log("画像保存でエラー");
  }

}