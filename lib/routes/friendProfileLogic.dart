import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../commonEntity/userEntity.dart';

Future<void> insertFriend(WidgetRef ref,String friendUserDocId) async{

  DocumentSnapshot<Map<String, dynamic>>firebaseUserData = await FirebaseFirestore.instance
      .collection('users')
      .doc(friendUserDocId)
      .get();
//TODO データ登録直前にすでにフレンドデータがないかチェックする。
  //相手側のFriendデータもFirebaseのみに作成する
  FirebaseFirestore.instance.collection('friends').add(
    {'userDocId':friendUserDocId,
      'friendUserDocId': ref.watch(userDataProvider).userData["userDocId"],
      'friendUserName': ref.watch(userDataProvider).userData["name"],
      'profilePhotoNameSuffix':ref.watch(userDataProvider).userData["profilePhotoNameSuffix"] ,
      'profilePhotoUpdateCnt': ref.watch(userDataProvider).userData["profilePhotoUpdateCnt"] ,
      'lastMessageContent': "",
      'lastMessageDocId': null,
      'lastMessageTime': FieldValue.serverTimestamp(),
      'insertUserDocId':ref.watch(userDataProvider).userData["userDocId"],
      'insertProgramId': "friendProfile",
      'insertTime': FieldValue.serverTimestamp(),
      'updateUserDocId':ref.watch(userDataProvider.notifier).userData["userDocId"],
      'updateProgramId': "friendProfile",
      'updateTime': FieldValue.serverTimestamp(),
      'readableFlg': true,
      'deleteFlg': false,
    },
  );

  FirebaseFirestore.instance.collection('friends').add(
    {'userDocId':ref.watch(userDataProvider).userData["userDocId"] ,
      'friendUserDocId': friendUserDocId,
      'friendUserName': firebaseUserData["name"] ,
      'profilePhotoNameSuffix': firebaseUserData["profilePhotoNameSuffix"] ,
      'profilePhotoUpdateCnt': firebaseUserData["profilePhotoUpdateCnt"] ,
      'lastMessageContent': "",
      'lastMessageDocId': null,
      'lastMessageTime': FieldValue.serverTimestamp(),
      'insertUserDocId':ref.watch(userDataProvider).userData["userDocId"],
      'insertProgramId': "friendProfile",
      'insertTime': FieldValue.serverTimestamp(),
      'updateUserDocId':ref.watch(userDataProvider.notifier).userData["userDocId"],
      'updateProgramId': "friendProfile",
      'updateTime': FieldValue.serverTimestamp(),
      'readableFlg': true,
      'deleteFlg': false,
    },
  );

}