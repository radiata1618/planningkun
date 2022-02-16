import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../commonEntity.dart';

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