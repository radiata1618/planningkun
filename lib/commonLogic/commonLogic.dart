

import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

Future<void> initialProcessLogic () async {

  await makeDir("friends");
  await makeDir("topics");
  await makeDir("categories");
  await makeDir("chats");

  var boxSetting = await Hive.openBox('setting');
  await updateTimeCheck("topics",boxSetting);

  boxSetting.close();

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
