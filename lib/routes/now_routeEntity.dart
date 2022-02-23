
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../commonLogic/commonLogic.dart';

final nowImageDataProvider = ChangeNotifierProvider(
      (ref) => NowImageDataNotifier(),
);


class NowImageDataNotifier extends ChangeNotifier {
  Uint8List? bytes;

  void initialize() async{
    File file=await urlToFile("https://cdn.with.is/uploads/group/icon/88366/image_211211173101.jpg");

    await file.readAsBytes().then((value) {
      bytes = Uint8List.fromList(value);
      log('reading of bytes is completed');
    }).catchError((onError) {
      log('Exception Error while reading audio from path:' +
          onError.toString());
    });

    notifyListeners();
    // I
    // imageFile = File.fromRawPath(bytes!);
  }
}