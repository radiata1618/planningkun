import 'dart:async';
import 'dart:core';

import 'package:flutter/material.dart';



const Color themeColorDeep =Colors.orangeAccent;
Text GrayText(String txt) {
  return Text(txt,
    style: TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 16,
      color: Colors.black45,
    ),

  );
}
List<String> FromTextToList(String txt){

  String workText =txt;
  List<String> outputList=[];

  for (;workText.contains(',');){
    outputList.add(workText.substring(0, workText.indexOf(',')));
    workText=workText.substring(workText.indexOf(',')+1);
  }
  outputList.add(workText);

  return outputList;

}