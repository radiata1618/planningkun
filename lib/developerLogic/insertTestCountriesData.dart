import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/src/consumer.dart';

import '../commonEntity/userEntity.dart';
import '../commonLogic/commonLogic.dart';

Future<void> insertTestCountryData(WidgetRef ref) async {
  insertCountryUnitData(ref,"JPN","Japan","https://fifaranking.net/img/fifa/nations/jpn.png");
  insertCountryUnitData(ref,"USA","United States of America","https://d4a8qxd2udge6.cloudfront.net/6586/thumb_cover_256_322-1.jpg");
  insertCountryUnitData(ref,"IRN","Iran","https://fifaranking.net/img/fifa/nations/irn.png");

}

Future<void> insertCountryUnitData(WidgetRef ref, String countryCode, String countryName,String photoURL)async {

  String insertedDocId="";

  await FirebaseFirestore.instance.collection('countries').add(
      {
        'countryCode':countryCode,
        'countryName': countryName,
        'imageNameSuffix':photoURL.substring(photoURL.lastIndexOf('.')),
        'imageUpdateCnt': 0,
        'insertUserDocId':"system",
        'insertProgramId': "insertTestCountriesData",
        'insertTime': FieldValue.serverTimestamp(),
        'updateUserDocId':"system",
        'updateProgramId': "insertTestCountriesData",
        'updateTime': FieldValue.serverTimestamp(),
        'readableFlg': false,
        'deleteFlg': false,
      }).then((value){
    insertedDocId=value.id;
  });
  FirebaseStorage storage = FirebaseStorage.instance;
  try {
    await storage
        .ref("countries/" +insertedDocId+ photoURL.substring(photoURL.lastIndexOf('.')))
        .putFile(await urlToFile(photoURL));
  }catch(e){
    log("画像保存でエラー"+countryName);
  }

  await FirebaseFirestore.instance
      .collection('countries')
      .doc(insertedDocId)
      .update({
    'readableFlg': true,
    'imageUpdateCnt':1,
    'updateUserDocId':ref.watch(userDataProvider.notifier).userData["userDocId"],
    'updateProgramId': "insertTestCountryData",
    'updateTime': FieldValue.serverTimestamp(),
  });

}