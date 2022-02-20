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
      Reference imageRef =
          storage.ref().child("topics").child(topicDocId + photoNameSuffix);
      //log("XXXXXX before getdownloadurl");
      String imageUrl = await imageRef.getDownloadURL();
      //log("XXXXXX before network");
      _topicPhotoData[topicDocId] = Image.network(imageUrl, width: 90);

      //log("XXXXXX before appdocdir");
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
    //log("XXXXXX before controllerClose");
    // controller.close();
  }

  Future<void> readTopicFromHiveToMemory() async {
    //データリセット
    _topicData ={};
    _topicPhotoData = {};

    var boxTopic = Hive.box('topics');
    Map <dynamic,dynamic> tmpBoxTopicData= boxTopic.toMap();
    for (var key in tmpBoxTopicData.keys) {
    _topicData[key]=new Map<String,dynamic>.from(tmpBoxTopicData[key]);
    Directory appDocDir = await getApplicationDocumentsDirectory();
      _topicPhotoData[key] = Image.file(File("${appDocDir.path}/topics/" + key + _topicData[key]!["photoNameSuffix"]));

    }
    //log("XXXXXX after cast Map data");

  }

  void clearHiveAndMemoryAndDirectory()async {

    _topicData = {};
    _topicPhotoData = {};

    var boxSetting = Hive.box('setting');
    await boxSetting.put("topicsUpdateCheck",DateTime(2022, 1, 1, 0, 0));
    var boxTopics = Hive.box('topics');
    await boxTopics.deleteFromDisk();
    await Hive.openBox('topics');
    final topicsDir = Directory((await getApplicationDocumentsDirectory()).path+"/topics");

    List<FileSystemEntity> files;
    files = topicsDir.listSync(recursive: true,followLinks: false);
    for (var file in files) {
      file.deleteSync(recursive: true);
    }

  }

  void controlStreamOfReadTopicNewDataFromFirebaseToHiveAndMemory()async {

    //最初は必ず呼び出し
    //log("XXXXXXXXXXXXX初回readTopicNewDataFromFirebaseToHiveAndMemorycallする");
    streamSub=await readTopicNewDataFromFirebaseToHiveAndMemory();
    //log("XXXXXXXXXXXXX初回readTopicNewDataFromFirebaseToHiveAndMemorycallした");

    if(controller.hasListener){

    }else{
      //log("XXXXXXXXXXXXXControlListener開始");
      //2回目以降は新しいデータを更新するたびに起動
      controller.stream.listen((value)  async{
        streamSub!.cancel();
        //log("XXXXXXXXXXXXXreadTopicNewDataFromFirebaseToHiveAndMemorycallする");
        streamSub=await readTopicNewDataFromFirebaseToHiveAndMemory();
        //log("XXXXXXXXXXXXXreadTopicNewDataFromFirebaseToHiveAndMemorycallした");
      });
    }

  }

  Future<StreamSubscription<QuerySnapshot>> readTopicNewDataFromFirebaseToHiveAndMemory() async {
    var boxSetting = Hive.box('setting');
    DateTime topicUpdatedTime = await boxSetting.get("topicsUpdateCheck");

    ////log("XXXXXXXXXXXXXQueryする"+topicUpdatedTime.toString());
    _callStream = FirebaseFirestore.instance
        .collection('topics')
        .where('updateTime',
            isGreaterThan: Timestamp.fromDate(topicUpdatedTime))
        .where('readableFlg', isEqualTo: true)
        .orderBy('updateTime', descending: false)
        .snapshots();


    StreamSubscription<QuerySnapshot> streamSub=_callStream!.listen((QuerySnapshot snapshot) async {
      if (snapshot.size != 0) {
        // //log("XXXXXXXXXXXXXXXXXXXXXXXXXXXSize" + snapshot.size.toString());

        Map<String, dynamic> tmpData={};
        var boxTopic = Hive.box('topics');
        for(int i=0;i<snapshot.size;i++){

          if(snapshot.docs[i].get("deleteFlg")){

            if(boxTopic.get(snapshot.docs[i].id)!=null){
              deleteTopicPhotoFroDirectoryAndMemory(snapshot.docs[i].id+snapshot.docs[i].get("photoNameSuffix"));
              await boxTopic.delete(snapshot.docs[i].id);
              // //log("XXXXXXXXXXXXXXXXXXXXXXXXXXXDelete完了" + snapshot.docs[i].id);

            }

          }else{

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


          }
          //log("XXXXXXXXXXXXXDateリセットする"+topicUpdatedTime.toString()+">>>>"+snapshot.docs[i].get("updateTime").toDate().toString());
          if (snapshot.docs[i].get("updateTime").toDate().isAfter(topicUpdatedTime)) {
            topicUpdatedTime = snapshot.docs[i].get("updateTime").toDate();
            await boxSetting.put("topicsUpdateCheck", topicUpdatedTime);
          }

        }
        notifyListeners();

        //log("XXXXXXXXXXXXXADDする");
        controller.sink.add(true);
        //log("XXXXXXXXXXXXXADDした");
      }

    });
    return streamSub;

  }

  void deleteTopicPhotoFroDirectoryAndMemory(String fileName)async{

    final topicsPhotoFile = File((await getApplicationDocumentsDirectory()).path+"/topics/"+fileName);
    topicsPhotoFile.deleteSync(recursive: true);
    //log("filedeletefinish"+fileName);

  }
}
