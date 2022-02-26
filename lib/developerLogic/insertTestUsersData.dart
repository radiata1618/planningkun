import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/src/consumer.dart';

import '../commonEntity/userEntity.dart';
import '../commonLogic/commonLogic.dart';

Future<void> insertTestUserData(WidgetRef ref) async {
  insertUnitData(ref,"wendy",37,"1","JPN","https://cdn.with.is/uploads/group/icon/44295/image_190824233619.jpg");
  insertUnitData(ref,"gene",21,"1","JPN","https://cdn.with.is/uploads/group/icon/10061/image_170515223502.jpg");
  insertUnitData(ref,"macky",45,"1","JPN","https://cdn.with.is/uploads/group/icon/671/image.jpg");
  insertUnitData(ref,"marc",17,"1","JPN","https://cdn.with.is/uploads/group/icon/5069/image_161114054531.jpg");
  insertUnitData(ref,"wendy",50,"1","JPN","https://cdn.with.is/uploads/group/icon/13107/image_170819003830.jpg");
  insertUnitData(ref,"idolic",34,"2","JPN","https://cdn.with.is/uploads/group/icon/11649/170709201434.jpg");
  insertUnitData(ref,"mimi",78,"2","JPN","https://cdn.with.is/uploads/group/icon/4573/image_161028015519.jpg");
  insertUnitData(ref,"cail",29,"2","JPN","https://cdn.with.is/uploads/group/icon/3918/image_161001160804.jpg");
  insertUnitData(ref,"wan",70,"2","JPN","https://cdn.with.is/uploads/group/icon/2000/image_160807115050.jpg");
  insertUnitData(ref,"loi",41,"2","USA","https://cdn.with.is/uploads/group/icon/22951/_.jpg");
  insertUnitData(ref,"coco",33,"2","USA","https://cdn.with.is/uploads/group/icon/2037/image_160808024141.jpg");
  insertUnitData(ref,"ois",87,"2","USA","https://cdn.with.is/uploads/group/icon/5427/image_161126023851.jpg");
  insertUnitData(ref,"lam",34,"2","USA","https://cdn.with.is/uploads/group/icon/1027/image.jpg");
  insertUnitData(ref,"cindy",78,"2","USA","https://cdn.with.is/uploads/group/icon/998/image.jpg");
  insertUnitData(ref,"qeii",29,"2","USA","https://cdn.with.is/uploads/group/icon/9343/170415124610.jpg");
  insertUnitData(ref,"natsu",70,"1","USA","https://cdn.with.is/uploads/group/icon/6158/image_161225174710.jpg");
  insertUnitData(ref,"wei",41,"1","USA","https://cdn.with.is/uploads/group/icon/91860/image_220220063316.jpg");
  insertUnitData(ref,"sand",33,"1","USA","https://cdn.with.is/uploads/group/icon/5554/image_161130012110.jpg");
  insertUnitData(ref,"u-ma",87,"1","USA","https://cdn.with.is/uploads/group/icon/7436/4Z20121221GZ0JPG00030300100.jpg");

}

Future<void> insertUnitData(WidgetRef ref, String name,int age,String gender,String country,String photoURL)async {

  String insertedDocId="";

  await FirebaseFirestore.instance.collection('users').add(
      {
        'email': name+"@gmail.com",
        'name': name,
        'age': age.toString(),
        'ageNumber': age,
        'level': "1",
        'occupation': 'consultant',
        'nativeLang': country,
        'country': country,
        'town': "Tokyo",
        'homeCountry': country,
        'homeTown': "Nagano",
        'gender': gender,
        'placeWannaGo': 'antarctic',
        'greeting': 'Hello!! Good Morning',
        'description': "I'm "+name +" and I'm a consultant",
        'searchConditionAge': '18,30',
        'searchConditionLevel': '1,2,3,4',
        'searchConditionNativeLang': 'JPN',
        'searchConditionCountry': 'JPN,USA',
        'searchConditionGender': '1,2,3',
        'profilePhotoNameSuffix':photoURL.substring(photoURL.lastIndexOf('.')),
        'profilePhotoUpdateCnt': 0,
        'lastLoginTime': FieldValue.serverTimestamp(),
        'insertUserDocId':"myself",
        'insertProgramId': "login",
        'insertTime': FieldValue.serverTimestamp(),
        'updateUserDocId':"myself",
        'updateProgramId': "login",
        'updateTime': FieldValue.serverTimestamp(),
        'readableFlg': true,
        'deleteFlg': false,
      }).then((value){
    insertedDocId=value.id;
  });
  FirebaseStorage storage = FirebaseStorage.instance;
  try {
    await storage
        .ref("profile/" +insertedDocId+"/mainPhoto"+ photoURL.substring(photoURL.lastIndexOf('.')))
        .putFile(await urlToFile(photoURL));
  }catch(e){
    log("画像保存でエラー");
  }

  try {
    await storage
        .ref("profile/" +insertedDocId+"/mainPhoto_small"+ photoURL.substring(photoURL.lastIndexOf('.')))
        .putFile(await urlToFile(photoURL));
  }catch(e){
    log("画像保存でエラー"+insertedDocId);
  }
  await FirebaseFirestore.instance
      .collection('users')
      .doc(insertedDocId)
      .update({
    'readableFlg': true,
    'photoUpdateCnt':1,
    'updateUserDocId':ref.watch(userDataProvider.notifier).userData["userDocId"],
    'updateProgramId': "insertTestUserData",
    'updateTime': FieldValue.serverTimestamp(),
  });

}