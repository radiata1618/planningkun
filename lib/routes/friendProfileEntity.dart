import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:planningkun/commonEntity/friendEntity.dart';

import '../commonEntity/commonEntity.dart';
import '../commonEntity/userData.dart';

Future<void> getFireBaseData()async {

}
final friendProfileDataProvider = ChangeNotifierProvider(
      (ref) => FriendProfileDataNotifier(),
);


class FriendProfileDataNotifier extends ChangeNotifier {
  Map<String, String> _friendProfileData = {};
  get friendProfileData => _friendProfileData;

  Image? _friendProfilePhotoData;
  Image? get friendProfilePhotoData => _friendProfilePhotoData;

  Future<void> clearFriendProfileData() async {
    _friendProfileData = {};
    _friendProfilePhotoData=null;
  }

  Future<void> readFriendProfilePhotoDataFromFirebaseToMemory(WidgetRef ref,String userDocId,String photoPath) async {

    if(photoPath.contains("mainPhoto")){
      //写真が登録されている場合

      FirebaseStorage storage =  FirebaseStorage.instance;
      try {

        Reference imageRef = storage.ref().child("profile").child(userDocId).child("mainPhoto."+photoPath.substring(photoPath.lastIndexOf('.') + 1,));
        String imageUrl =await imageRef.getDownloadURL();
         _friendProfilePhotoData =  Image.network(imageUrl, width: 90);


      }catch(e){
        //写真があるはずなのになぜかエラーだった
        _friendProfilePhotoData =null;

      }

    }else{
      //写真が登録されていない場合
      _friendProfilePhotoData =null;
    }
  }


  Future<void> readFriendProfileDataFromFirebase(WidgetRef ref,String friendUserDocId)async {
    DocumentSnapshot docSnapShot = await FirebaseFirestore.instance
        .collection('users')
        .doc(friendUserDocId)
        .get();

    _friendProfileData["userDocId"] = friendUserDocId;
    _friendProfileData["name"] = docSnapShot["name"];
    _friendProfileData["email"] = docSnapShot["email"];
    _friendProfileData["age"] = docSnapShot["age"];
    _friendProfileData["level"] = docSnapShot["level"];
    _friendProfileData["occupation"] = docSnapShot["occupation"];
    _friendProfileData["nativeLang"] = docSnapShot["nativeLang"];
    _friendProfileData["country"] = docSnapShot["country"];
    _friendProfileData["town"] = docSnapShot["town"];
    _friendProfileData["homeCountry"] = docSnapShot["homeCountry"];
    _friendProfileData["homeTown"] = docSnapShot["homeTown"];
    _friendProfileData["gender"] = docSnapShot["gender"];
    _friendProfileData["placeWannaGo"] = docSnapShot["placeWannaGo"];
    _friendProfileData["greeting"] = docSnapShot["greeting"];
    _friendProfileData["description"] = docSnapShot["description"];
    _friendProfileData["profilePhotoPath"] = docSnapShot["profilePhotoPath"];
    if(ref.watch(friendDataProvider).friendData[friendUserDocId]==null){
      _friendProfileData["friendFlg"] = "false";
    }else{
      _friendProfileData["friendFlg"] = "true";

    }
    await readFriendProfilePhotoDataFromFirebaseToMemory(ref,friendUserDocId,docSnapShot["profilePhotoPath"]);
    notifyListeners();

  }

}


Future<void> insertFriend(WidgetRef ref,String friendUserDocId) async{

  String insertedDocId="";
  DocumentSnapshot<Map<String, dynamic>>firebaseUserData = await FirebaseFirestore.instance
      .collection('users')
      .doc(friendUserDocId)
      .get();

  //相手側のFriendデータもFirebaseのみに作成する
  FirebaseFirestore.instance.collection('friends').add(
    {'userDocId':friendUserDocId,
      'friendUserDocId': ref.watch(userDataProvider).userData["userDocId"],
      'friendUserName': ref.watch(userDataProvider).userData["name"],
      'profilePhotoPath':ref.watch(userDataProvider).userData["profilePhotoPath"] ,
      'profilePhotoUpdateCnt': ref.watch(userDataProvider).userData["profilePhotoUpdateCnt"] ,
      'lastMessageContent': "",
      'lastMessageDocId': "",
      'lastTime': DateTime.now().toString(),
      'insertUserDocId':ref.watch(userDataProvider).userData["userDocId"],
      'insertProgramId': "friendProfile",
      'insertTime': DateTime.now().toString(),
    },
  );

  FirebaseFirestore.instance.collection('friends').add(
    {'userDocId':ref.watch(userDataProvider).userData["userDocId"] ,
      'friendUserDocId': friendUserDocId,
      'friendUserName': firebaseUserData["name"] ,
      'profilePhotoPath': firebaseUserData["profilePhotoPath"] ,
      'profilePhotoUpdateCnt': firebaseUserData["profilePhotoUpdateCnt"] ,
      'lastMessageContent': "",
      'lastMessageDocId': "",
      'lastTime': DateTime.now().toString(),
      'insertUserDocId':ref.watch(userDataProvider).userData["userDocId"],
      'insertProgramId': "friendProfile",
      'insertTime': DateTime.now().toString(),
    },
  ).then((value){
    insertedDocId=value.id;
  });

  var friendBox = await Hive.openBox('friend');
  await friendBox.put(friendUserDocId,{
    'friendUserDocId': insertedDocId,
    'friendUserName': firebaseUserData["name"],
    'profilePhotoPath': firebaseUserData["profilePhotoPath"] ,
    'profilePhotoUpdateCnt': firebaseUserData["profilePhotoUpdateCnt"] ,
    'lastMessageContent': "",
    'lastMessageDocId': "",
    'lastTime': DateTime.now().toString(),
  });
  await friendBox.close();

  ref.watch(friendDataProvider).friendData[friendUserDocId]={
    'friendUserDocId': insertedDocId,
    'friendUserName': firebaseUserData["name"],
    'profilePhotoPath': firebaseUserData["profilePhotoPath"] ,
    'profilePhotoUpdateCnt': firebaseUserData["profilePhotoUpdateCnt"],
    'lastMessageContent': "",
    'lastMessageDocId': "",
    'lastTime': DateTime.now().toString(),
  };


  await readFriendPhotoFromFirebaseToDirectoryAndMemory(ref,friendUserDocId);

}