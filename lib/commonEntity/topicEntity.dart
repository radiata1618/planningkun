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

final topicDataProvider = ChangeNotifierProvider(
  (ref) => TopicDataNotifier(),
);

class TopicDataNotifier extends ChangeNotifier {
  Map<String, Map<String, dynamic>> _topicData = {};
  get topicData => _topicData;
  Map<String, Image?> _topicPhotoData = {};
  get topicPhotoData => _topicPhotoData;

  Stream<QuerySnapshot>? _callStream;
  final controller = StreamController<bool>();
  StreamSubscription<QuerySnapshot>? streamSub;

  Future<void> readTopicPhotoFromFirebaseToDirectoryAndMemory(
      String topicDocId) async {
    String photoNameSuffix = _topicData[topicDocId]!["photoNameSuffix"]!;

    FirebaseStorage storage = FirebaseStorage.instance;
    try {
      log("XXXXXX before Reference");
      Reference imageRef =
          storage.ref().child("topics").child(topicDocId + photoNameSuffix);
      log("XXXXXX before getdownloadurl");
      String imageUrl = await imageRef.getDownloadURL();
      log("XXXXXX before network");
      _topicPhotoData[topicDocId] = Image.network(imageUrl, width: 90);

      log("XXXXXX before appdocdir");
      Directory appDocDir = await getApplicationDocumentsDirectory();
      File downloadToFile =
          File("${appDocDir.path}/topics/" + topicDocId + photoNameSuffix);
      log(imageUrl.toString());
      await imageRef.writeToFile(downloadToFile);
    } catch (e) {
      //写真があるはずなのになぜかエラーだった
      _topicPhotoData[topicDocId] = null;
    }
  }
  void closeStream() async {
    streamSub!.cancel();
    log("XXXXXX before controllerClose");
    controller.close();
  }

  Future<void> readTopicFromHiveToMemory() async {

    var boxTopic = await Hive.openBox('topics');
    List list = boxTopic.values.toList();
    log(list.toString());

  }

  void clearHiveAndMemoryAndDirectory()async {

    _topicData = {};
    _topicPhotoData = {};

    var boxSetting = await Hive.openBox('setting');
    await boxSetting.put("topicsUpdateCheck",DateTime(2022, 1, 1, 0, 0));
    boxSetting.close();

    var boxTopics = await Hive.openBox('topics');
    await boxTopics.deleteFromDisk();

    final topicsDir = Directory((await getApplicationDocumentsDirectory()).path+"/topics");

    List<FileSystemEntity> files;
    files = topicsDir.listSync(recursive: true,followLinks: false);
    for (var file in files) {
      file.deleteSync(recursive: true);
    }

    log("finish topics data clear");

  }

  void controlStreamOfReadTopicNewDataFromFirebaseToHiveAndMemory()async {

    //最初は必ず呼び出し
    log("XXXXXXXXXXXXX初回readTopicNewDataFromFirebaseToHiveAndMemorycallする");
    streamSub=await readTopicNewDataFromFirebaseToHiveAndMemory();
    log("XXXXXXXXXXXXX初回readTopicNewDataFromFirebaseToHiveAndMemorycallした");

    if(controller.isClosed){
      //2回目以降は新しいデータを更新するたびに起動
      controller.stream.listen((value)  async{
        streamSub!.cancel();
        log("XXXXXXXXXXXXXreadTopicNewDataFromFirebaseToHiveAndMemorycallする");
        streamSub=await readTopicNewDataFromFirebaseToHiveAndMemory();
        log("XXXXXXXXXXXXXreadTopicNewDataFromFirebaseToHiveAndMemorycallした");
      });

    }

  }

  Future<StreamSubscription<QuerySnapshot>> readTopicNewDataFromFirebaseToHiveAndMemory() async {
    var boxSetting = await Hive.openBox('setting');
    DateTime topicUpdatedTime = await boxSetting.get("topicsUpdateCheck");

    log("XXXXXXXXXXXXXQueryする"+topicUpdatedTime.toString());
    _callStream = FirebaseFirestore.instance
        .collection('topics')
        .where('updateTime',
            isGreaterThan: Timestamp.fromDate(topicUpdatedTime))
        .where('readableFlg', isEqualTo: true)
        .orderBy('updateTime', descending: false)
        .snapshots();

    //.asBroadcastStream()をなくした
    StreamSubscription<QuerySnapshot> streamSub=_callStream!.listen((QuerySnapshot snapshot) async {
      if (snapshot.size != 0) {
        log("XXXXXXXXXXXXXXXXXXXXXXXXXXXSize" + snapshot.size.toString());

        Map<String, dynamic> tmpData={};
        var boxTopic = await Hive.openBox('topics');
        for(int i=0;i<snapshot.size;i++){
          tmpData = {
            'categoryDocId': snapshot.docs[i].get("categoryDocId"),
            'categoryName': snapshot.docs[i].get("categoryName"),
            'photoNameSuffix': snapshot.docs[i].get("photoNameSuffix"),
            'photoUpdateCnt': snapshot.docs[i].get("photoUpdateCnt"),
            'topicName': snapshot.docs[i].get("topicName"),
            'insertUserDocId': snapshot.docs[i].get("insertUserDocId"),
            'insertProgramId': snapshot.docs[i].get("insertProgramId"),
            'insertTime': snapshot.docs[i].get("insertTime"),
            'updateUserDocId': snapshot.docs[i].get("updateUserDocId"),
            'updateProgramId': snapshot.docs[i].get("updateProgramId"),
            'updateTime': snapshot.docs[i].get("updateTime").toDate(),
            'readableFlg': snapshot.docs[i].get("readableFlg"),
            'deleteFlg': snapshot.docs[i].get("deleteFlg"),
          };

          await boxTopic.put(snapshot.docs[i].id, tmpData);
          _topicData[snapshot.docs[i].id] = tmpData;

          await readTopicPhotoFromFirebaseToDirectoryAndMemory(snapshot.docs[i].id);

          log("XXXXXXXXXXXXXDateリセットする"+topicUpdatedTime.toString()+">>>>"+snapshot.docs[i].get("updateTime").toDate().toString());
          if (snapshot.docs[i].get("updateTime").toDate().isAfter(topicUpdatedTime)) {
            topicUpdatedTime = snapshot.docs[i].get("updateTime").toDate();
            await boxSetting.put("topicsUpdateCheck", topicUpdatedTime);
          }

        }
        await boxTopic.close();
        notifyListeners();

        log("XXXXXXXXXXXXXADDする");
        controller.sink.add(true);
        log("XXXXXXXXXXXXXADDした");
      }

    });
    return streamSub;

  }
}
