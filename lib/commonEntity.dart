import 'dart:async';
import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

//TODO Main モジュールでFirebaseからデータが取得できないとき、Hiveのデータをメモリに読み出すように処理をCOMMONに追加する。

const Color themeColorDeep =Colors.orangeAccent;
Text GrayText(String txt) {
  return Text(txt,
    style: TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 16,
      color: Colors.black45,
    ),

  );
}
List<String> FromTextToList(String txt){

  String workText =txt;
  List<String> outputList=[];

  for (;workText.contains(',');){
    outputList.add(workText.substring(0, workText.indexOf(',')));
    workText=workText.substring(workText.indexOf(',')+1);
  }
  outputList.add(workText);

  return outputList;

}

//Firebase ログ・イン情報を保持するためのProviderクラス
//https://www.flutter-study.dev/firebase-app/riverpod
// ユーザー情報の受け渡しを行うためのProvider
final userProvider = StateProvider((ref) {
  return FirebaseAuth.instance.currentUser;
});

// エラー情報の受け渡しを行うためのProvider
// ※ autoDisposeを付けることで自動的に値をリセットできます
final infoTextProvider = StateProvider.autoDispose((ref) {
  return '';
});

// メールアドレスの受け渡しを行うためのProvider
// ※ autoDisposeを付けることで自動的に値をリセットできます
final emailProvider = StateProvider.autoDispose((ref) {
  return '';
});

// パスワードの受け渡しを行うためのProvider
// ※ autoDisposeを付けることで自動的に値をリセットできます
final passwordProvider = StateProvider.autoDispose((ref) {
  return '';
});

// メッセージの受け渡しを行うためのProvider
// ※ autoDisposeを付けることで自動的に値をリセットできます
final messageTextProvider = StateProvider.autoDispose((ref) {
  return '';
});



// StreamProviderを使うことでStreamも扱うことができる
// ※ autoDisposeを付けることで自動的に値をリセットできます
final postsQueryProvider = StreamProvider.autoDispose((ref) {
  return FirebaseFirestore.instance
      .collection('posts')
      .orderBy('date')
      .snapshots();
});

//
// final userDataProvidertest = StreamProvider<QuerySnapshot<Map<String, dynamic>>>((ref,email) {
//   return FirebaseFirestore.instance
//       .collection('posts')
//       .orderBy('date')
//       .snapshots();
// });
//
//
// class  User {
// User(this.id, this.name);
//
// final String id;
// final String name;
// }

final userDataProvider = Provider.family<Stream<QuerySnapshot<Map<String, dynamic>>>, String>((ref, email) {

  final Stream<QuerySnapshot<Map<String, dynamic>>> _callStream =  FirebaseFirestore.instance
      .collection('users')
      .where('email', isEqualTo: email)
      .snapshots();

    _callStream.listen((QuerySnapshot snapshot) async{
      if(snapshot.size!=0){

        // String userDocId=snapshot!.docs[0].id;

        //Hiveボックスをオープン
        // var box = await Hive.openBox('record');
        //
        // //TODO　もともとのユーザとことなるユーザがログインされたら、警告を出して、リセット
        // await box.put("userDocId",userDocId);
        // userData["userDocId"]=userDocId;
        // await arrangeUserDataUnit("name");
        // await arrangeUserDataUnit("email");
        // await arrangeUserDataUnit("age");
        // await arrangeUserDataUnit("level");
        // await arrangeUserDataUnit("occupation");
        // await arrangeUserDataUnit("nativeLang");
        // await arrangeUserDataUnit("country");
        // await arrangeUserDataUnit("town");
        // await arrangeUserDataUnit("homeCountry");
        // await arrangeUserDataUnit("homeTown");
        // await arrangeUserDataUnit("gender");
        // await arrangeUserDataUnit("placeWannaGo");
        // await arrangeUserDataUnit("greeting");
        // await arrangeUserDataUnit("description");
        // await arrangeUserDataUnit("searchConditionAge");
        // await arrangeUserDataUnit("searchConditionLevel");
        // await arrangeUserDataUnit("searchConditionNativeLang");
        // await arrangeUserDataUnit("searchConditionCountry");
        // await arrangeUserDataUnit("searchConditionGender");
        // await arrangeUserDataUnit("profilePhotoPath");
        // await arrangeUserDataUnit("profilePhotoUpdateCnt");
        //
        //
        // await box.close();

      }

    });

    return _callStream;

});