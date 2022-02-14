// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'dart:io';

import 'package:algolia/algolia.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'commonEntity.dart';
import 'firebase_config.dart';
import 'autoLoginPage.dart';
import 'database.dart';
import 'login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseConfig.platformOptions);
  await Hive.initFlutter();
  Hive.registerAdapter(UserDataAdapter());
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
  // runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
     // navigatorObservers: <NavigatorObserver>[observer],
      home: _LoginCheck()
    );
  }
}


// 新たに追加
class _LoginCheck extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ログイン状態に応じて、画面を切り替える
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? _currentUser = _auth.currentUser;


    if(_currentUser==null){
      return LoginPage(
      );
    }else{
      return AutoLoginPage();
    }
  }
}