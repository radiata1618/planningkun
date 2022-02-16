import 'dart:async';
import 'dart:core';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';


class UserDataProvider extends ChangeNotifier {
  Map<String, String> _userData = {};
  Map<String, String> get userData => _userData;

  void setUnitItem(String itemName,String value){
    _userData[itemName] = value;
    notifyListeners();

  }

  Future<void> insertAndReadUserData(String email) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get();

    if (snapshot.size == 0) {
      await FirebaseFirestore.instance.collection('users').add(
        {
          'email': email,
          'name': "notifierTest",
          'age': "21",
          'ageNumber': 21,
          'level': "1",
          'occupation': 'consultant',
          'nativeLang': "JPN",
          'country': "JPN",
          'town': "Tokyo",
          'homeCountry': "JPN",
          'homeTown': "Nagano",
          'gender': "1",
          'placeWannaGo': 'antarctic',
          'greeting': 'おはようございます！',
          'description': 'わたしは～～～',
          'searchConditionAge': '18,30',
          'searchConditionLevel': '1,2,3,4',
          'searchConditionNativeLang': 'JPN',
          'searchConditionCountry': 'JPN,USA',
          'searchConditionGender': '1,2,3',
          'profilePhotoPath': '',
          'profilePhotoUpdateCnt': '0',
        },
      );

    }
  }

  Future<void> readUserDataFirebaseToHiveAndMemoryByEmail(String email) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get();

    String userDocId = snapshot.docs[0].id;
    //Hiveボックスをオープン
    var box = await Hive.openBox('record');

    //TODO　もともとのユーザとことなるユーザがログインされたら、警告を出して、リセット
    await box.put("userDocId", userDocId);
    _userData["userDocId"] = userDocId;
    await arrangeUserDataUnit("name", snapshot, box);
    await arrangeUserDataUnit("email", snapshot, box);
    await arrangeUserDataUnit("age", snapshot, box);
    await arrangeUserDataUnit("level", snapshot, box);
    await arrangeUserDataUnit("occupation", snapshot, box);
    await arrangeUserDataUnit("nativeLang", snapshot, box);
    await arrangeUserDataUnit("country", snapshot, box);
    await arrangeUserDataUnit("town", snapshot, box);
    await arrangeUserDataUnit("homeCountry", snapshot, box);
    await arrangeUserDataUnit("homeTown", snapshot, box);
    await arrangeUserDataUnit("gender", snapshot, box);
    await arrangeUserDataUnit("placeWannaGo", snapshot, box);
    await arrangeUserDataUnit("greeting", snapshot, box);
    await arrangeUserDataUnit("description", snapshot, box);
    await arrangeUserDataUnit("searchConditionAge", snapshot, box);
    await arrangeUserDataUnit("searchConditionLevel", snapshot, box);
    await arrangeUserDataUnit("searchConditionNativeLang", snapshot, box);
    await arrangeUserDataUnit("searchConditionCountry", snapshot, box);
    await arrangeUserDataUnit("searchConditionGender", snapshot, box);
    await arrangeUserDataUnit("profilePhotoPath", snapshot, box);
    await arrangeUserDataUnit("profilePhotoUpdateCnt", snapshot, box);

    await box.close();
    notifyListeners();
  }
  Future<void> arrangeUserDataUnit(
      String item, QuerySnapshot snapshot, var box) async {
    _userData[item] = snapshot.docs[0].get(item);
    await box.put(item, snapshot.docs[0].get(item));
  }

  Future<void> readUserDataFirebaseToHiveAndMemory(String userDocId) async {
    DocumentSnapshot docSnapShot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userDocId)
        .get();

    //Hiveボックスをオープン
    var box = await Hive.openBox('record');

    //TODO　もともとのユーザとことなるユーザがログインされたら、警告を出して、リセット
    await box.put("userDocId", userDocId);
    _userData["userDocId"] = userDocId;
    await arrangeUserDataUnitDoc("name", docSnapShot, box);
    await arrangeUserDataUnitDoc("email", docSnapShot, box);
    await arrangeUserDataUnitDoc("age", docSnapShot, box);
    await arrangeUserDataUnitDoc("level", docSnapShot, box);
    await arrangeUserDataUnitDoc("occupation", docSnapShot, box);
    await arrangeUserDataUnitDoc("nativeLang", docSnapShot, box);
    await arrangeUserDataUnitDoc("country", docSnapShot, box);
    await arrangeUserDataUnitDoc("town", docSnapShot, box);
    await arrangeUserDataUnitDoc("homeCountry", docSnapShot, box);
    await arrangeUserDataUnitDoc("homeTown", docSnapShot, box);
    await arrangeUserDataUnitDoc("gender", docSnapShot, box);
    await arrangeUserDataUnitDoc("placeWannaGo", docSnapShot, box);
    await arrangeUserDataUnitDoc("greeting", docSnapShot, box);
    await arrangeUserDataUnitDoc("description", docSnapShot, box);
    await arrangeUserDataUnitDoc("searchConditionAge", docSnapShot, box);
    await arrangeUserDataUnitDoc("searchConditionLevel", docSnapShot, box);
    await arrangeUserDataUnitDoc("searchConditionNativeLang", docSnapShot, box);
    await arrangeUserDataUnitDoc("searchConditionCountry", docSnapShot, box);
    await arrangeUserDataUnitDoc("searchConditionGender", docSnapShot, box);
    await arrangeUserDataUnitDoc("profilePhotoPath", docSnapShot, box);
    await arrangeUserDataUnitDoc("profilePhotoUpdateCnt", docSnapShot, box);

    await box.close();
    notifyListeners();
  }
  Future<void> arrangeUserDataUnitDoc(
      String item, DocumentSnapshot snapshot, var box) async {
    _userData[item] = snapshot.get(item);
    await box.put(item, snapshot.get(item));
  }

}
Future<void> getFirebaseUserData(WidgetRef ref) async {
  var box = await Hive.openBox('record');
  await ref.read(userDataProvider.notifier).readUserDataFirebaseToHiveAndMemory(await box.get("userDocId"));
  box.close();
}

Future<void> setImage(WidgetRef ref) async {
  XFile? pickerFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 800,
      maxHeight: 800,
      imageQuality: 40);
  if (pickerFile != null) {
    ref.watch(mainPhotoDataProvider.notifier)
        .uploadAndInsertPhoto(File(pickerFile.path),ref);
    //TODO 圧縮率などは調整
  }
}

final userDataProvider = ChangeNotifierProvider(
      (ref) => UserDataProvider(),
);




class MainPhotoDataNotifier extends ChangeNotifier {
  Image? _mainPhotoData;
  Image? get mainPhotoData => _mainPhotoData ;

  Future<void> readMainPhotoDataFromDirectoryToMemory(WidgetRef ref) async {

    String photoPath = ref.watch(userDataProvider.notifier).userData["profilePhotoPath"]!;
    String photoFileName=photoPath.substring(photoPath.lastIndexOf('/')+1,);

    Directory appDocDir = await getApplicationDocumentsDirectory();
    File localFile = File("${appDocDir.path}/"+photoFileName);

    _mainPhotoData = Image.file(localFile,width:90);
  }

  Future<void> readMainPhotoFromFirebaseToDirectoryAndMemory(WidgetRef ref) async {

    String photoPath = ref.watch(userDataProvider.notifier).userData["profilePhotoPath"]!;
    String photoFileName=photoPath.substring(photoPath.lastIndexOf('/')+1,);

    FirebaseStorage storage =  FirebaseStorage.instance;
    Reference imageRef =  storage.ref().child("profile").child(ref.watch(userDataProvider.notifier).userData["userDocId"]!).child(photoFileName);
    String imageUrl = await imageRef.getDownloadURL();

    _mainPhotoData = Image.network(imageUrl,width:90);

    Directory appDocDir = await getApplicationDocumentsDirectory();
    File downloadToFile = File("${appDocDir.path}/"+photoFileName);
    notifyListeners();
    try {
      await imageRef.writeToFile(downloadToFile);
    } catch (e) {
      print(e);
    }
  }

  Future<void> uploadAndInsertPhoto(File imageFile,WidgetRef ref) async{

    _mainPhotoData=Image.file(imageFile);

    //TODO  　圧縮版の画像を別で持つ
    String pathStr= imageFile.path;
    String pathStrEx=pathStr.substring(pathStr.lastIndexOf('.'),);
    FirebaseStorage storage = FirebaseStorage.instance;
    try {
      await storage.ref("profile/" + ref.watch(userDataProvider.notifier).userData["userDocId"]! + "/mainPhoto"+pathStrEx).putFile(imageFile);

      //ローカルに保存
      Directory appDocDir = await getApplicationDocumentsDirectory();
      File downloadToFile = File("${appDocDir.path}/"+"mainPhoto"+pathStrEx);
      await downloadToFile.writeAsBytes(await imageFile.readAsBytes());

      await FirebaseFirestore.instance.collection('users').doc(ref.watch(userDataProvider.notifier).userData["userDocId"]!)
          .update({"profilePhotoUpdateCnt": (int.parse(ref.watch(userDataProvider.notifier).userData["profilePhotoUpdateCnt"]!)+1).toString(),
        "profilePhotoPath": "profile/" + ref.watch(userDataProvider.notifier).userData["userDocId"]! + "/mainPhoto"+pathStrEx
      });


      var box = await Hive.openBox('record');
      ref.watch(userDataProvider.notifier).userData["profilePhotoUpdateCnt"]=(int.parse(ref.watch(userDataProvider.notifier).userData["profilePhotoUpdateCnt"]!)+1).toString();
      ref.watch(userDataProvider.notifier).userData["profilePhotoPath"]="profile/" + ref.watch(userDataProvider.notifier).userData["userDocId"]! + "/mainPhoto"+pathStrEx;
      await box.put("profilePhotoUpdateCnt",(int.parse(ref.watch(userDataProvider.notifier).userData["profilePhotoUpdateCnt"]!)+1).toString());
      await box.put("profilePhotoPath","profile/" + ref.watch(userDataProvider.notifier).userData["userDocId"]! + "/mainPhoto"+pathStrEx);

      box.close();

      var result = await FlutterImageCompress.compressAndGetFile(
        "${appDocDir.path}/"+"mainPhoto"+pathStrEx,
        "${appDocDir.path}/"+"mainPhoto_small"+pathStrEx,
        quality: 40,
      );

      File localSmallFile = File("${appDocDir.path}/"+"mainPhoto_small"+pathStrEx);
      await storage.ref("profile/" + ref.watch(userDataProvider.notifier).userData["userDocId"]! + "/mainPhoto_small"+pathStrEx).putFile(localSmallFile);

    } catch (e) {
      print(e);
    }


    notifyListeners();
  }

}

final mainPhotoDataProvider = ChangeNotifierProvider(
      (ref) => MainPhotoDataNotifier(),
);

