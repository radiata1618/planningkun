import 'dart:async';
import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

final masterDataProvider = ChangeNotifierProvider(
      (ref) => MasterDataProvider(),
);


class MasterDataProvider extends ChangeNotifier {
  Map<String,String> _masterData={};
  Map<String,String> get masterData => _masterData ;

  Future<void> readMasterDataFromFirebaseToHiveAndMemory() async {

    var boxMaster = await Hive.openBox('master');
    await FirebaseFirestore.instance.collection('masters').get().then((QuerySnapshot snapshot)async {

      await boxMaster.clear();
      masterData.clear();

      snapshot.docs.forEach((doc) async{

        //Hiveとメモリにデータをセットする処理を追加
        await boxMaster.put(doc.get('item')+"_"+doc.get('selectedValue'),doc.get('displayedValue'));
        masterData[doc.get('item')+"_"+doc.get('selectedValue')]=doc.get('displayedValue');
      });

    });
    await boxMaster.close();
    notifyListeners();
  }
}

