import 'dart:async';
import 'dart:core';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:planningkun/commonEntity/userData.dart';

import '../commonEntity/commonEntity.dart';

class UserItemDataNotifier extends ChangeNotifier {
  String _userItemDataDisplayedItem = "";
  String get userItemDisplayedItem => _userItemDataDisplayedItem;

  String _userItemDataDatabaseItem = "";
  String get userItemDataDatabaseItem => _userItemDataDatabaseItem;

  String _userItemDataValue = "";
  String get userItemDataValue => _userItemDataValue;

  void initialize(String displayedItem, String databaseItem, String value) {
    _userItemDataDisplayedItem = displayedItem;
    _userItemDataDatabaseItem = databaseItem;
    _userItemDataValue = value;
    notifyListeners();
  }

  void setUserItemDataValue(String userItemDataValue){
    _userItemDataValue = userItemDataValue;
  }

  Future<void> updateUserInfo(BuildContext context, WidgetRef ref) async {
    String userDocId =ref.watch(userDataProvider.notifier).userData["userDocId"]!;
    //TODO 名前を変更する場合は、Friendデータも更新する
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userDocId)
        .update({
      userItemDataDatabaseItem: userItemDataValue,
      'updateUserDocId': userDocId,
      'updateProgramId': "settingEditPage",
      'updateTime': DateTime.now().toString(),
    });


    var box = await Hive.openBox('record');

    //FirebaseのデータをHiveに取得
    await box.put(userItemDataDatabaseItem, userItemDataValue);
    await box.close();

    ref.watch(userDataProvider.notifier).setUnitItem(userItemDataDatabaseItem,userItemDataValue);


    //age　など、検索で使う項目は数値情報も追加で保持
    if (userItemDataDatabaseItem == "age") {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userDocId)
          .update({
        "ageNumber": int.parse(userItemDataValue),
        'updateUserDocId': userDocId,
        'updateProgramId': "settingEditPage",
        'updateTime': DateTime.now().toString()
      });
    }
  }
}

final userItemDataProvider = ChangeNotifierProvider(
  (ref) => UserItemDataNotifier(),
);
