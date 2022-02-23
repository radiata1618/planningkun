import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speech_to_text/speech_to_text.dart';

final dailyPageDataProvider = ChangeNotifierProvider(
      (ref) => DailyPageNotifier(),
);
class DailyPageNotifier extends ChangeNotifier {

  String textForReload="";

  rebuildWidget(){
    textForReload=textForReload+"1";
    notifyListeners();
  }

}
