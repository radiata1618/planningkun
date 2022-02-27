import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'config/firebase_config.dart';
import 'autoLoginPage.dart';
import 'login.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("バックグラウンドでメッセージを受け取りました");
}

Future<void> main() async {
  await initializeDateFormatting('ja');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseConfig.platformOptions);
  await Hive.initFlutter();

  //バックグラウンド用
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

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