import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class CategoryRegister extends StatefulWidget {
  Map<String, String> argumentUserData;
  Map<String, String> argumentMasterData;
  Map<String, Map<String, String>> argumentFriendData;
  Image argumentMainPhotoData;

  CategoryRegister(
      {required this.argumentUserData,
        required this.argumentMasterData,
        required this.argumentFriendData,
        required this.argumentMainPhotoData});

  @override
  _CategoryRegister createState() => _CategoryRegister();
}

class _CategoryRegister extends State<CategoryRegister> {
  var box;
  String topicName = "";
  String categoryName = "";
  File? categoryImagePhotoFile;
  TextEditingController? categoryEditingController;


  @override
  void initState() {
    super.initState();
    categoryEditingController = new TextEditingController(text: '');
  }

  @override
  void dispose() {
    categoryEditingController!.dispose();
    super.dispose();
  }

  Future<void> setImage() async {
    // imagePickerで画像を選択する
    // upload
    PickedFile? pickerFile = await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 20);
    if(pickerFile!=null){
      categoryImagePhotoFile=File(pickerFile.path);
      //TODO 圧縮率などは調整
    }
  }

  Future<void> insertTopic() async {

    String insertedDocId="";

    try {
      await FirebaseFirestore.instance.collection('categories').add(
        {'categoryName':categoryName,
          'photoPath':'',
          'photoUpdateCnt':'0',
          'insertUserDocId':widget.argumentUserData["userDocId"],
          'insertProgramId': "CategoryRegister",
          'insertTime': DateTime.now().toString(),

        },
      ).then((value){
        insertedDocId=value.id;
      });
      //TODO 各トピックデータのカテゴリ名も更新しにいく？（冗長データを持つ）非正規化を健闘

      FirebaseStorage storage = FirebaseStorage.instance;
      await storage.ref("categories/" + insertedDocId + ".png").putFile(categoryImagePhotoFile!);
      //TODO 拡張子はPNGとは限らない。

      await FirebaseFirestore.instance.collection('categories').doc(insertedDocId)
          .update({"photoUpdateCnt":"1",
        "photoPath": "categories/" + insertedDocId + ".png",
        'updateUserDocId':widget.argumentUserData["userDocId"],
        'updateProgramId': "CategoryRegister",
        'updateTime': DateTime.now().toString(),
      });

      // widget.argumentUserData["profilePhotoUpdateCnt"]=(int.parse(widget.argumentUserData["profilePhotoUpdateCnt"]!)+1).toString();
      // widget.argumentUserData["profilePhotoPath"]="profile/" + userDocId + "/mainPhoto.png";
      // await box.put("profilePhotoUpdateCnt",(int.parse(widget.argumentUserData["profilePhotoUpdateCnt"]!)+1).toString());
      // await box.put("profilePhotoPath","profile/" + userDocId + "/mainPhoto.png");

      //TODO Hive,メモリへのデータ登録
      showDialog(
          context: context,
          builder: (_) => CupertinoAlertDialog(
            title: Text("Info"),
            content: Text("data has been inserted"),
            actions: [
              CupertinoDialogAction(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          ));



    } catch (e) {
      print(e);
    }
    setState(() {
      //データの初期化
      topicName = "";
      categoryName = "";
      categoryImagePhotoFile=null;
      categoryEditingController = new TextEditingController(text: '');
    });
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
                      backgroundImage: categoryImagePhotoFile == null ? null : Image.file(categoryImagePhotoFile!).image,
                    ),
                  ),
                  MaterialButton(
                      onPressed: () async {
                        await setImage();
                        setState(() {});
                      },
                      child: const Text('写真アップロード') //,
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    decoration: InputDecoration(labelText: "Category Name"),
                    controller: categoryEditingController,
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
