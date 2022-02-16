

import 'dart:io';

import 'package:path_provider/path_provider.dart';

Future<void> initialProcessLogic () async {

  Directory appDocDir = await getApplicationDocumentsDirectory();
  final Directory appDocDirFolder = Directory("${appDocDir.path}/friend");
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
