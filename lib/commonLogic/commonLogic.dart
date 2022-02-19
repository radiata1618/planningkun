

import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../commonEntity/friendEntity.dart';
import '../commonEntity/masterEntity.dart';
import '../commonEntity/topicEntity.dart';
import '../commonEntity/userData.dart';

Future<void> initialProcessLogic (WidgetRef ref, String email) async {

  await makeDir("friends");
  await makeDir("topics");
  await makeDir("categories");
  await makeDir("chats");

  var boxSetting = await Hive.openBox('setting');
  await updateTimeCheck("topics",boxSetting);

  boxSetting.close();

  //TODO　Hive→メモリは同期処理でやる。
  //TODO Firebase→メモリは非同期処理で良いと思う
  //TODO 本来はUserDocIdをキーにデータを持ってくる。
  await ref
      .read(userDataProvider.notifier)
      .readUserDataFirebaseToHiveAndMemoryByEmail(email);
  await ref
      .read(friendDataProvider.notifier)
      .readFriendDataFromFirebaseToHiveAndMemory(ref,
      ref.watch(userDataProvider).userData["userDocId"]!);
  await ref
      .read(masterDataProvider.notifier)
      .readMasterDataFromFirebaseToHiveAndMemory();
  await ref
      .read(mainPhotoDataProvider.notifier)
      .readMainPhotoDataFromDirectoryToMemory(ref);

  ref
      .read(topicDataProvider.notifier)
      .controlStreamOfReadTopicNewDataFromFirebaseToHiveAndMemory();

}

Future <void> updateTimeCheck(String itemName,var box)async {

  var updateTimeCheck= await box.get(itemName+"UpdateCheck");
  if(updateTimeCheck==null){
    await box.put(itemName+"UpdateCheck",DateTime(2022, 1, 1, 0, 0));
  }
  
}

Future <void> makeDir(String dirName) async {

  Directory appDocDir = await getApplicationDocumentsDirectory();
  final Directory appDocDirFolder = Directory("${appDocDir.path}/"+dirName);
  if(await appDocDirFolder.exists()){

  }else{
    new Directory(appDocDirFolder.path).createSync(recursive:true);

  }

}



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
