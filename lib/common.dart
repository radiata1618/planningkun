import 'dart:async';

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


Text BlackText(String txt) {
  return Text(txt,
    style: TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 16,
      color: Colors.black38,
    ),

  );
}