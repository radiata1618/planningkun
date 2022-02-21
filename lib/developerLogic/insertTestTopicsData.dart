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
      ,"Vermeer"
      ,"art"
      ,"https://news.artnet.com/app/news-upload/2020/04/Onderzoek-Meisje-met-de-parel-Johannes-Vermeer_01-256x256.jpg");

  insertTopicTestData(ref
      ,"hokusai"
      ,"art"
      ,"https://data.ukiyo-e.org/artelino/scaled/21257g1.jpg");

  insertTopicTestData(ref
      ,"ohi"
      ,"art"
      ,"https://stat.ameba.jp/user_images/20200315/18/sasala-mama/82/fa/j/o0660035014728473900.jpg");

  insertTopicTestData(ref
      ,"monet"
      ,"art"
      ,"https://dearsam.com/img/600/744/resize/w/o/woman-with-a-parasol-by-monet-50x70_2.jpg");


  insertTopicTestData(ref
      ,"futsal"
      ,"sports"
      ,"https://s.cafebazaar.ir/images/icons/com.prosoccercaptain.futsalballheropro-f098e385-3d34-40de-9265-0b2319ba161a_128x128.png");
}

Future<void> insertTopicTestData(WidgetRef ref
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
        'insertProgramId': "insertTestTopicsData",
        'insertTime': FieldValue.serverTimestamp(),
        'updateUserDocId':ref.watch(userDataProvider).userData["userDocId"],
        'updateProgramId': "insertTestTopicsData",
        'updateTime': FieldValue.serverTimestamp(),
        'readableFlg': false,
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


  await FirebaseFirestore.instance
      .collection('topics')
      .doc(insertedDocId)
      .update({
    'readableFlg': true,
    'photoUpdateCnt':1,
    'updateUserDocId':ref.watch(userDataProvider.notifier).userData["userDocId"],
    'updateProgramId': "insertTestTopicsData",
    'updateTime': FieldValue.serverTimestamp(),
  });

}