import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
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

import '../chat.dart';
import '../firebase_config.dart';
import '../commonEntity.dart';

class FriendProfile extends StatefulWidget {
  Map<String, String> argumentUserData;
  Map<String, String> argumentMasterData;
  Map<String, Map<String, String>> argumentFriendData;
  Image argumentMainPhotoData;
  String argumentFriendUserDocId;

  //TODO 前画面からFriendのアイコンデータ（写真データを受け渡すようにする。）
  //TODO 引数は一つの構造体にまとめよう→GetterとSetterはどうするか（必須にするか）検討が必要

  FriendProfile(
      {required this.argumentUserData,
      required this.argumentMasterData,
      required this.argumentFriendData,
      required this.argumentFriendUserDocId,
      required this.argumentMainPhotoData});

  @override
  _FriendProfile createState() => _FriendProfile();
}

class _FriendProfile extends State<FriendProfile> {
  bool initialProcessFlg = true;

  var box;
  var firebaseUserData;
  Image? friendImage;


  Future<void> InsertFriend() async{
    String insertedDocId="";

    //相手側のFriendデータもFirebaseのみに作成する
    FirebaseFirestore.instance.collection('friends').add(
      {'userDocId':widget.argumentFriendUserDocId,
        'friendUserDocId': widget.argumentUserData["userDocId"],
        'friendUserName': widget.argumentUserData["name"],
        'profilePhotoPath':widget.argumentUserData["profilePhotoPath"] ,
        'profilePhotoUpdateCnt': widget.argumentUserData["profilePhotoUpdateCnt"] ,
        'lastMessageContent': "",
        'lastMessageDocId': "",
        'lastTime': DateTime.now().toString(),
        'insertUserDocId':widget.argumentUserData["userDocId"],
        'insertProgramId': "friendProfile",
        'insertTime': DateTime.now().toString(),
      },
    );

    FirebaseFirestore.instance.collection('friends').add(
      {'userDocId':widget.argumentUserData["userDocId"] ,
        'friendUserDocId': widget.argumentFriendUserDocId,
        'friendUserName': firebaseUserData["name"] ,
        'profilePhotoPath': firebaseUserData["profilePhotoPath"] ,
        'profilePhotoUpdateCnt': firebaseUserData["profilePhotoUpdateCnt"] ,
        'lastMessageContent': "",
        'lastMessageDocId': "",
        'lastTime': DateTime.now().toString(),
        'insertUserDocId':widget.argumentUserData["userDocId"],
        'insertProgramId': "friendProfile",
        'insertTime': DateTime.now().toString(),
      },
    ).then((value){
      insertedDocId=value.id;
    });

    var friendBox = await Hive.openBox('friend');
    await friendBox.put(widget.argumentFriendUserDocId,{
      'friendUserDocId': insertedDocId,
      'friendUserName': firebaseUserData["name"],
      'profilePhotoPath': firebaseUserData["profilePhotoPath"] ,
      'profilePhotoUpdateCnt': firebaseUserData["profilePhotoUpdateCnt"] ,
      'lastMessageContent': "",
      'lastMessageDocId': "",
      'lastTime': DateTime.now().toString(),
    });
    await friendBox.close();

    widget.argumentFriendData[widget.argumentFriendUserDocId]={
      'friendUserDocId': insertedDocId,
      'friendUserName': firebaseUserData["name"],
      'profilePhotoPath': firebaseUserData["profilePhotoPath"] ,
      'profilePhotoUpdateCnt': firebaseUserData["profilePhotoUpdateCnt"],
      'lastMessageContent': "",
      'lastMessageDocId': "",
      'lastTime': DateTime.now().toString(),
    };

  }

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
    try {
      String imageUrl = await imageRef.getDownloadURL();
      friendImage = Image.network(imageUrl, width: 90);
    } catch (e) {
      print(e);
    }
    //TODO Tryで分岐するのでなく、取得したFriendのUserデータの中身のPhotoUpdate回数が０だったら画像がないと判断する
    //TODO Tryで異常処理をするのは良いと思う。


    // Directory appDocDir = await getApplicationDocumentsDirectory();
    // File downloadToFile = File("${appDocDir.path}/mainPhoto.png");
    //TODO Friendのファイルだったら命名規則に従ってローカルに保存
    // try {
    //   await imageRef.writeToFile(downloadToFile);
    // } catch (e) {
    //   print(e);
    // }
  }
  //
  // Future<void> _upload(String userDocId) async {
  //   // imagePickerで画像を選択する
  //   // upload
  //   PickedFile? pickerFile = await ImagePicker()
  //       .getImage(source: ImageSource.gallery, imageQuality: 20);
  //   File file = File(pickerFile!.path);
  //   //TODO 圧縮率などは調整
  //
  //   FirebaseStorage storage = FirebaseStorage.instance;
  //   try {
  //     await storage
  //         .ref("profile/" + userDocId + "/mainPhoto.png")
  //         .putFile(file);
  //     //TODO 拡張子はPNGとは限らない。
  //
  //     await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(widget.argumentUserData["userDocId"])
  //         .update({
  //       "profilePhotoUpdateCnt":
  //           (int.parse(widget.argumentUserData["profilePhotoUpdateCnt"]!) + 1)
  //               .toString(),
  //       "profilePhotoPath": "profile/" + userDocId + "/mainPhoto.png"
  //     });
  //
  //     widget.argumentUserData["profilePhotoUpdateCnt"] =
  //         (int.parse(widget.argumentUserData["profilePhotoUpdateCnt"]!) + 1)
  //             .toString();
  //     await box.put(
  //         "profilePhotoPath", "profile/" + userDocId + "/mainPhoto.png");
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  //
  // Future<void> _showLocalPhoto()async{
  //
  //
  //   Directory appDocDir = await getApplicationDocumentsDirectory();
  //   File localFile = File("${appDocDir.path}/mainPhoto.png");
  //   widget.argumentMainPhotoData = Image.file(localFile,width:90);
  //   setState(()  {
  //   });
  // }
  //TODO いまは使用していないがFriendデータを表示するときはローカルからデータを読み出すように修正する（→Friendの画像ファイルのパス（ローカル）をHiveとメモリに持つようにする）

  Future<void> getFirebaseData() async {
    firebaseUserData = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.argumentFriendUserDocId)
        .get();

    await _download(widget.argumentFriendUserDocId);
    //box = await Hive.openBox('record');

    //if(firebaseUserData.get("profilePhotoUpdateCnt")!=widget.argumentUserData["profilePhotoUpdateCnt"]){
    //  await _download(widget.argumentUserData["userDocId"]!);

    //}
    //FirebaseのデータをHiveに取得

    // await arrangeUserDataUnit("name");
    // await arrangeUserDataUnit("email");
    // await arrangeUserDataUnit("age");
    // await arrangeUserDataUnit("level");
    // await arrangeUserDataUnit("occupation");
    // await arrangeUserDataUnit("nativeLang");
    // await arrangeUserDataUnit("country");
    // await arrangeUserDataUnit("town");
    // await arrangeUserDataUnit("homeCountry");
    // await arrangeUserDataUnit("homeTown");
    // await arrangeUserDataUnit("gender");
    // await arrangeUserDataUnit("placeWannaGo");
    // await arrangeUserDataUnit("greeting");
    // await arrangeUserDataUnit("description");
    // await arrangeUserDataUnit("profilePhotoPath");
    // await arrangeUserDataUnit("profilePhotoUpdateCnt");
    //
    // await box.close();

    setState(() {});
  }

  // Future<void> arrangeUserDataUnit(String item) async {
  //   await box.put(item,firebaseUserData.get(item));
  //   widget.argumentUserData[item]=await firebaseUserData.get(item);
  // }

  @override
  Widget build(BuildContext context) {
    if (initialProcessFlg) {
      initialProcessFlg = false;
      //_showLocalPhoto();
      //TODO フレンドの場合はローカルにもデータを持つようにしたい
      //TODO →Lineと仕様を揃える
      getFirebaseData();
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white10,
          elevation: 0.0,
          title: Text(
            "Friend Profile",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 21,
              color: Colors.black87,
            ), // <- (※2)
          ),
        ),
        body: Column(
            children:[Expanded(
              child: SingleChildScrollView(
          child: SafeArea(
                child: Column(children: <Widget>[
              Center(
                child: CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.white,
                  backgroundImage: friendImage==null?null:friendImage!.image
                ),
              ),
              //TODO Firebaseからデータがとってこれていない1回目の処理は、前の検索画面で取得していた情報を受け渡して、表示できる情報は初回から表示してやる
              linePadding(
                  "Name",
                  "name",
                  firebaseUserData == null
                      ? ""
                      : firebaseUserData["name"]),
              linePadding(
                  "E-mail",
                  "email",
                  firebaseUserData== null
                      ? ""
                      : firebaseUserData["email"]),
              linePadding("Age", "age",
                  firebaseUserData == null ? "" : firebaseUserData["age"]),
              linePadding(
                  "English Level",
                  "level",
                  firebaseUserData== null
                      ? ""
                      : firebaseUserData["level"]),
              linePadding(
                  "Occupation",
                  "occupation",
                  firebaseUserData == null
                      ? ""
                      : firebaseUserData["occupation"]),
              linePadding(
                  "mother Tongue",
                  "nativeLang",
                  firebaseUserData == null
                      ? ""
                      : firebaseUserData["nativeLang"]),
              linePadding(
                  "Country",
                  "country",
                  firebaseUserData == null
                      ? ""
                      : firebaseUserData["country"]),
              linePadding(
                  "Town",
                  "town",
                  firebaseUserData == null
                      ? ""
                      : firebaseUserData["town"]),
              linePadding(
                  "Home Country",
                  "homeCountry",
                  firebaseUserData == null
                      ? ""
                      : firebaseUserData["homeCountry"]),
              linePadding(
                  "Home Town",
                  "homeTown",
                  firebaseUserData == null
                      ? ""
                      : firebaseUserData["homeTown"]),
              linePadding(
                  "gender",
                  "gender",
                  firebaseUserData == null
                      ? ""
                      : firebaseUserData["gender"]),
              linePadding(
                  "Place I wanna go",
                  "placeWannaGo",
                  firebaseUserData == null
                      ? ""
                      : firebaseUserData["placeWannaGo"]),
              linePadding(
                  "Greeting",
                  "greeting",
                  firebaseUserData == null
                      ? ""
                      : firebaseUserData["greeting"]),
              linePadding(
                  "Description",
                  "description",
                  firebaseUserData == null
                      ? ""
                      : firebaseUserData["description"]),
          ])),
        ),
            ),
              Container(height:40,
              child:
              ElevatedButton(
                onPressed: () async{
                  await InsertFriend();

                  //TODO　すでにFriendの場合は押下できないように修正する
                  await Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) {
                      return Chat(
                          argumentUserData: widget.argumentUserData,
                          argumentMasterData:widget.argumentMasterData,
                          argumentFriendData:widget.argumentFriendData,
                          argumentFriendUserDocId:widget.argumentFriendUserDocId
                      );
                    }),
                  );
                },

                style:ButtonStyle(
                ),
                child: Text("add to Friends",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                    color: Colors.white,
                  ),),)
              )
            ]));
  }

  Padding linePadding(String displayedItem, String databaseItem, String value) {
    //valueType:String or int or selectString(セグメント)
    String displayedValue;
    if ((databaseItem == "gender" || databaseItem == "level")&&value!="" ){
      displayedValue = widget.argumentMasterData[databaseItem + "_" + value]!;
    } else {
      displayedValue = value;
    }
    return Padding(
        padding: const EdgeInsets.only(left: 14, right: 14, bottom: 10),
        child: Container(
          height: 52,
          child: Column(children: [
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
                      Text(
                        displayedValue,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 18,
                          color: Colors.black87,
                        ),
                      ),
                    ]),
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
