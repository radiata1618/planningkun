
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../commonEntity/userEntity.dart';

Future<void> insertFriend(WidgetRef ref,String friendUserDocId) async{

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
      'lastMessageDocId': null,
      'lastMessageTime': null,
      'insertUserDocId':ref.watch(userDataProvider).userData["userDocId"],
      'insertProgramId': "friendProfile",
      'insertTime': FieldValue.serverTimestamp(),
      'updateUserDocId':ref.watch(userDataProvider.notifier).userData["userDocId"],
      'updateProgramId': "friendProfile",
      'updateTime': FieldValue.serverTimestamp(),
      'readableFlg': false,
      'deleteFlg': false,
    },
  );

  FirebaseFirestore.instance.collection('friends').add(
    {'userDocId':ref.watch(userDataProvider).userData["userDocId"] ,
      'friendUserDocId': friendUserDocId,
      'friendUserName': firebaseUserData["name"] ,
      'profilePhotoPath': firebaseUserData["profilePhotoPath"] ,
      'profilePhotoUpdateCnt': firebaseUserData["profilePhotoUpdateCnt"] ,
      'lastMessageContent': "",
      'lastMessageDocId': null,
      'lastMessageTime': null,
      'insertUserDocId':ref.watch(userDataProvider).userData["userDocId"],
      'insertProgramId': "friendProfile",
      'insertTime': FieldValue.serverTimestamp(),
      'updateUserDocId':ref.watch(userDataProvider.notifier).userData["userDocId"],
      'updateProgramId': "friendProfile",
      'updateTime': FieldValue.serverTimestamp(),
      'readableFlg': false,
      'deleteFlg': false,
    },
  );

}