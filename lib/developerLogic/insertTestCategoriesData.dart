import 'dart:developer';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../commonEntity/userEntity.dart';
import '../commonLogic/commonLogic.dart';

Future<void> insertTestCategoryData(WidgetRef ref) async {

  insertCategoryTestData(ref
      ,"top"
      ,"https://cdn.with.is/uploads/group/icon/92071/image_220223005218.jpg");

  insertCategoryTestData(ref
      ,"sports"
      ,"https://cdn.with.is/uploads/group/icon/4942/image_161110193308.jpg");

  insertCategoryTestData(ref
      ,"drink"
      ,"https://cdn.with.is/uploads/group/icon/1028/clip_now_20160609_214610.jpg");

  insertCategoryTestData(ref
      ,"travel"
      ,"https://cdn.with.is/uploads/group/icon/10668/170609015657.jpg");

  insertCategoryTestData(ref
      ,"art"
      ,"https://cdn.with.is/uploads/group/icon/1950/160805182922.jpg");

  insertCategoryTestData(ref
      ,"food"
      ,"https://cdn.with.is/uploads/group/icon/7985/image_170225233244.jpg");

  insertCategoryTestData(ref
      ,"nature"
      ,"https://cdn.with.is/uploads/group/icon/1089/image.jpg");
}
Future<void> insertCategoryTestData(WidgetRef ref
    ,String categoryName
    ,String photoURL)async {
  String insertedDocId="";

  QuerySnapshot<Map<String, dynamic>> categoryData=await FirebaseFirestore.instance
      .collection('categories')
      .where('categoryName', isEqualTo: categoryName)
      .get();

  await FirebaseFirestore.instance.collection('categories').add(
      {
        'categoryName': categoryName,
        'photoNameSuffix':photoURL.substring(photoURL.lastIndexOf('.')),
        'photoUpdateCnt': 0,
        'insertUserDocId':ref.watch(userDataProvider).userData["userDocId"],
        'insertProgramId': "insertTestCategoriesData",
        'insertTime': FieldValue.serverTimestamp(),
        'updateUserDocId':ref.watch(userDataProvider).userData["userDocId"],
        'updateProgramId': "insertTestCategoriesData",
        'updateTime': FieldValue.serverTimestamp(),
        'readableFlg': false,
        'deleteFlg': false,
      }).then((value){
    insertedDocId=value.id;
  });

  FirebaseStorage storage = FirebaseStorage.instance;
  try {
    await storage
        .ref("categories/" +insertedDocId+ photoURL.substring(photoURL.lastIndexOf('.')))
        .putFile(await urlToFile(photoURL));
  }catch(e){
    log("画像保存でエラー");
  }
  await FirebaseFirestore.instance
      .collection('categories')
      .doc(insertedDocId)
      .update({
    'readableFlg': true,
    'photoUpdateCnt':1,
    'updateUserDocId':ref.watch(userDataProvider.notifier).userData["userDocId"],
    'updateProgramId': "insertTestCategoriesData",
    'updateTime': FieldValue.serverTimestamp(),
  });

}