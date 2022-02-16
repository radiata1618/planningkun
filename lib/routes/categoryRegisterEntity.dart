import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planningkun/commonEntity/userData.dart';
import '../commonEntity/commonEntity.dart';

final categoryNameProvider = StateProvider.autoDispose((ref) {
  return '';
});

class CategoryImagePhotoFile extends ChangeNotifier {
  File? _categoryImagePhotoFile;
  get categoryImagePhotoFile => _categoryImagePhotoFile;

  void clearCategoryImagePhotoFile() {
    _categoryImagePhotoFile = null;
    notifyListeners();
  }

  void setCategoryImagePhotoFile(File? imageFile) {
    _categoryImagePhotoFile = imageFile;
    notifyListeners();
  }
}

final categoryImagePhotoFileProvider =
    ChangeNotifierProvider((ref) => CategoryImagePhotoFile());

Future<void> insertCategory(WidgetRef ref, String categoryName) async {
  String insertedDocId = "";

  try {
    await FirebaseFirestore.instance.collection('categories').add(
      {
        'categoryName': categoryName,
        'photoPath': '',
        'photoUpdateCnt': '0',
        'insertUserDocId':
            ref.watch(userDataProvider.notifier).userData["userDocId"],
        'insertProgramId': "CategoryRegister",
        'insertTime': DateTime.now().toString(),
      },
    ).then((value) {
      insertedDocId = value.id;
    });
    //TODO 各トピックデータのカテゴリ名も更新しにいく？（冗長データを持つ）非正規化を健闘

    FirebaseStorage storage = FirebaseStorage.instance;
    String pathStr = ref
        .watch(categoryImagePhotoFileProvider.notifier)
        .categoryImagePhotoFile!
        .path;
    await storage
        .ref("categories/" +
            insertedDocId +
            pathStr.substring(
              pathStr.lastIndexOf('.'),
            ))
        .putFile(ref
            .watch(categoryImagePhotoFileProvider.notifier)
            .categoryImagePhotoFile!);
    //TODO 拡張子はPNGとは限らない。

    await FirebaseFirestore.instance
        .collection('categories')
        .doc(insertedDocId)
        .update({
      "photoUpdateCnt": "1",
      "photoPath": "categories/" +
          insertedDocId +
          pathStr.substring(
            pathStr.lastIndexOf('.'),
          ),
      'updateUserDocId':
          ref.watch(userDataProvider.notifier).userData["userDocId"],
      'updateProgramId': "CategoryRegister",
      'updateTime': DateTime.now().toString(),
    });

    //TODO Hive,メモリへのデータ登録
  } catch (e) {
    print(e);
  }
}
