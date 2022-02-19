import 'dart:async';
import 'dart:core';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';


class UserDataProviderNotifier extends ChangeNotifier {
  Map<String, dynamic> _userData = {};
  get userData => _userData;

  Image? _mainPhotoData;
  get mainPhotoData => _mainPhotoData ;

  List<String> itemNameList=[
    "email",
    "age",
    "ageNumber",
    "level",
    "nativeLang",
    "country",
    "town",
    "homeCountry",
    "homeTown",
    "gender",
    "placeWannaGo",
    "greeting",
    "description",
    "searchConditionAge",
    "searchConditionLevel",
    "searchConditionNativeLang",
    "searchConditionCountry",
    "searchConditionGender",
    "profilePhotoNameSuffix",
    "profilePhotoUpdateCnt",
    "insertUserDocId",
    "insertProgramId",
    "insertTime",
    "updateUserDocId",
    "updateProgramId",
    "updateTime",
    "readableFlg",
    "deleteFlg"
    ];


  Stream<DocumentSnapshot>? _callStream;
  final controller = StreamController<bool>();
  StreamSubscription<DocumentSnapshot>? streamSub;

  Future<void> readMainPhotoDataFromDirectoryToMemory() async {

    String profilePhotoNameSuffix = _userData["profilePhotoNameSuffix"]!;

    Directory appDocDir = await getApplicationDocumentsDirectory();
    File localFile = File("${appDocDir.path}/mainPhoto"+profilePhotoNameSuffix);
    _mainPhotoData = Image.file(localFile,width:90);
  }

  Future<void> readMainPhotoFromFirebaseToDirectoryAndMemory() async {

    String profilePhotoNameSuffix = _userData["profilePhotoNameSuffix"]!;

    FirebaseStorage storage =  FirebaseStorage.instance;
    Reference imageRef =  storage.ref().child("profile").child(_userData["userDocId"]!).child("mainPhoto"+profilePhotoNameSuffix);
    String imageUrl = await imageRef.getDownloadURL();

    _mainPhotoData = Image.network(imageUrl,width:90);

    Directory appDocDir = await getApplicationDocumentsDirectory();
    File downloadToFile = File("${appDocDir.path}/mainPhoto"+profilePhotoNameSuffix);
    try {
      await imageRef.writeToFile(downloadToFile);
    } catch (e) {
      _mainPhotoData=null;
      log("写真データが取れなかった");
    }
  }
  void closeStream() async {
    streamSub!.cancel();
    log("XXXXXX before controllerClose");
    // controller.close();
  }

  void setUnitItem(String itemName,String value){
    _userData[itemName] = value;
    notifyListeners();
  }
  Future<void> readUserDataFromHiveToMemory() async {

    var boxUser = Hive.box('user');

    _userData["userDocId"]=boxUser.get("userDocId");

    for(int i=0;i<itemNameList.length;i++){
      _userData[itemNameList[i]]=boxUser.get(itemNameList[i]);
    }

    await readMainPhotoDataFromDirectoryToMemory();
    log("XXXXXX after read user");

  }

  void controlStreamOfReadUserDataFirebaseToHiveAndMemory(String userDocId)async {

    //最初は必ず呼び出し
    streamSub=await readUserDataFirebaseToHiveAndMemory(userDocId);

    if(controller.hasListener){

    }else{
      //2回目以降は新しいデータを更新するたびに起動
      controller.stream.listen((value)  async{
        streamSub!.cancel();
        streamSub=await readUserDataFirebaseToHiveAndMemory(userDocId);
      });
    }

  }

  Future<StreamSubscription<DocumentSnapshot>> readUserDataFirebaseToHiveAndMemory(String userDocId) async {
    _callStream =  (FirebaseFirestore.instance
        .collection('users')
        .doc(userDocId).snapshots());

    streamSub=_callStream!.listen((DocumentSnapshot documentSnapshot) async {
      var box = Hive.box('setting');
      DateTime userUpdatedTime = box.get("userUpdateCheck");

      if (documentSnapshot.get("updateTime").toDate().isAfter(userUpdatedTime)) {

        if(_userData["profilePhotoUpdateCnt"]<documentSnapshot.get("profilePhotoUpdateCnt")) { //自デバイス以外で写真が更新された場合は写真をDL
          await readMainPhotoFromFirebaseToDirectoryAndMemory();
        }
        await box.put("userDocId", userDocId);
        _userData["userDocId"] = userDocId;

        for(int i=0;i<itemNameList.length;i++){
          _userData[itemNameList[i]] = documentSnapshot.get(itemNameList[i]);
          await box.put(itemNameList[i], documentSnapshot.get(itemNameList[i]));
        }
        await box.put("topicsUpdateCheck", documentSnapshot.get("updateTime").toDate());
      }

      log("XXXXXXXXXXXXXADDするUSER用");
      controller.sink.add(true);
      log("XXXXXXXXXXXXXADDしたUSER用");
      notifyListeners();
    });

    return streamSub!;

  }


  Future<void> uploadAndInsertPhoto(File imageFile,WidgetRef ref) async{

    _mainPhotoData=Image.file(imageFile);

    String pathStr= imageFile.path;
    String pathStrEx=pathStr.substring(pathStr.lastIndexOf('.'),);
    FirebaseStorage storage = FirebaseStorage.instance;
    try {
      await storage.ref("profile/" + _userData["userDocId"]! + "/mainPhoto"+pathStrEx).putFile(imageFile);

      //ローカルに保存
      Directory appDocDir = await getApplicationDocumentsDirectory();
      File downloadToFile = File("${appDocDir.path}/"+"mainPhoto"+pathStrEx);
      await downloadToFile.writeAsBytes(await imageFile.readAsBytes());

      var box = Hive.box('user');
      _userData["profilePhotoUpdateCnt"]=_userData["profilePhotoUpdateCnt"]!+1;
      _userData["profilePhotoNameSuffix"]=pathStrEx;
      await box.put("profilePhotoUpdateCnt",_userData["profilePhotoUpdateCnt"]!+1);
      await box.put("profilePhotoNameSuffix",pathStrEx);

      await FirebaseFirestore.instance.collection('users').doc(_userData["userDocId"]!)
          .update({"profilePhotoUpdateCnt": _userData["profilePhotoUpdateCnt"]!+1,
        "profilePhotoNameSuffix":pathStrEx
      });

      var result = await FlutterImageCompress.compressAndGetFile(
        "${appDocDir.path}/"+"mainPhoto"+pathStrEx,
        "${appDocDir.path}/"+"mainPhoto_small"+pathStrEx,
        quality: 20,
      );

      File localSmallFile = File("${appDocDir.path}/"+"mainPhoto_small"+pathStrEx);
      await storage.ref("profile/" + _userData["userDocId"]! + "/mainPhoto_small"+pathStrEx).putFile(localSmallFile);

    } catch (e) {
      print(e);
    }

    notifyListeners();
  }
  Future<void> setImage(WidgetRef ref) async {
    XFile? pickerFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 40);
    if (pickerFile != null) {
      uploadAndInsertPhoto(File(pickerFile.path),ref);
      //TODO 圧縮率などは調整
    }
  }

}

final userDataProvider = ChangeNotifierProvider(
      (ref) => UserDataProviderNotifier(),
);