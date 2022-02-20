import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../commonEntity/friendEntity.dart';
import '../commonEntity/messageEntity.dart';
import '../commonEntity/topicEntity.dart';
import '../commonEntity/userEntity.dart';

Future<void> initialProcessLogic(WidgetRef ref, String email) async {


  await makeDir("friends");
  await makeDir("topics");
  await makeDir("categories");
  await makeDir("messages");
  await makeDir("media");

  await openHiveBoxes();

  var boxSetting = Hive.box('setting');
  await updateTimeCheck("topics", boxSetting);
  await updateTimeCheck("friends", boxSetting);
  await updateTimeCheck("user", boxSetting);
  await updateTimeCheck("messages", boxSetting);

  await ref.read(topicDataProvider.notifier).readTopicFromHiveToMemory();
  await ref.read(friendDataProvider.notifier).readFriendDataFromHiveToMemory();
  await ref.read(userDataProvider.notifier).readUserDataFromHiveToMemory();
  ref.read(userDataProvider.notifier)
      .controlStreamOfReadUserDataFirebaseToHiveAndMemory(boxSetting.get("email"));//
  ref
      .read(friendDataProvider.notifier)
      .controlStreamOfReadFriendNewDataFromFirebaseToHiveAndMemory(ref,boxSetting.get("userDocId"));
  ref
      .read(topicDataProvider.notifier)
      .controlStreamOfReadTopicNewDataFromFirebaseToHiveAndMemory();
  ref
      .read(messageDataProvider.notifier)
      .controlStreamOfReadMessageNewDataFromFirebaseToHive(ref,boxSetting.get("userDocId"));
}

Future<void> closeStreams(WidgetRef ref) async {
  ref.read(topicDataProvider.notifier).closeStream();
  ref.read(userDataProvider.notifier).closeStream();
  ref.read(friendDataProvider.notifier).closeStream();
  ref.read(messageDataProvider.notifier).closeStream();
}

Future<void> updateTimeCheck(String itemName, var box) async {
  var updateTimeCheck = await box.get(itemName + "UpdateCheck");
  if (updateTimeCheck == null) {
    await box.put(itemName + "UpdateCheck", DateTime(2022, 1, 1, 0, 0));
  }
}

Future<void> makeDir(String dirName) async {
  Directory appDocDir = await getApplicationDocumentsDirectory();
  final Directory appDocDirFolder = Directory("${appDocDir.path}/" + dirName);
  if (await appDocDirFolder.exists()) {
  } else {
    new Directory(appDocDirFolder.path).createSync(recursive: true);
  }
}

Future<void> openHiveBoxes() async {
  try {
    Hive.box("setting");
  } catch (e) {
    await Hive.openBox("setting");
  }

  try {
    Hive.box("messages");
  } catch (e) {
    await Hive.openBox("messages");
  }
  try {
    Hive.box("topics");
  } catch (e) {
    await Hive.openBox("topics");
  }

  try {
    Hive.box("friends");
  } catch (e) {
    await Hive.openBox("friends");
  }

  try {
    Hive.box("user");
  } catch (e) {
    await Hive.openBox("user");
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
