import 'dart:developer';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../commonEntity/userEntity.dart';
import '../commonLogic/commonLogic.dart';

Future<void> insertTestTopicData(WidgetRef ref) async {

  //sports

  insertTopicTestData(ref
      ,"Futsal"
      ,"sports"
      ,"https://cdn.with.is/uploads/group/icon/4942/image_161110193308.jpg");

  await insertTopicTestData(ref
      ,"Basketball"
      ,"sports"
      ,"https://cdn.with.is/uploads/group/icon/714/images.jpg");

  await insertTopicTestData(ref
      ,"Skate"
      ,"sports"
      ,"https://cdn.with.is/uploads/group/icon/35177/image_190308001723.jpg");

  await insertTopicTestData(ref
      ,"Running"
      ,"sports"
      ,"https://cdn.with.is/uploads/group/icon/933/150321_learn-for-running-1038x576.jpg");

  await insertTopicTestData(ref
      ,"SkateBoard"
      ,"sports"
      ,"https://cdn.with.is/uploads/group/icon/3307/1352385862921.jpg");

  await insertTopicTestData(ref
      ,"Baseball"
      ,"sports"
      ,"https://cdn.with.is/uploads/group/icon/3148/image_160906005243.jpg");

  await insertTopicTestData(ref
      ,"Vermeer"
      ,"art"
      ,"https://cdn.with.is/uploads/group/icon/9315/170413204701.jpg");

  await insertTopicTestData(ref
      ,"hokusai"
      ,"art"
      ,"https://cdn.with.is/uploads/group/icon/16709/291001.jpg");

  await insertTopicTestData(ref
      ,"kaii"
      ,"art"
      ,"https://cdn.with.is/uploads/group/icon/14002/170901004218.jpg");

  await insertTopicTestData(ref
      ,"monet"
      ,"art"
      ,"https://cdn.with.is/uploads/group/icon/1950/160805182922.jpg");

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