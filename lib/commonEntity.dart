import 'dart:async';
import 'dart:core';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

//TODO Main モジュールでFirebaseからデータが取得できないとき、Hiveのデータをメモリに読み出すように処理をCOMMONに追加する。


List<String> fromTextToList(String txt) {
  String workText = txt;
  List<String> outputList = [];

  for (; workText.contains(',');) {
    outputList.add(workText.substring(0, workText.indexOf(',')));
    workText = workText.substring(workText.indexOf(',') + 1);
  }
  outputList.add(workText);

  return outputList;
}


//Firebase ログ・イン情報を保持するためのProviderクラス
//https://www.flutter-study.dev/firebase-app/riverpod
// ユーザー情報の受け渡しを行うためのProvider
final userProvider = StateProvider((ref) {
  return FirebaseAuth.instance.currentUser;
});

// エラー情報の受け渡しを行うためのProvider
// ※ autoDisposeを付けることで自動的に値をリセットできます
final infoTextProvider = StateProvider.autoDispose((ref) {
  return '';
});

// メールアドレスの受け渡しを行うためのProvider
// ※ autoDisposeを付けることで自動的に値をリセットできます
final emailProvider = StateProvider.autoDispose((ref) {
  return '';
});

// パスワードの受け渡しを行うためのProvider
// ※ autoDisposeを付けることで自動的に値をリセットできます
final passwordProvider = StateProvider.autoDispose((ref) {
  return '';
});

// メッセージの受け渡しを行うためのProvider
// ※ autoDisposeを付けることで自動的に値をリセットできます
final messageTextProvider = StateProvider.autoDispose((ref) {
  return '';
});

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


final friendDataProvider = ChangeNotifierProvider(
      (ref) => FriendDataNotifier(),
);

class FriendDataNotifier extends ChangeNotifier {
  Map<String, Map<String, String>> _friendData = {};//キーはFriendのuserDocId
  Map<String, Map<String, String>> get friendData => _friendData;

  Map<String, Image?> _friendPhotoData = {};//キーはFriendのuserDocId
  get friendPhotoData => _friendPhotoData;

  Future<void> readFriendPhotoFromFirebaseToDirectoryAndMemory(WidgetRef ref,String friendUserDocId) async {

    String photoPath = _friendData[friendUserDocId]!["profilePhotoPath"]!;
    String photoFileName=photoPath.substring(photoPath.lastIndexOf('/')+1,);

    if(photoPath.contains("mainPhoto")){
      //写真が登録されている場合

      FirebaseStorage storage =  FirebaseStorage.instance;
      try {
        Reference imageRef =  storage.ref().child("profile").child(friendUserDocId).child(photoFileName);
        String imageUrl = await imageRef.getDownloadURL();
        _friendPhotoData[friendUserDocId] = Image.network(imageUrl,width:90);

        Directory appDocDir = await getApplicationDocumentsDirectory();
        File downloadToFile = File("${appDocDir.path}/friend/"+photoFileName);

        await imageRef.writeToFile(downloadToFile);

      }catch(e){
        //写真があるはずなのになぜかエラーだった
        _friendPhotoData[friendUserDocId] =null;
      }

    }else{
      //写真が登録されていない場合
      _friendPhotoData[friendUserDocId] =null;
    }
  }

  Future<void> readFriendPhotoDataFromDirectoryToMemory(WidgetRef ref,String friendUserDocId) async {

    String photoPath = _friendData[friendUserDocId]!["profilePhotoPath"]!;
    String photoFileName=photoPath.substring(photoPath.lastIndexOf('/')+1,);

    Directory appDocDir = await getApplicationDocumentsDirectory();
    File localFile = File("${appDocDir.path}/friend/"+photoFileName);

    _friendPhotoData[friendUserDocId] = Image.file(localFile,width:90);
  }


  Future<void> readFriendDataFromFirebaseToHiveAndMemory(WidgetRef ref,
      String userDocId) async {
    await FirebaseFirestore.instance
        .collection('friends')
        .where('userDocId', isEqualTo: userDocId)
        .get()
        .then((QuerySnapshot snapshot) async {
      var boxFriend = await Hive.openBox('friend');
      await boxFriend.clear();
      _friendData.clear();

      snapshot.docs.forEach((doc) async {
        //Hiveとメモリにデータをセットする処理を追加
        await boxFriend.put(doc.get('friendUserDocId'), {
          'friendDocId': doc.id,
          'friendUserName': doc.get('friendUserName'),
          'lastMessageContent': doc.get('lastMessageContent'),
          'lastMessageDocId': doc.get('lastMessageDocId'),
          'lastTime': doc.get('lastTime'),
          'profilePhotoUpdateCnt': doc.get('profilePhotoUpdateCnt'),
          'profilePhotoPath': doc.get('profilePhotoPath'),
        });

        _friendData[doc.get('friendUserDocId')] = {
          'friendDocId': doc.id,
          'friendUserName': doc.get('friendUserName'),
          'lastMessageContent': doc.get('lastMessageContent'),
          'lastMessageDocId': doc.get('lastMessageDocId'),
          'lastTime': doc.get('lastTime'),
          'profilePhotoUpdateCnt': doc.get('profilePhotoUpdateCnt'),
          'profilePhotoPath': doc.get('profilePhotoPath'),
        };

        readFriendPhotoFromFirebaseToDirectoryAndMemory(ref,doc.get('friendUserDocId'));
      });
      await boxFriend.close();
    });
    notifyListeners();
  }

  Future<void> insertFriend(WidgetRef ref,String friendUserDocId) async{

    String insertedDocId="";
      DocumentSnapshot<Map<String, dynamic>>firebaseUserData = await FirebaseFirestore.instance
          .collection('users')
          .doc(friendUserDocId)
          .get();

    //相手側のFriendデータもFirebaseのみに作成する
    FirebaseFirestore.instance.collection('friends').add(
      {'userDocId':friendUserDocId,
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
        'friendUserDocId': friendUserDocId,
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
    await friendBox.put(friendUserDocId,{
      'friendUserDocId': insertedDocId,
      'friendUserName': firebaseUserData["name"],
      'profilePhotoPath': firebaseUserData["profilePhotoPath"] ,
      'profilePhotoUpdateCnt': firebaseUserData["profilePhotoUpdateCnt"] ,
      'lastMessageContent': "",
      'lastMessageDocId': "",
      'lastTime': DateTime.now().toString(),
    });
    await friendBox.close();

    ref.watch(friendDataProvider).friendData[friendUserDocId]={
      'friendUserDocId': insertedDocId,
      'friendUserName': firebaseUserData["name"],
      'profilePhotoPath': firebaseUserData["profilePhotoPath"] ,
      'profilePhotoUpdateCnt': firebaseUserData["profilePhotoUpdateCnt"],
      'lastMessageContent': "",
      'lastMessageDocId': "",
      'lastTime': DateTime.now().toString(),
    };


    await readFriendPhotoFromFirebaseToDirectoryAndMemory(ref,friendUserDocId);

  }

}

final masterDataProvider = ChangeNotifierProvider(
      (ref) => MasterDataProvider(),
);


class MasterDataProvider extends ChangeNotifier {
  Map<String,String> _masterData={};
  Map<String,String> get masterData => _masterData ;

  Future<void> readMasterDataFromFirebaseToHiveAndMemory() async {

    var boxMaster = await Hive.openBox('master');
    await FirebaseFirestore.instance.collection('masters').get().then((QuerySnapshot snapshot)async {

      await boxMaster.clear();
      masterData.clear();

      snapshot.docs.forEach((doc) async{

        //Hiveとメモリにデータをセットする処理を追加
        await boxMaster.put(doc.get('item')+"_"+doc.get('selectedValue'),doc.get('displayedValue'));
        masterData[doc.get('item')+"_"+doc.get('selectedValue')]=doc.get('displayedValue');
      });

    });
    await boxMaster.close();
    notifyListeners();
  }
}


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

