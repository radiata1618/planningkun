import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

import 'package:firebase_storage/firebase_storage.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../firebase_config.dart';
import '../NotUse_tabs_page.dart';
import '../commonEntity.dart';
import 'SearchConditionValueEdit.dart';


class SearchConditionPage extends StatefulWidget {
  Map<String, String>  argumentUserData;
  Map<String, String> argumentMasterData;
  bool argumentSearchProcessFlg;

  SearchConditionPage({required this.argumentUserData, required this.argumentMasterData,required this.argumentSearchProcessFlg});

  @override
  _SearchConditionPage createState() => _SearchConditionPage();
}

class _SearchConditionPage extends State<SearchConditionPage> {
  bool initialProcessFlg=true;

  var box;
  var firebaseUserData;


  Future<void> getFirebaseData() async {

    firebaseUserData =await FirebaseFirestore.instance.collection('users').doc(widget.argumentUserData["userDocId"]).get();
    box = await Hive.openBox('record');

    //FirebaseのデータをHiveに取得

    await arrangeUserDataUnit("searchConditionAge");
    await arrangeUserDataUnit("searchConditionLevel");
    await arrangeUserDataUnit("searchConditionNativeLang");
    await arrangeUserDataUnit("searchConditionCountry");
    await arrangeUserDataUnit("searchConditionGender");

    await box.close();//Closeするとエラーになるのでオープンしたまま


    setState(()  {

    });
  }

  Future<void> arrangeUserDataUnit(String item) async {
    await box.put(item,firebaseUserData.get(item));
    widget.argumentUserData[item]=await firebaseUserData.get(item);
  }


  @override
  Widget build(BuildContext context) {

    if (initialProcessFlg){
      initialProcessFlg=false;
      getFirebaseData();
    }


    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white10,
          elevation: 0.0,
          title: Text("SearchConditionPages",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 21,
              color: Colors.black87,
            ), // <- (※2)
          ),),
        body: SingleChildScrollView(
          child: SafeArea(
              child: Column(children: <Widget>[
                linePadding("Age","searchConditionAge", widget.argumentUserData["searchConditionAge"]!),
                linePadding("Level","searchConditionLevel", widget.argumentUserData["searchConditionLevel"]!),
                linePadding("Mother tongue","searchConditionNativeLang", widget.argumentUserData["searchConditionNativeLang"]!),
                linePadding("Country","searchConditionCountry", widget.argumentUserData["searchConditionCountry"]!),
                linePadding("Gender","searchConditionGender", widget.argumentUserData["searchConditionGender"]!),
              ])),
        ));
  }

  Padding linePadding (String displayedItem,String databaseItem, String value) {

    String displayedValue;
    if(databaseItem=="searchConditionLevel"
        ||databaseItem=="searchConditionGender"){
      //displayedValue=widget.argumentMasterData[databaseItem+"_"+value]!;

      displayedValue=value;

    }else if(databaseItem=="searchConditionAge"){

      displayedValue=value;

    }else{
      displayedValue=value;
    }
    return Padding(
        padding: const EdgeInsets.only(left:14,right:14,bottom:10),
        child: Container(
          height: 52,
          child:Column(children:[
            Container(
              width: double.infinity,
              child: Text(
                displayedItem,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 12,
                  color: Colors.deepOrange,
                ),
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Container(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(displayedValue,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 18,
                          color: Colors.black87,
                        ),),

                      Padding(padding:const EdgeInsets.only(left:5),
                        child:GestureDetector(
                            onTap: () async{
                              await Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) {
                                  return SearchConditionValueEdit(
                                    argumentUserData: widget.argumentUserData,
                                    argumentMasterData:widget.argumentMasterData ,
                                    displayedItem: displayedItem,
                                    databaseItem: databaseItem,
                                    value:value,
                                  );
                                }),
                              );
                              setState(()  {

                              });//TODO FutureBuilderを使用するようにして非同期のデータ取得のあとSetStateするダサい処理を削除したい
                            },
                            child: Icon(
                                Icons.edit,
                                color: Colors.black87,
                                size:18
                            )
                        ),)]),
              )
            ]),
          ]),
          decoration: BoxDecoration(
            border: const Border(
              bottom: const BorderSide(
                color: Colors.black26,
                width: 0.5,
              ),
            ),
          ),
        ));
  }
}
