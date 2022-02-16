

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