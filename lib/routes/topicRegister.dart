import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
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
  File? topicImagePhotoFile;
  TextEditingController? topicEditingController;
  TextEditingController? categoryEditingController;
  List<DropdownMenuItem<String>> _categoryItems=[];
  String _selectCategoryItem = "";
  var firebaseUserData;

  @override
  void initState() {
    super.initState();
    topicEditingController = new TextEditingController(text: '');
    categoryEditingController = new TextEditingController(text: '');
    setCategoryItems();
  }

  void setCategoryItems() async{

    //マスタデータをFirebaseからHiveへ

    await FirebaseFirestore.instance.collection('categories').get().then((QuerySnapshot snapshot)async {

      // var boxMaster = await Hive.openBox('master');
      // await boxMaster.clear();
      // masterData.clear();

      snapshot.docs.forEach((doc) async{

        // //TODO Hiveとメモリにデータをセットする処理を追加
        // await boxMaster.put(doc.get('item')+"_"+doc.get('selectedValue'),doc.get('displayedValue'));
        // masterData[doc.get('item')+"_"+doc.get('selectedValue')]=doc.get('displayedValue');

        _categoryItems
          ..add(DropdownMenuItem(
            child: Text(doc.get('categoryName'), style: TextStyle(fontSize: 40.0),),
            value: doc.id,
          ));


      });

      // await boxMaster.close();
    });



    _selectCategoryItem = _categoryItems[0].value!;

    setState(() {

    });
  }

  @override
  void dispose() {
    topicEditingController!.dispose();
    categoryEditingController!.dispose();
    super.dispose();
  }

  // Future<void> _download(String userDocId) async {
  //   // ファイルのダウンロード
  //   // テキスト
  //   FirebaseStorage storage = await FirebaseStorage.instance;
  //
  //   // 画像
  //   Reference imageRef = await storage
  //       .ref()
  //       .child("profile")
  //       .child(userDocId)
  //       .child("mainPhoto.png");
  //   String imageUrl = await imageRef.getDownloadURL();
  //
  //   widget.argumentMainPhotoData = Image.network(imageUrl, width: 90);
  //
  //   Directory appDocDir = await getApplicationDocumentsDirectory();
  //   File downloadToFile = File("${appDocDir.path}/mainPhoto.png");
  //   try {
  //     await imageRef.writeToFile(downloadToFile);
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  Future<void> setImage() async {
    // imagePickerで画像を選択する
    // upload
    PickedFile? pickerFile = await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 20);
    if(pickerFile!=null){
      topicImagePhotoFile=File(pickerFile.path);
      //TODO 圧縮率などは調整

    }
  }

  Future<void> insertTopic() async {

    String insertedDocId="";

    try {
      firebaseUserData = await FirebaseFirestore.instance
          .collection('categories')
          .doc(_selectCategoryItem)
          .get();

    await FirebaseFirestore.instance.collection('topics').add(
      {'categoryDocId':_selectCategoryItem ,
        'categoryName':firebaseUserData.get("categoryName"),
        'photoPath':'',
        'photoUpdateCnt':'0',
        'topicName':topicName,
        'insertUserDocId':widget.argumentUserData["userDocId"],
        'insertProgramId': "topicRegister",
        'insertTime': DateTime.now().toString(),

      },
    ).then((value){
      insertedDocId=value.id;
    });

    FirebaseStorage storage = FirebaseStorage.instance;
      await storage.ref("topics/" + insertedDocId + ".png").putFile(topicImagePhotoFile!);
      //TODO 拡張子はPNGとは限らない。

      await FirebaseFirestore.instance.collection('topics').doc(insertedDocId)
          .update({"photoUpdateCnt":"1",
        "photoPath": "topics/" + insertedDocId + ".png",
      'updateUserDocId':widget.argumentUserData["userDocId"],
      'updateProgramId': "topicRegister",
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
      topicImagePhotoFile=null;
      topicEditingController = new TextEditingController(text: '');
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
          backgroundImage: topicImagePhotoFile == null ? null : Image.file(topicImagePhotoFile!).image,
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
        controller: topicEditingController,
        //initialValue: "",
        onChanged: (String value) {
          setState(() {
            topicName = value;
          });
        },
      ),
      const SizedBox(height: 8),
                  DropdownButton(
                  style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 6,
                  color: Colors.black45,
                  ),
                    items: _categoryItems,
                    value: _selectCategoryItem,
                    onChanged: (value) => {
                      setState(() {
                        _selectCategoryItem = value.toString();
                      }),
                    },
                  ),
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
