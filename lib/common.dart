import 'dart:async';
import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
