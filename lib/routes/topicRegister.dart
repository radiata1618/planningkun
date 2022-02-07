import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class TopicRegister extends StatefulWidget {
  Map<String, String> argumentUserData;
  Map<String, String> argumentMasterData;
  Map<String, Map<String, String>> argumentFriendData;
  Image argumentMainPhotoData;

  TopicRegister(
      {required this.argumentUserData,
      required this.argumentMasterData,
      required this.argumentFriendData,
      required this.argumentMainPhotoData});

  @override
  _TopicRegister createState() => _TopicRegister();
}

class _TopicRegister extends State<TopicRegister> {
  var box;
  String topicName = "";
  String categoryName = "";
  Image? topicImage;
  File? topicImagePhotoFile;

  Future<void> _download(String userDocId) async {
    // ファイルのダウンロード
    // テキスト
    FirebaseStorage storage = await FirebaseStorage.instance;

    // 画像
    Reference imageRef = await storage
        .ref()
        .child("profile")
        .child(userDocId)
        .child("mainPhoto.png");
    String imageUrl = await imageRef.getDownloadURL();

    widget.argumentMainPhotoData = Image.network(imageUrl, width: 90);

    Directory appDocDir = await getApplicationDocumentsDirectory();
    File downloadToFile = File("${appDocDir.path}/mainPhoto.png");
    try {
      await imageRef.writeToFile(downloadToFile);
    } catch (e) {
      print(e);
    }
  }

  Future<void> setImage() async {
    // imagePickerで画像を選択する
    // upload
    PickedFile? pickerFile = await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 20);
    topicImagePhotoFile=File(pickerFile!.path);
    topicImage = Image.file(File(pickerFile!.path));
    //TODO 圧縮率などは調整
  }

  Future<void> insertTopic() async {

    String insertedDocId="";

    FirebaseFirestore.instance.collection('topics').add(
      {'categoryDocId':"XXXX" ,
        'categoryName':'categoryName',
        'photoPath':'',
        'photoUpdateCnt':'0',
        'topicName':'topicName',
        'insertUserDocId':widget.argumentUserData["userDocId"],
        'insertProgramId': "topicRegister",
        'insertTime': DateTime.now().toString(),

      },
    ).then((value){
      insertedDocId=value.id;
    });

    FirebaseStorage storage = FirebaseStorage.instance;
    try {
      await storage.ref("topics/" + insertedDocId + "/photo.png").putFile(topicImagePhotoFile!);
      //TODO 拡張子はPNGとは限らない。

      await FirebaseFirestore.instance.collection('topics').doc(insertedDocId)
          .update({"photoUpdateCnt":"1",
        "photoPath": "topics/" + insertedDocId + "/photo.png"
      });

      // widget.argumentUserData["profilePhotoUpdateCnt"]=(int.parse(widget.argumentUserData["profilePhotoUpdateCnt"]!)+1).toString();
      // widget.argumentUserData["profilePhotoPath"]="profile/" + userDocId + "/mainPhoto.png";
      // await box.put("profilePhotoUpdateCnt",(int.parse(widget.argumentUserData["profilePhotoUpdateCnt"]!)+1).toString());
      // await box.put("profilePhotoPath","profile/" + userDocId + "/mainPhoto.png");

    } catch (e) {
      print(e);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
                child: Column(children: [
      Center(
        child: CircleAvatar(
          radius: 80,
          backgroundColor: Colors.white,
          backgroundImage: topicImage == null ? null : topicImage!.image,
        ),
      ),
      MaterialButton(
          onPressed: () async {
            await setImage();
            setState(() {});
          },
          child: const Text('写真アップロード') //,
          ),
      TextFormField(
        // テキスト入力のラベルを設定
        decoration: InputDecoration(labelText: "Topic Name"),
        onChanged: (String value) {
          setState(() {
            topicName = value;
          });
        },
      ),
      const SizedBox(height: 8),
      TextFormField(
        decoration: InputDecoration(labelText: "Category Name"),
        // パスワードが見えないようにする
        obscureText: true,
        onChanged: (String value) {
          setState(() {
            categoryName = value;
          });
        },
      ),
      const SizedBox(height: 8),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          color: Colors.orangeAccent,
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            style: ButtonStyle(),
            onPressed: ()async{
                  insertTopic();
            },
            child: Text(
              "Register",
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    ]))));
  }
}
