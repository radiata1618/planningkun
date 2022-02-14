import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../chat.dart';
import '../commonEntity.dart';

class FriendProfile extends ConsumerWidget {
  FriendProfile({
    required this.argumentFriendUserDocId,
    Key? key,
  }) : super(key: key);
  String argumentFriendUserDocId;

  //TODO 前画面からFriendのアイコンデータ（写真データを受け渡すようにする。）
  //TODO 引数は一つの構造体にまとめよう→GetterとSetterはどうするか（必須にするか）検討が必要

  bool initialProcessFlg = true;

  var box;
  var firebaseUserData;
  Image? friendImage;


  Future<void> InsertFriend(WidgetRef ref) async{
    String insertedDocId="";

    //相手側のFriendデータもFirebaseのみに作成する
    FirebaseFirestore.instance.collection('friends').add(
      {'userDocId':argumentFriendUserDocId,
        'friendUserDocId': ref.watch(userDataProvider).userData["userDocId"],
        'friendUserName': ref.watch(userDataProvider).userData["name"],
        'profilePhotoPath':ref.watch(userDataProvider).userData["profilePhotoPath"] ,
        'profilePhotoUpdateCnt': ref.watch(userDataProvider).userData["profilePhotoUpdateCnt"] ,
        'lastMessageContent': "",
        'lastMessageDocId': "",
        'lastTime': DateTime.now().toString(),
        'insertUserDocId':ref.watch(userDataProvider).userData["userDocId"],
        'insertProgramId': "friendProfile",
        'insertTime': DateTime.now().toString(),
      },
    );

    FirebaseFirestore.instance.collection('friends').add(
      {'userDocId':ref.watch(userDataProvider).userData["userDocId"] ,
        'friendUserDocId': argumentFriendUserDocId,
        'friendUserName': firebaseUserData["name"] ,
        'profilePhotoPath': firebaseUserData["profilePhotoPath"] ,
        'profilePhotoUpdateCnt': firebaseUserData["profilePhotoUpdateCnt"] ,
        'lastMessageContent': "",
        'lastMessageDocId': "",
        'lastTime': DateTime.now().toString(),
        'insertUserDocId':ref.watch(userDataProvider).userData["userDocId"],
        'insertProgramId': "friendProfile",
        'insertTime': DateTime.now().toString(),
      },
    ).then((value){
      insertedDocId=value.id;
    });

    var friendBox = await Hive.openBox('friend');
    await friendBox.put(argumentFriendUserDocId,{
      'friendUserDocId': insertedDocId,
      'friendUserName': firebaseUserData["name"],
      'profilePhotoPath': firebaseUserData["profilePhotoPath"] ,
      'profilePhotoUpdateCnt': firebaseUserData["profilePhotoUpdateCnt"] ,
      'lastMessageContent': "",
      'lastMessageDocId': "",
      'lastTime': DateTime.now().toString(),
    });
    await friendBox.close();

    ref.watch(friendDataProvider).friendData[argumentFriendUserDocId]={
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
  //         .doc(ref.watch(userDataProvider).userData["userDocId"])
  //         .update({
  //       "profilePhotoUpdateCnt":
  //           (int.parse(ref.watch(userDataProvider).userData["profilePhotoUpdateCnt"]!) + 1)
  //               .toString(),
  //       "profilePhotoPath": "profile/" + userDocId + "/mainPhoto.png"
  //     });
  //
  //     ref.watch(userDataProvider).userData["profilePhotoUpdateCnt"] =
  //         (int.parse(ref.watch(userDataProvider).userData["profilePhotoUpdateCnt"]!) + 1)
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
        .doc(argumentFriendUserDocId)
        .get();

    await _download(argumentFriendUserDocId);
    //box = await Hive.openBox('record');

    //if(firebaseUserData.get("profilePhotoUpdateCnt")!=ref.watch(userDataProvider).userData["profilePhotoUpdateCnt"]){
    //  await _download(ref.watch(userDataProvider).userData["userDocId"]!);

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

  }

  // Future<void> arrangeUserDataUnit(String item) async {
  //   await box.put(item,firebaseUserData.get(item));
  //   ref.watch(userDataProvider).userData[item]=await firebaseUserData.get(item);
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              linePadding(ref,
                  "Name",
                  "name",
                  firebaseUserData == null
                      ? ""
                      : firebaseUserData["name"]),
              linePadding(ref,
                  "E-mail",
                  "email",
                  firebaseUserData== null
                      ? ""
                      : firebaseUserData["email"]),
              linePadding(ref,"Age", "age",
                  firebaseUserData == null ? "" : firebaseUserData["age"]),
              linePadding(ref,
                  "English Level",
                  "level",
                  firebaseUserData== null
                      ? ""
                      : firebaseUserData["level"]),
              linePadding(ref,
                  "Occupation",
                  "occupation",
                  firebaseUserData == null
                      ? ""
                      : firebaseUserData["occupation"]),
              linePadding(ref,
                  "mother Tongue",
                  "nativeLang",
                  firebaseUserData == null
                      ? ""
                      : firebaseUserData["nativeLang"]),
              linePadding(ref,
                  "Country",
                  "country",
                  firebaseUserData == null
                      ? ""
                      : firebaseUserData["country"]),
              linePadding(ref,
                  "Town",
                  "town",
                  firebaseUserData == null
                      ? ""
                      : firebaseUserData["town"]),
              linePadding(ref,
                  "Home Country",
                  "homeCountry",
                  firebaseUserData == null
                      ? ""
                      : firebaseUserData["homeCountry"]),
              linePadding(ref,
                  "Home Town",
                  "homeTown",
                  firebaseUserData == null
                      ? ""
                      : firebaseUserData["homeTown"]),
              linePadding(ref,
                  "gender",
                  "gender",
                  firebaseUserData == null
                      ? ""
                      : firebaseUserData["gender"]),
              linePadding(ref,
                  "Place I wanna go",
                  "placeWannaGo",
                  firebaseUserData == null
                      ? ""
                      : firebaseUserData["placeWannaGo"]),
              linePadding(ref,
                  "Greeting",
                  "greeting",
                  firebaseUserData == null
                      ? ""
                      : firebaseUserData["greeting"]),
              linePadding(ref,
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
                  await InsertFriend(ref);

                  //TODO　すでにFriendの場合は押下できないように修正する
                  await Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) {
                      return Chat(
                          argumentFriendUserDocId:argumentFriendUserDocId
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

  Padding linePadding(WidgetRef ref,String displayedItem, String databaseItem, String value) {
    //valueType:String or int or selectString(セグメント)
    String displayedValue;
    if ((databaseItem == "gender" || databaseItem == "level")&&value!="" ){
      displayedValue = ref.watch(masterDataProvider).masterData[databaseItem + "_" + value]!;
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
