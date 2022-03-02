import 'dart:developer';
import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:isar/isar.dart';
import 'package:planningkun/config/categoryDatabase.dart';

import '../commonEntity/categoryEntity.dart';
import '../commonEntity/countryEntity.dart';
import '../commonEntity/friendEntity.dart';
import '../commonEntity/chatMessageEntity.dart';
import '../commonEntity/topicEntity.dart';
import '../commonEntity/userEntity.dart';
import '../config/chatMessageDatabase.dart';
import '../config/countryDatabase.dart';
import '../config/topicDatabase.dart';

Future<void> initialProcessLogic(WidgetRef ref, String email) async {
  await makeDir("friends");
  await makeDir("topics");
  await makeDir("categories");
  await makeDir("countries");
  await makeDir("chatMessages");
  await makeDir("media");

  await openHiveBoxes();

  var boxSetting = Hive.box('setting');
  await updateTimeCheck("topics", boxSetting);
  await updateTimeCheck("friends", boxSetting);
  await updateTimeCheck("user", boxSetting);
  await updateTimeCheck("chatMessages", boxSetting);
  await updateTimeCheck("categories", boxSetting);
  await updateTimeCheck("countries", boxSetting);

  await ref.read(friendDataProvider.notifier).readFriendDataFromHiveToMemory();
  await ref.read(userDataProvider.notifier).readUserDataFromHiveToMemory();
  await ref.read(countryDataProvider.notifier).readCountryDataFromIsarToMemory();

  if(boxSetting.get("email")==null){
    boxSetting.put("email",email);
  }
  ref
      .read(userDataProvider.notifier)
      .controlStreamOfReadUserDataFirebaseToHiveAndMemory(
          boxSetting.get("email"));
  ref
      .read(friendDataProvider.notifier)
      .controlStreamOfReadFriendNewDataFromFirebaseToHiveAndMemory(
          ref, boxSetting.get("userDocId"));
  ref
      .read(topicDataProvider.notifier)
      .controlStreamOfReadTopicNewDataFromFirebaseToIsar();
  ref
      .read(categoryDataProvider.notifier)
      .controlStreamOfReadCategoryNewDataFromFirebaseToIsar();
  ref
      .read(chatMessagesDataProvider.notifier)
      .controlStreamOfReadChatMessageNewDataFromFirebaseToIsar(
          ref, boxSetting.get("userDocId"));

  ref.read(countryDataProvider.notifier).controlStreamOfReadCountryNewDataFromFirebaseToIsarAndMemory();
  ref.read(userDataProvider.notifier).updatelastLoginTime();
  //TODO Master、Topic、Category、Countryは常にWatchする必要ないよね
}

Future<void> closeStreams(WidgetRef ref) async {
  ref.read(categoryDataProvider.notifier).closeStream();
  ref.read(topicDataProvider.notifier).closeStream();
  ref.read(userDataProvider.notifier).closeStream();
  ref.read(friendDataProvider.notifier).closeStream();
  ref.read(chatMessagesDataProvider.notifier).closeStream();
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
    Hive.box("friends");
  } catch (e) {
    await Hive.openBox("friends");
  }

  try {
    Hive.box("user");
  } catch (e) {
    await Hive.openBox("user");
  }


  var isarInstance = Isar.getInstance();
  final dir = await getApplicationSupportDirectory();
  if (isarInstance == null) {
    await Isar.open(
      schemas: [ChatMessageSchema,TopicSchema,CategorySchema,CountrySchema],
      directory: dir.path,
      inspector: true,
    );
  } else {
    if (!isarInstance.isOpen) {
      await Isar.open(
        schemas: [ChatMessageSchema,TopicSchema,CategorySchema,CountrySchema],
        directory: dir.path,
        inspector: true,
      );
    }
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

Future<File> urlToFile(String imageUrl) async {
// generate random number.
  var rng = new Random();
// get temporary directory of device.
  Directory tempDir = await getTemporaryDirectory();
// get temporary path from temporary directory.
  String tempPath = tempDir.path;
// create a new file in temporary path with random file name.
  File file = new File('$tempPath'+ (rng.nextInt(100)).toString() +'.png');
// call http.get method and pass imageUrl into it to get response.
  http.Response response = await http.get( Uri.parse(imageUrl));
// write bodyBytes received in response to file.
  await file.writeAsBytes(response.bodyBytes);
// now return the file which is created with random name in
// temporary directory and image bytes from response is written to // that file.
  //TODO　キャッシュはちゃんと削除するような処理方式に変更？→このメソッドから返った後もファイル使っている？ログイン時などに一括処理？
  return file;
}

String fromDateToYearMonthDayText(DateTime datetime){

  return
    datetime.year.toString() +
        "/" +
        ("00"+datetime.month.toString()).substring(datetime.month.toString().length) +
        "/" +
        ("00"+datetime.day.toString()).substring(datetime.day.toString().length);

}


String fromDateToHourMinuteText(DateTime datetime){

  return
        ("00"+datetime.hour.toString()).substring(datetime.hour.toString().length) +
        ":" +
        ("00"+datetime.minute.toString()).substring(datetime.minute.toString().length);

}
