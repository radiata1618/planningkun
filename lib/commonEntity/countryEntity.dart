import 'dart:async';
import 'dart:core';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:planningkun/config/countryDatabase.dart';
import '../commonLogic/commonLogic.dart';

final countryDataProvider = ChangeNotifierProvider(
      (ref) => CountryDataNotifier(),
);

class CountryDataNotifier extends ChangeNotifier {

  Map<String, Map<String, dynamic>> _countryData = {}; //キーはFriendのuserDocId
  get countryData => _countryData;

  Stream<QuerySnapshot>? _callStream;
  final controller = StreamController<bool>();
  StreamSubscription<QuerySnapshot>? streamSub;

  void closeStream() async {
    streamSub!.cancel();
  }

  void clearIsar()async {


    var boxSetting = Hive.box('setting');
    await boxSetting.put("countriesUpdateCheck",DateTime(2022, 1, 1, 0, 0));
    var isarInstance = Isar.getInstance();
    await isarInstance?.writeTxn((isar) async {
      isar.countrys.clear();
    });
  }

  Future<void> readCountryDataFromIsarToMemory() async {
    //データリセット
    _countryData ={};
    Map<String,dynamic> tmpMap ={};

    var isarInstance = Isar.getInstance();
    await isarInstance?.writeTxn((isar) async {
      List<Country> resultList = await isar.countrys.filter()
          .deleteFlgEqualTo(false)
          .findAll();

      for(int i =0;i<resultList.length;i++){
        tmpMap={
          "countryDocId":resultList[i].countryDocId,
          "countryName":resultList[i].countryName,
          "countryCode":resultList[i].countryCode,
          "imageFile":Image.memory(resultList[i].imageFile),
          "imageNameSuffix":resultList[i].imageNameSuffix,
          "imageUpdateCnt":resultList[i].imageUpdateCnt,
          "insertUserDocId":resultList[i].insertUserDocId,
          "insertProgramId":resultList[i].insertProgramId,
          "insertTime":resultList[i].insertTime,
          "updateUserDocId":resultList[i].updateUserDocId,
          "updateProgramId":resultList[i].updateProgramId,
          "updateTime":resultList[i].updateTime,
          "readableFlg":resultList[i].readableFlg,
          "deleteFlg":resultList[i].deleteFlg,
        };

        _countryData[resultList[i].countryCode]=tmpMap;

      }
    });

  }

  void controlStreamOfReadCountryNewDataFromFirebaseToIsarAndMemory()async {

    //最初は必ず呼び出し
    //log("XXXXXXXXXXXXX初回readCountryNewDataFromFirebaseToHiveAndMemorycallする");
    streamSub=await readCountryNewDataFromFirebaseToIsarAndMemory();
    //log("XXXXXXXXXXXXX初回readCountryNewDataFromFirebaseToHiveAndMemorycallした");

    if(controller.hasListener){

    }else{
      //log("XXXXXXXXXXXXXControlListener開始");
      //2回目以降は新しいデータを更新するたびに起動
      controller.stream.listen((value)  async{
        streamSub!.cancel();
        //log("XXXXXXXXXXXXXreadCountryNewDataFromFirebaseToHiveAndMemorycallする");
        streamSub=await readCountryNewDataFromFirebaseToIsarAndMemory();
        //log("XXXXXXXXXXXXXreadCountryNewDataFromFirebaseToHiveAndMemorycallした");
      });
    }

  }

  Future<StreamSubscription<QuerySnapshot>> readCountryNewDataFromFirebaseToIsarAndMemory() async {
    var boxSetting = Hive.box('setting');
    DateTime countryUpdatedTime = await boxSetting.get("countriesUpdateCheck");
    Uint8List? bytes;

    ////log("XXXXXXXXXXXXXQueryする"+countryUpdatedTime.toString());
    _callStream = FirebaseFirestore.instance
        .collection('countries')
        .where('updateTime',
        isGreaterThan: Timestamp.fromDate(countryUpdatedTime))
        .where('readableFlg', isEqualTo: true)
        .orderBy('updateTime', descending: false)
        .snapshots();


    StreamSubscription<QuerySnapshot> streamSub=_callStream!.listen((QuerySnapshot snapshot) async {
      if (snapshot.size != 0) {
        for(int i=0;i<snapshot.size;i++){
          //画像ファイルの取得
          FirebaseStorage storage = FirebaseStorage.instance;

          Reference imageRef = storage.ref().child("countries").child(snapshot.docs[i].id + snapshot.docs[i].get("imageNameSuffix"));
          String imageUrl = await imageRef.getDownloadURL();
          File imgFile=await urlToFile(imageUrl);

          await imgFile.readAsBytes().then((value) {
            bytes = Uint8List.fromList(value);
            log('reading of bytes is completed');
          }).catchError((onError) {
            log('Exception Error while reading audio from path:' +
                onError.toString());
          });

          if(snapshot.docs[i].get("deleteFlg")){

            var isarInstance = Isar.getInstance();
            await isarInstance?.writeTxn((isar) async {
              await isar.countrys.filter()
                  .countryDocIdEqualTo(snapshot.docs[i].id)
                  .deleteAll();
            });
            
            _countryData.remove(snapshot.docs[i].get("countryCode"));

          }else{

            var isarInstance = Isar.getInstance();
            await isarInstance?.writeTxn((isar) async {
              List<Country> resultList = await isar.countrys.filter()
                  .countryDocIdEqualTo(snapshot.docs[i].id)
                  .findAll();



              if(resultList.length==0){

                final newCountry = new Country(
                    snapshot.docs[i].id,
                    snapshot.docs[i].get("countryName"),
                    snapshot.docs[i].get("countryCode"),
                    bytes!,
                    snapshot.docs[i].get("imageNameSuffix"),
                    snapshot.docs[i].get("imageUpdateCnt"),
                    snapshot.docs[i].get("insertUserDocId"),
                    snapshot.docs[i].get("insertProgramId"),
                    snapshot.docs[i].get("insertTime").toDate(),
                    snapshot.docs[i].get("updateUserDocId"),
                    snapshot.docs[i].get("updateProgramId"),
                    snapshot.docs[i].get("updateTime").toDate(),
                    snapshot.docs[i].get("readableFlg"),
                    snapshot.docs[i].get("deleteFlg"));

                newCountry.id = await isar.countrys.put(newCountry);// insert

              }else{
                resultList[0].countryDocId=snapshot.docs[i].id;
                resultList[0].countryName=snapshot.docs[i].get("countryName");
                resultList[0].countryCode=snapshot.docs[i].get("countryCode");
                resultList[0].imageFile=bytes!;
                resultList[0].imageNameSuffix=snapshot.docs[i].get("imageNameSuffix");
                resultList[0].imageUpdateCnt=snapshot.docs[i].get("imageUpdateCnt");
                resultList[0].insertUserDocId=snapshot.docs[i].get("insertUserDocId");
                resultList[0].insertProgramId=snapshot.docs[i].get("insertProgramId");
                resultList[0].insertTime=snapshot.docs[i].get("insertTime").toDate();
                resultList[0].updateUserDocId=snapshot.docs[i].get("updateUserDocId");
                resultList[0].updateProgramId=snapshot.docs[i].get("updateProgramId");
                resultList[0].updateTime=snapshot.docs[i].get("updateTime").toDate();
                resultList[0].readableFlg=snapshot.docs[i].get("readableFlg");
                resultList[0].deleteFlg=snapshot.docs[i].get("deleteFlg");

                await isar.countrys.put(resultList[0]);
                log("donload countries "+resultList[0].countryName+snapshot.docs[i].get("countryName"));
              }
            });

            Map<String,dynamic> tmpMap={
              "countryDocId":snapshot.docs[i].id,
              "countryName":snapshot.docs[i].get("countryName"),
              "countryCode":snapshot.docs[i].get("countryCode"),
              "imageFile":Image.memory(bytes!),
              "imageNameSuffix":snapshot.docs[i].get("imageNameSuffix"),
              "imageUpdateCnt":snapshot.docs[i].get("imageUpdateCnt"),
              "insertUserDocId":snapshot.docs[i].get("insertUserDocId"),
              "insertProgramId":snapshot.docs[i].get("insertProgramId"),
              "insertTime":snapshot.docs[i].get("insertTime").toDate(),
              "updateUserDocId":snapshot.docs[i].get("updateUserDocId"),
              "updateProgramId":snapshot.docs[i].get("updateProgramId"),
              "updateTime":snapshot.docs[i].get("updateTime").toDate(),
              "readableFlg":snapshot.docs[i].get("readableFlg"),
              "deleteFlg":snapshot.docs[i].get("deleteFlg"),
            };

            _countryData[snapshot.docs[i].get("countryCode")]=tmpMap;

          }
          if (snapshot.docs[i].get("updateTime").toDate().isAfter(countryUpdatedTime)) {
            countryUpdatedTime = snapshot.docs[i].get("updateTime").toDate();
            await boxSetting.put("countriesUpdateCheck", countryUpdatedTime);
          }

        }
        notifyListeners();
        controller.sink.add(true);
      }

    });
    return streamSub;
  }
}
