import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:planningkun/routes/settingEditPage.dart';
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
import '../tabs_page.dart';
import '../common.dart';


class Setting extends StatefulWidget {
  Map<String, String>  argumentUserData;
  Map<String, String> argumentMasterData;

  Setting({required this.argumentUserData, required this.argumentMasterData});

  @override
  _Setting createState() => _Setting();
}

class _Setting extends State<Setting> {
  // File? imageFile;
  //
  // Future showImagePicker() async{
  //
  //   final picker = ImagePicker();
  //   final pickedFile=await picker.getImage(source:ImageSource.gallery);
  //   //cameraの設定も可
  //
  //   imageFile = File(pickedFile!.path);
  // }
  Image? _img;
  Text? _text;

  bool initialProcessFlg=true;

  var box;
  var firebaseUserData;


  Future<void> _download(String userDocId) async {
    // ファイルのダウンロード
    // テキスト
    FirebaseStorage storage = await FirebaseStorage.instance;
    Reference textRef = storage.ref().child("DL").child("hello.txt");
    //Reference ref = storage.ref("DL/hello.txt"); // refで一度に書いてもOK

    var data = await textRef.getData();

    // 画像
    Reference imageRef = await storage.ref().child("DL").child("icon.png");
    String imageUrl = await imageRef.getDownloadURL();

    // 画面に反映
    setState(() {
      _img = Image.network(imageUrl);
      _text = Text(ascii.decode(data!));
    });

    Directory appDocDir = await getApplicationDocumentsDirectory();
    File downloadToFile = File("${appDocDir.path}/" + userDocId + ".png");
    try {
      await imageRef.writeToFile(downloadToFile);
    } catch (e) {
      print(e);
    }
  }

  void _upload(String userDocId) async {
    // imagePickerで画像を選択する
    // upload
    PickedFile? pickerFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    File file = File(pickerFile!.path);

    FirebaseStorage storage = FirebaseStorage.instance;
    try {
      await storage.ref("UL/" + userDocId + ".png").putFile(file);

      // await _download(userDocId);
    } catch (e) {
      print(e);
    }
  }


  Future<void> getFirebaseData() async {

    firebaseUserData =await FirebaseFirestore.instance.collection('users').doc(widget.argumentUserData["userDocId"]).get();
    box = await Hive.openBox('record');

    //FirebaseのデータをHiveに取得

    await arrangeUserDataUnit("name");
    await arrangeUserDataUnit("email");
    await arrangeUserDataUnit("age");
    await arrangeUserDataUnit("level");
    await arrangeUserDataUnit("occupation");
    await arrangeUserDataUnit("nativeLang");
    await arrangeUserDataUnit("country");
    await arrangeUserDataUnit("town");
    await arrangeUserDataUnit("homeCountry");
    await arrangeUserDataUnit("homeTown");
    await arrangeUserDataUnit("gender");
    await arrangeUserDataUnit("placeWannaGo");
    await arrangeUserDataUnit("greeting");
    await arrangeUserDataUnit("description");

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
          title: Text("Settings",
        style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 21,
        color: Colors.black87,
          ), // <- (※2)
        ),),
        body: SingleChildScrollView(
          child: SafeArea(
              child: Column(children: <Widget>[
            Container(
                height: 120,
                child: Row(children: <Widget>[
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        if (_text != null) _text!,
                        if (_img != null) _img!,
                      ],
                    ),
                  ),
                  MaterialButton(
                      onPressed: () {
                        _upload(widget.argumentUserData["userDocId"]!);
                      },
                      child: const Text('写真アップロード') //,
                      ),
                  MaterialButton(
                      onPressed: () {
                        _download(widget.argumentUserData["userDocId"]!);
                      },
                      child: const Text('写真ダウンロード') //,
                      //TODO ダウンロード機能が不完全
                      //TODO 画像はローカルのアプリ固有フォルダにも保存して、ローカルにあるならローカルのものを使う⇨DB上のデータなども全般的な話
                      ),
                ])),
                linePadding("Name","name", widget.argumentUserData["name"]!),
                linePadding("E-mail","email", widget.argumentUserData["email"]!),
                linePadding("Age","age", widget.argumentUserData["age"]!),
                linePadding("English Level","level", widget.argumentUserData["level"]!),
                linePadding("Occupation","occupation", widget.argumentUserData["occupation"]!),
                linePadding("mother Tongue","nativeLang", widget.argumentUserData["nativeLang"]!),
                linePadding("Country","country", widget.argumentUserData["country"]!),
                linePadding("Town","town", widget.argumentUserData["town"]!),
                linePadding("Home Country","homeCountry", widget.argumentUserData["homeCountry"]!),
                linePadding("Home Town","homeTown", widget.argumentUserData["homeTown"]!),
                linePadding("gender","gender", widget.argumentUserData["gender"]!),
                linePadding("Place I wanna go","placeWannaGo", widget.argumentUserData["placeWannaGo"]!),
                linePadding("Greeting","greeting", widget.argumentUserData["greeting"]!),
                linePadding("Description","description", widget.argumentUserData["description"]!),


          ])),
        ));
  }

  Padding linePadding (String displayedItem,String databaseItem, String value) {
    //valueType:String or int or selectString(セグメント)
    String displayedValue;
    if(databaseItem=="gender"
    ||databaseItem=="level"){
      displayedValue=widget.argumentMasterData[databaseItem+"_"+value]!;
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
                                return SettingEditPage(
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
