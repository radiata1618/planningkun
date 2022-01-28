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

import '../firebase_config.dart';
import '../tabs_page.dart';

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
  Text ? _text;

  Future<void> _download() async {


    // ファイルのダウンロード
    // テキスト
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference textRef = storage.ref().child("DL").child("hello.txt");
    //Reference ref = storage.ref("DL/hello.txt"); // refで一度に書いてもOK


    var data = await textRef.getData();

    // 画像
    Reference imageRef = storage.ref().child("DL").child("icon.png");
    String imageUrl = await imageRef.getDownloadURL();

    // 画面に反映
    setState(() {
      _img = Image.network(imageUrl);
      _text = Text(ascii.decode(data!));
    });


    Directory appDocDir = await getApplicationDocumentsDirectory();
    File downloadToFile = File("${appDocDir.path}/download-logo.png");
    try {
      await imageRef.writeToFile(downloadToFile);
    } catch (e) {
      print(e);
    }
  }

  void _upload() async {
    // imagePickerで画像を選択する
    // upload
    PickedFile? pickerFile =    await ImagePicker().getImage(source: ImageSource.gallery);
    File file = File(pickerFile!.path);

    FirebaseStorage storage = FirebaseStorage.instance;
    try {
      await storage.ref("UL/upload-pic.png").putFile(file);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Setting"), // <- (※2)
      ),
      body: SafeArea(
          child:
              Column(children: <Widget>[
                Container(height: 120,
                    child: Row(
                      children:<Widget>[
                        // if (_text != null) _text,
                        // if (_img != null) _img,
                    //     Container(
                    //   width: 100,
                    //   height: 100,
                    //   decoration: BoxDecoration(
                    //     shape: BoxShape.circle,
                    //     image: DecorationImage(
                    //       fit: BoxFit.fill,
                    //       image: NetworkImage(doc.data.data()[Strings.PROFILE_IMAGE_PATH]),
                    //     ),
                    //   ),
                    // ),
                        MaterialButton(
                            onPressed: _upload,
                            child: const Text('写真アップロード')//,
                        ),
                      ]
                    ))])),
    );
  }
}
