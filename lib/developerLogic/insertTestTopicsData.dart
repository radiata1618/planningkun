import 'dart:developer';
import 'dart:io' as io;
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:path_provider/path_provider.dart';

import '../commonEntity/userEntity.dart';
import '../commonLogic/commonLogic.dart';

Future<void> insertTestData(WidgetRef ref) async {

  //sports

  insertTopicTestData(ref
      ,"Futsal"
      ,"sports"
      ,"https://s.cafebazaar.ir/images/icons/com.prosoccercaptain.futsalballheropro-f098e385-3d34-40de-9265-0b2319ba161a_128x128.png");

  await insertTopicTestData(ref
      ,"Basketball"
      ,"sports"
      ,"https://cdn9.8fat.com/icon/3e/a3/3ea32285739cc29b8992e07d03e652039d3cb1d7.jpg");

  await insertTopicTestData(ref
      ,"Hockey"
      ,"sports"
      ,"https://media.nu.nl/m/rr6xetdamq00_sqr256.jpg/finse-ijshockeyer-van-quarantaine-naar-olympisch-goud-heb-alles-gegeven.jpg");

  await insertTopicTestData(ref
      ,"Running"
      ,"sports"
      ,"https://d26oc3sg82pgk3.cloudfront.net/files/media/edit/image/45925/article_full%401x.jpg");

  await insertTopicTestData(ref
      ,"SkateBoard"
      ,"sports"
      ,"https://awadyasmin.files.wordpress.com/2010/08/skaters_wideweb__430x2931.jpg");

  await insertTopicTestData(ref
      ,"Baseball"
      ,"sports"
      ,"https://cdn.amebaowndme.com/madrid-prd/madrid-web/images/sites/731430/7b7c6e00a93b153ad67f5e899f750695_b3462ef78aaa1b96959bee3b4eeab373.jpg");

  await insertTopicTestData(ref
      ,"Vermeer"
      ,"art"
      ,"https://news.artnet.com/app/news-upload/2020/04/Onderzoek-Meisje-met-de-parel-Johannes-Vermeer_01-256x256.jpg");

  await insertTopicTestData(ref
      ,"hokusai"
      ,"art"
      ,"https://data.ukiyo-e.org/artelino/scaled/21257g1.jpg");

  await insertTopicTestData(ref
      ,"ohi"
      ,"art"
      ,"https://stat.ameba.jp/user_images/20200315/18/sasala-mama/82/fa/j/o0660035014728473900.jpg");

  await insertTopicTestData(ref
      ,"monet"
      ,"art"
      ,"https://dearsam.com/img/600/744/resize/w/o/woman-with-a-parasol-by-monet-50x70_2.jpg");

  await insertTopicTestData(ref
      ,"sushi"
      ,"food"
      ,"https://cdn.with.is/uploads/group/icon/7985/image_170225233244.jpg");


  await insertTopicTestData(ref
      ,"modern art"
      ,"art"
      ,"https://cdn.with.is/uploads/group/icon/4636/161030223852.jpg");

  await insertTopicTestData(ref
      ,"dog"
      ,"nature"
      ,"https://cdn.with.is/uploads/group/icon/90042/image_220114123431.jpg");

  await insertTopicTestData(ref
      ,"sunrise"
      ,"nature"
      ,"https://cdn.with.is/uploads/group/icon/88366/image_211211173101.jpg");

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