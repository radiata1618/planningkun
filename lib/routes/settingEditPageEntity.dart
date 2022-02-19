import 'dart:async';
import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planningkun/commonEntity/userEntity.dart';


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
    String userDocId = ref
        .watch(userDataProvider.notifier)
        .userData["userDocId"]!;

    if (userItemDataDatabaseItem == "age") {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userDocId)
          .update({
        "age": userItemDataValue,
        "ageNumber": int.parse(userItemDataValue),
        'updateUserDocId': userDocId,
        'updateProgramId': "settingEditPage",
        'updateTime': FieldValue.serverTimestamp(),
      });
    }else{

      //TODO Name，Ageを変更する場合は、Friendデータも更新する
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userDocId)
          .update({
        userItemDataDatabaseItem: userItemDataValue,
        'updateUserDocId': userDocId,
        'updateProgramId': "settingEditPage",
        'updateTime': FieldValue.serverTimestamp(),
      });
    }
  }
}

final userItemDataProvider = ChangeNotifierProvider(
  (ref) => UserItemDataNotifier(),
);
