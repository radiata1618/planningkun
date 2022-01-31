import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:planningkun/routes/settingTextEdit.dart';
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
  UserInfoData argumentUserData;
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


  var box;
  var masterBox;


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

  void moveToEdit(String item,value) async {

    switch(item){
      case "name":
        Navigator.push(
          context,MaterialPageRoute(
          builder: (context) => SettingTextEdit(
              argumentItem: item,
              argumentValue: value
          ),
        ),
        );
         break;
      case "occupation":
        Navigator.push(
          context,MaterialPageRoute(
          builder: (context) => SettingTextEdit(
              argumentItem: item,
              argumentValue: value
          ),
        ),
        );
        break;
      case "nativeLang":
        Navigator.push(
          context,MaterialPageRoute(
          builder: (context) => SettingTextEdit(
              argumentItem: item,
              argumentValue: value
          ),
        ),
        );
        break;
      case "town":
        Navigator.push(
          context,MaterialPageRoute(
          builder: (context) => SettingTextEdit(
              argumentItem: item,
              argumentValue: value
          ),
        ),
        );
        break;
      case "homeTown":
        Navigator.push(
          context,MaterialPageRoute(
          builder: (context) => SettingTextEdit(
              argumentItem: item,
              argumentValue: value
          ),
        ),
        );
        break;
      case "placeWannaGo":
        Navigator.push(
          context,MaterialPageRoute(
          builder: (context) => SettingTextEdit(
              argumentItem: item,
              argumentValue: value
          ),
        ),
        );
        break;
    }

  }

  Future<void> getFirebaseData() async {

    var firebaseUserData =await FirebaseFirestore.instance.collection('users').doc(widget.argumentUserData.getUserDocId()).get();
    var box = await Hive.openBox('record');

    //FirebaseのデータをHiveに取得
    box.put("email",firebaseUserData.get('email'));
    box.put("age",firebaseUserData.get('age'));
    box.put("level",firebaseUserData.get('level'));
    box.put("occupation",firebaseUserData.get('occupation'));
    box.put("nativeLang",firebaseUserData.get('nativeLang'));
    box.put("country",firebaseUserData.get('country'));
    box.put("town",firebaseUserData.get('town'));
    box.put("homeCountry",firebaseUserData.get('homeCountry'));
    box.put("homeTown",firebaseUserData.get('homeTown'));
    box.put("gender",firebaseUserData.get('gender'));
    box.put("placeWannaGo",firebaseUserData.get('placeWannaGo'));
    box.put("greeting",firebaseUserData.get('greeting'));
    box.put("description",firebaseUserData.get('description'));


    String nameTmp=await box.get("name");
    int ageTmp=await box.get("age");
    String levelTmp=await box.get("level");
    String levelDisplayedTmp=await masterBox.get("level_"+levelTmp);
    String placeWannaGoTmp=await box.get("placeWannaGo");

    setState(() {
      widget.argumentUserData.setName(nameTmp);
      widget.argumentUserData.setAge(ageTmp);
      widget.argumentUserData.setLevel(levelTmp);
      widget.argumentUserData.setPlaceWannaGo(placeWannaGoTmp);

    });
  }

  @override
  Widget build(BuildContext context) {

    var getData = getFirebaseData();


    return Scaffold(
        appBar: AppBar(
          title: Text("Setting",
        style: TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 18,
        color: Colors.white,
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
                        _upload(widget.argumentUserData.getUserDocId()!);
                      },
                      child: const Text('写真アップロード') //,
                      ),
                  MaterialButton(
                      onPressed: () {
                        _download(widget.argumentUserData.getUserDocId()!);
                      },
                      child: const Text('写真ダウンロード') //,
                      //TODO ダウンロード機能が不完全
                      //TODO 画像はローカルのアプリ固有フォルダにも保存して、ローカルにあるならローカルのものを使う⇨DB上のデータなども全般的な話
                      ),
                ])),
                linePadding("name","name", widget.argumentUserData.getName(),null,"String"),
                linePadding("age","age", null,widget.argumentUserData.getAge(),"int"),
                linePadding("level","level", widget.argumentUserData.getLevel(), null,"selectString"),
                linePadding("place I wanna go","placeWannaGo",  widget.argumentUserData.getPlaceWannaGo(),null,"String"),


          ])),
        ));
  }

  Padding linePadding (String displayedItem,String databaseItem, String? stringValue, int? intValue,String valueType) {
    //valueType:String or int or selectString(セグメント)
    String displeyedValue;
    if(valueType=="String"){
      displeyedValue=stringValue!;
    }else if(valueType=="int"){
      displeyedValue=intValue.toString();
    }else{
      displeyedValue=widget.argumentMasterData[databaseItem+"_"+stringValue!]!;
    }
    return Padding(
        padding: const EdgeInsets.only(left:10,right:10,bottom:4),
        child: Container(
          height: 40,
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
                      Text(displeyedValue,
                style: TextStyle(
                fontWeight: FontWeight.normal,
                  fontSize: 16,
                  color: Colors.black54,
                ),),

            Padding(padding:const EdgeInsets.only(left:4),
              child:GestureDetector(
                          onTap: () {},
                          child: Icon(
                            Icons.edit,
                            color: Colors.black54,
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
