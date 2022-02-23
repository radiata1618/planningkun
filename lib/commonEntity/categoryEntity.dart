import 'dart:async';
import 'dart:core';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:isar/isar.dart';
import 'package:planningkun/config/categoryDatabase.dart' as category;

import '../commonLogic/commonLogic.dart';

final categoryDataProvider = ChangeNotifierProvider(
      (ref) => CategoryDataNotifier(),
);

class CategoryDataNotifier extends ChangeNotifier {
  Stream<QuerySnapshot>? _callStream;
  final controller = StreamController<bool>();
  StreamSubscription<QuerySnapshot>? streamSub;

  void closeStream() async {
    streamSub!.cancel();
  }

  void clearIsar()async {


    var boxSetting = Hive.box('setting');
    await boxSetting.put("categoriesUpdateCheck",DateTime(2022, 1, 1, 0, 0));
    var isarInstance = Isar.getInstance();
    await isarInstance?.writeTxn((isar) async {
      isar.categorys.clear();
    });
  }

  void controlStreamOfReadCategoryNewDataFromFirebaseToIsar()async {

    //最初は必ず呼び出し
    //log("XXXXXXXXXXXXX初回readCategoryNewDataFromFirebaseToHiveAndMemorycallする");
    streamSub=await readCategoryNewDataFromFirebaseToIsar();
    //log("XXXXXXXXXXXXX初回readCategoryNewDataFromFirebaseToHiveAndMemorycallした");

    if(controller.hasListener){

    }else{
      //log("XXXXXXXXXXXXXControlListener開始");
      //2回目以降は新しいデータを更新するたびに起動
      controller.stream.listen((value)  async{
        streamSub!.cancel();
        //log("XXXXXXXXXXXXXreadCategoryNewDataFromFirebaseToHiveAndMemorycallする");
        streamSub=await readCategoryNewDataFromFirebaseToIsar();
        //log("XXXXXXXXXXXXXreadCategoryNewDataFromFirebaseToHiveAndMemorycallした");
      });
    }

  }

  Future<StreamSubscription<QuerySnapshot>> readCategoryNewDataFromFirebaseToIsar() async {
    var boxSetting = Hive.box('setting');
    DateTime categoryUpdatedTime = await boxSetting.get("categoriesUpdateCheck");

    ////log("XXXXXXXXXXXXXQueryする"+categoryUpdatedTime.toString());
    _callStream = FirebaseFirestore.instance
        .collection('categories')
        .where('updateTime',
        isGreaterThan: Timestamp.fromDate(categoryUpdatedTime))
        .where('readableFlg', isEqualTo: true)
        .orderBy('updateTime', descending: false)
        .snapshots();


    StreamSubscription<QuerySnapshot> streamSub=_callStream!.listen((QuerySnapshot snapshot) async {
      if (snapshot.size != 0) {
        for(int i=0;i<snapshot.size;i++){

          if(snapshot.docs[i].get("deleteFlg")){

            var isarInstance = Isar.getInstance();
            await isarInstance?.writeTxn((isar) async {
              await isar.categorys.filter()
                  .categoryDocIdEqualTo(snapshot.docs[i].id)
                  .deleteAll();
            });

          }else{

            var isarInstance = Isar.getInstance();
            await isarInstance?.writeTxn((isar) async {
              List<category.Category> resultList = await isar.categorys.filter()
                  .categoryDocIdEqualTo(snapshot.docs[i].id)
                  .findAll();

              //画像ファイルの取得
              FirebaseStorage storage = FirebaseStorage.instance;
              Reference imageRef = storage.ref().child("categories").child(snapshot.docs[i].id + snapshot.docs[i].get("photoNameSuffix"));
              String imageUrl = await imageRef.getDownloadURL();
              File imgFile=await urlToFile(imageUrl);
              Uint8List? bytes;

              await imgFile.readAsBytes().then((value) {
                bytes = Uint8List.fromList(value);
                log('reading of bytes is completed');
              }).catchError((onError) {
                log('Exception Error while reading audio from path:' +
                    onError.toString());
              });

              if(resultList.length==0){

                final newCategory = new category.Category(
                    snapshot.docs[i].id,
                    snapshot.docs[i].get("categoryName"),
                    bytes!,
                    snapshot.docs[i].get("photoNameSuffix"),
                    snapshot.docs[i].get("photoUpdateCnt"),
                    snapshot.docs[i].get("insertUserDocId"),
                    snapshot.docs[i].get("insertProgramId"),
                    snapshot.docs[i].get("insertTime").toDate(),
                    snapshot.docs[i].get("updateUserDocId"),
                    snapshot.docs[i].get("updateProgramId"),
                    snapshot.docs[i].get("updateTime").toDate(),
                    snapshot.docs[i].get("readableFlg"),
                    snapshot.docs[i].get("deleteFlg"));

                newCategory.id = await isar.categorys.put(newCategory);// insert

              }else{
                resultList[0].categoryDocId=snapshot.docs[i].id;
                resultList[0].categoryName=snapshot.docs[i].get("categoryName");
                resultList[0].photoFile=bytes!;
                resultList[0].photoNameSuffix=snapshot.docs[i].get("photoNameSuffix");
                resultList[0].photoUpdateCnt=snapshot.docs[i].get("photoUpdateCnt");
                resultList[0].insertUserDocId=snapshot.docs[i].get("insertUserDocId");
                resultList[0].insertProgramId=snapshot.docs[i].get("insertProgramId");
                resultList[0].insertTime=snapshot.docs[i].get("insertTime").toDate();
                resultList[0].updateUserDocId=snapshot.docs[i].get("updateUserDocId");
                resultList[0].updateProgramId=snapshot.docs[i].get("updateProgramId");
                resultList[0].updateTime=snapshot.docs[i].get("updateTime").toDate();
                resultList[0].readableFlg=snapshot.docs[i].get("readableFlg");
                resultList[0].deleteFlg=snapshot.docs[i].get("deleteFlg");

                await isar.categorys.put(resultList[0]);
              }
            });
          }
          if (snapshot.docs[i].get("updateTime").toDate().isAfter(categoryUpdatedTime)) {
            categoryUpdatedTime = snapshot.docs[i].get("updateTime").toDate();
            await boxSetting.put("categoriesUpdateCheck", categoryUpdatedTime);
          }

        }
        notifyListeners();
        controller.sink.add(true);
      }

    });
    return streamSub;
  }
}
