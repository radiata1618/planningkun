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

import '../firebase_config.dart';
import '../tabs_page.dart';
import '../common.dart';

class Setting extends StatefulWidget {
  final argumentEmail;
  final argumentUserDocId;

  Setting({this.argumentEmail, this.argumentUserDocId});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Setting"), // <- (※2)
        ),
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
                        _upload(widget.argumentUserDocId);
                      },
                      child: const Text('写真アップロード') //,
                      ),
                  MaterialButton(
                      onPressed: () {
                        _download(widget.argumentUserDocId);
                      },
                      child: const Text('写真ダウンロード') //,
                      //TODO ダウンロード機能が不完全
                      //TODO 画像はローカルのアプリ固有フォルダにも保存して、ローカルにあるならローカルのものを使う⇨DB上のデータなども全般的な話
                      ),
                ])),
            linePadding("name", "haruki"),
            linePadding("age", "21"),
            linePadding("level", "beginner"),
            linePadding("occupation", "consultant"),
            linePadding("mother tongue", "Japanese"),
            linePadding("country", "Japan"),
            linePadding("town", "Tokyo"),
            linePadding("home country", "Japan"),
            linePadding("home town", "Nagano"),
            linePadding("gender", "male"),
            linePadding("place I wanna go", "antarctic"),
            //TODO 挨拶と自己紹介を追加
            //実際のDBの値を取得するように変更
            //'greeting':'おはようございます！',
            //'description':'わたしは～～～'
          ])),
        ));
  }

  Padding linePadding(String item, String value) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Container(
          height: 52,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            GrayText(item),
            Container(
              width: 200,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [BlackText(value),

                    IconButton(
                      icon: Icon(Icons.edit),
                      iconSize: 18,
                      color: Colors.black54,
                      onPressed: () {},
                    ),]),
            )
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
