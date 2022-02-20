import 'dart:async';
import 'dart:core';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

final friendDataProvider = ChangeNotifierProvider(
  (ref) => FriendDataNotifier(),
);

class FriendDataNotifier extends ChangeNotifier {
  Map<String, Map<String, dynamic>> _friendData = {}; //キーはFriendのuserDocId
  get friendData => _friendData;

  Map<String, Image?> _friendPhotoData = {}; //キーはFriendのuserDocId
  get friendPhotoData => _friendPhotoData;

  Stream<QuerySnapshot>? _callStream;
  final controller = StreamController<bool>();
  StreamSubscription<QuerySnapshot>? streamSub;

  Future<void> readFriendPhotoFromFirebaseToDirectoryAndMemory(
      WidgetRef ref, String friendUserDocId) async {
    String profilePhotoNameSuffix = _friendData[friendUserDocId]!["profilePhotoNameSuffix"]!;

    if (profilePhotoNameSuffix != "" ) {
      //写真が登録されている場合

      FirebaseStorage storage = FirebaseStorage.instance;
      try {
        Reference imageRef = storage
            .ref()
            .child("profile")
            .child(friendUserDocId)
            .child("mainPhoto" + profilePhotoNameSuffix);
        String imageUrl = await imageRef.getDownloadURL();
        _friendPhotoData[friendUserDocId] = Image.network(imageUrl, width: 90);

        Directory appDocDir = await getApplicationDocumentsDirectory();
        File downloadToFile = File(
            "${appDocDir.path}/friends/" + friendUserDocId + profilePhotoNameSuffix);

        await imageRef.writeToFile(downloadToFile);
      } catch (e) {
        //写真があるはずなのになぜかエラーだった
        _friendPhotoData[friendUserDocId] = null;
      }
    } else {
      //写真が登録されていない場合
      _friendPhotoData[friendUserDocId] = null;
    }
  }

  void closeStream() async {
    streamSub!.cancel();
    log("XXXXXX before controllerClose");
    // controller.close();
  }

  Future<void> readFriendDataFromHiveToMemory() async {
    //データリセット
    _friendData ={};
    _friendPhotoData = {};

    var boxFriend = Hive.box('friends');
    Map <dynamic,dynamic> tmpBoxFriendData= boxFriend.toMap();
    for (var key in tmpBoxFriendData.keys) {
      _friendData[key]=new Map<String,dynamic>.from(tmpBoxFriendData[key]);
      Directory appDocDir = await getApplicationDocumentsDirectory();
      _friendPhotoData[key] = Image.file(File("${appDocDir.path}/friends/" + key + _friendData[key]!["profilePhotoNameSuffix"]));

    }
    log("XXXXXX after cast Map data");

  }
  Future<void> readFriendPhotoDataFromDirectoryToMemory(
      WidgetRef ref, String friendUserDocId) async {
    String profilePhotoNameSuffix = _friendData[friendUserDocId]!["profilePhotoNameSuffix"]!;

    Directory appDocDir = await getApplicationDocumentsDirectory();
    File localFile =
        File("${appDocDir.path}/friends/" + friendUserDocId + profilePhotoNameSuffix);

    _friendPhotoData[friendUserDocId] = Image.file(localFile, width: 90);
  }


  void clearHiveAndMemoryAndDirectory()async {

    _friendData = {};
    _friendPhotoData = {};

    var boxSetting = Hive.box('setting');
    await boxSetting.put("friendsUpdateCheck",DateTime(2022, 1, 1, 0, 0));
    var boxFriends = Hive.box('friends');
    await boxFriends.deleteFromDisk();
    await Hive.openBox('friends');
    final topicsDir = Directory((await getApplicationDocumentsDirectory()).path+"/friends");

    List<FileSystemEntity> files;
    files = topicsDir.listSync(recursive: true,followLinks: false);
    for (var file in files) {
      file.deleteSync(recursive: true);
    }

    log("XXXXXXXXfinishDelete");
  }

  void controlStreamOfReadFriendNewDataFromFirebaseToHiveAndMemory(
      WidgetRef ref,String userDocId) async {
    //最初は必ず呼び出し
    log("XXXXXXXXXXXXX初回readNewFriendFromFirebaseToHiveAndMemoryする");
    streamSub = await readNewFriendFromFirebaseToHiveAndMemory(ref,userDocId);
    log("XXXXXXXXXXXXX初回readNewFriendFromFirebaseToHiveAndMemoryした");

    if (controller.hasListener) {
    } else {
      log("XXXXXXXXXXXXXControlListener開始");
      //2回目以降は新しいデータを更新するたびに起動
      controller.stream.listen((value) async {
        streamSub!.cancel();
        log("XXXXXXXXXXXXXreadNewFriendFromFirebaseToHiveAndMemoryする");
        streamSub = await readNewFriendFromFirebaseToHiveAndMemory(ref,userDocId);
        log("XXXXXXXXXXXXXreadNewFriendFromFirebaseToHiveAndMemoryした");
      });
    }
  }

  Future<StreamSubscription<QuerySnapshot>>
      readNewFriendFromFirebaseToHiveAndMemory(WidgetRef ref,String userDocId) async {
    var boxSetting = Hive.box('setting');
    DateTime friendUpdatedTime = await boxSetting.get("friendsUpdateCheck");

    _callStream = FirebaseFirestore.instance
        .collection('friends')
        .where('updateTime',
            isGreaterThan: Timestamp.fromDate(friendUpdatedTime))
        .where('readableFlg', isEqualTo: true)
        .where('userDocId',
            isEqualTo: userDocId)
        .orderBy('updateTime', descending: false)
        .snapshots();

    StreamSubscription<QuerySnapshot> streamSub =
        _callStream!.listen((QuerySnapshot snapshot) async {
      if (snapshot.size != 0) {
        log("XXXXXXXXXXXXXXXXXXXXXXXXXXXSize" + snapshot.size.toString());

        Map<String, dynamic> tmpData = {};
        var boxFriend = Hive.box('friends');
        for (int i = 0; i < snapshot.size; i++) {
          if (snapshot.docs[i].get("deleteFlg")) {
            if (_friendData[snapshot.docs[i].get('friendUserDocId')] != null) {
              deleteFriendPhotoFroDirectoryAndMemory(snapshot.docs[i].get('friendUserDocId') +
                  snapshot.docs[i].get("profilePhotoNameSuffix"));
              await boxFriend.delete(snapshot.docs[i].get('friendUserDocId'));
              log("XXXXXXXXXXXXXXXXXXXXXXXXXXXDelete完了" + snapshot.docs[i].get('friendUserDocId'));
            }
          } else {

            //写真のアップデートがあったときの処理
            if (_friendData[snapshot.docs[i].get('friendUserDocId')] != null){
              if(_friendData[snapshot.docs[i].get('friendUserDocId')]!['profilePhotoUpdateCnt']!<(snapshot.docs[i].get('profilePhotoUpdateCnt')!)){
              readFriendPhotoFromFirebaseToDirectoryAndMemory(ref,snapshot.docs[i].get('friendUserDocId'));
              }
            }
            tmpData = {
              'friendDocId': snapshot.docs[i].id,
              'friendUserName': snapshot.docs[i].get('friendUserName'),
              'lastMessageContent': snapshot.docs[i].get('lastMessageContent'),
              'lastMessageDocId': snapshot.docs[i].get('lastMessageDocId'),
              'lastMessageTime': snapshot.docs[i].get('lastMessageTime')==null?null:snapshot.docs[i].get('lastMessageTime').toDate(),
              'profilePhotoUpdateCnt':
                  snapshot.docs[i].get('profilePhotoUpdateCnt'),
              'profilePhotoNameSuffix': snapshot.docs[i].get('profilePhotoNameSuffix'),
              'userDocId': snapshot.docs[i].get('userDocId'),
              'insertUserDocId': snapshot.docs[i].get("insertUserDocId"),
              'insertProgramId': snapshot.docs[i].get("insertProgramId"),
              'insertTime': snapshot.docs[i].get("insertTime").toDate(),
              'updateUserDocId': snapshot.docs[i].get("updateUserDocId"),
              'updateProgramId': snapshot.docs[i].get("updateProgramId"),
              'updateTime': snapshot.docs[i].get("updateTime").toDate(),
              'readableFlg': snapshot.docs[i].get("readableFlg"),
              'deleteFlg': snapshot.docs[i].get("deleteFlg"),
            };

            await boxFriend.put(snapshot.docs[i].get('friendUserDocId'), tmpData);
            _friendData[snapshot.docs[i].get('friendUserDocId')] = tmpData;
            readFriendPhotoFromFirebaseToDirectoryAndMemory(
                ref, snapshot.docs[i].get('friendUserDocId'));

          }
          log("XXXXXXXXXXXXXDateリセットする" +
              friendUpdatedTime.toString() +
              ">>>>" +
              snapshot.docs[i].get("updateTime").toDate().toString());
          if (snapshot.docs[i]
              .get("updateTime")
              .toDate()
              .isAfter(friendUpdatedTime)) {
            friendUpdatedTime = snapshot.docs[i].get("updateTime").toDate();
            await boxSetting.put("friendsUpdateCheck", friendUpdatedTime);
          }
        }

        notifyListeners();

        log("XXXXXXXXXXXXXADDする");
        controller.sink.add(true);
        log("XXXXXXXXXXXXXADDした");
      }
    });
    return streamSub;
  }

  void deleteFriendPhotoFroDirectoryAndMemory(String fileName) async {
    final deleteFriendPhotoFile = File(
        (await getApplicationDocumentsDirectory()).path +
            "/friends/" +
            fileName);
    deleteFriendPhotoFile.deleteSync(recursive: true);
    log("filedeletefinish" + fileName);
  }
}
