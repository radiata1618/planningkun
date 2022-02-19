import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final masterDataProvider = ChangeNotifierProvider(
      (ref) => MasterDataProvider(),
);


class MasterDataProvider extends ChangeNotifier {
  Map<String,String> _masterData={
    "level_1":"beginner",
    "level_2":"intermediate",
    "level_3":"advanced",
    "level_4":"native",
    "gender_1":"male",
    "gender_2":"female",
    "gender_3":"other",

  };
  get masterData => _masterData ;

}

