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

import 'firebase_config.dart';
import 'rootWidget.dart';
import 'common.dart';
import 'database.dart';


class LoginPage extends ConsumerWidget  {
  LoginPage({
    Key? key,
    // required this.analytics,
    // required this.observer,
  }) : super(key: key);

  // final FirebaseAnalytics analytics;
  // final FirebaseAnalyticsObserver observer;

  String userDocId = '';
  // 登録・ログインに関する情報を表示
  String infoText = "";
  Map<String,String> userData={};
  Map<String,String> masterData={};
  Map<String,Map<String,String>> friendData={};
  var box;
  QuerySnapshot? snapshot;
  Image? _img;


  List<String> _contents=[];
  @override
  void initState(){
  }

  Future<void> _insertUser(String email) async {

    snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get();


    if(snapshot!.size==0){
      FirebaseFirestore.instance.collection('users').add(
        {'email':email ,
          'name': "テスト用",
          'age':"21" ,
          'ageNumber':21 ,
          'level':"1",
          'occupation':'consultant',
          'nativeLang':"JPN",
          'country':"JPN",
          'town':"Tokyo",
          'homeCountry':"JPN",
          'homeTown':"Nagano",
          'gender':"1",
          'placeWannaGo':'antarctic',
          'greeting':'おはようございます！',
          'description':'わたしは～～～',
          'searchConditionAge':'18,30',
          'searchConditionLevel':'1,2,3,4',
          'searchConditionNativeLang':'JPN',
          'searchConditionCountry':'JPN,USA',
          'searchConditionGender':'1,2,3',
          'profilePhotoPath':'',
          'profilePhotoUpdateCnt':'0',
        },
      );

      snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .get();
    }


    userDocId=snapshot!.docs[0].id;



    //Hiveボックスをオープン
    box = await Hive.openBox('record');

    //TODO　もともとのユーザとことなるユーザがログインされたら、警告を出して、リセット
    await box.put("userDocId",userDocId);
    userData["userDocId"]=userDocId;
    await arrangeUserDataUnit("name");
    await arrangeUserDataUnit("email");
    await arrangeUserDataUnit("age");
    await arrangeUserDataUnit("level");
    await arrangeUserDataUnit("occupation");
    await arrangeUserDataUnit("nativeLang");
    await arrangeUserDataUnit("country");
    await arrangeUserDataUnit("town");
    await arrangeUserDataUnit("homeCountry");
    await arrangeUserDataUnit("homeTown");
    await arrangeUserDataUnit("gender");
    await arrangeUserDataUnit("placeWannaGo");
    await arrangeUserDataUnit("greeting");
    await arrangeUserDataUnit("description");
    await arrangeUserDataUnit("searchConditionAge");
    await arrangeUserDataUnit("searchConditionLevel");
    await arrangeUserDataUnit("searchConditionNativeLang");
    await arrangeUserDataUnit("searchConditionCountry");
    await arrangeUserDataUnit("searchConditionGender");
    await arrangeUserDataUnit("profilePhotoPath");
    await arrangeUserDataUnit("profilePhotoUpdateCnt");


    await box.close();

    await FirebaseFirestore.instance.collection('friends').get().then((QuerySnapshot snapshot)async {

      var boxFriend = await Hive.openBox('friend');
      await boxFriend.clear();
      friendData.clear();

      snapshot.docs.forEach((doc) async{

        //Hiveとメモリにデータをセットする処理を追加
        await boxFriend.put(doc.get('friendUserDocId'),{
          'friendUserDocId': doc.id,
          'friendUserName':doc.get('friendUserName'),
          'lastMessageContent': doc.get('lastMessageContent'),
          'lastMessageDocId': doc.get('lastMessageDocId'),
          'lastTime': doc.get('lastTime'),
          'profilePhotoUpdateCnt': doc.get('profilePhotoUpdateCnt'),
        });


        friendData[doc.get('friendUserDocId')]={
          'friendUserDocId': doc.id,
          'friendUserName':doc.get('friendUserName'),
          'lastMessageContent': doc.get('lastMessageContent'),
          'lastMessageDocId': doc.get('lastMessageDocId'),
          'lastTime': doc.get('lastTime'),
          'profilePhotoUpdateCnt': doc.get('profilePhotoUpdateCnt'),
        };


      });
      await boxFriend.close();
    });


    //マスタデータをFirebaseからHiveへ

    await FirebaseFirestore.instance.collection('masters').get().then((QuerySnapshot snapshot)async {

      var boxMaster = await Hive.openBox('master');
      await boxMaster.clear();
      masterData.clear();

      snapshot.docs.forEach((doc) async{

        //Hiveとメモリにデータをセットする処理を追加
        await boxMaster.put(doc.get('item')+"_"+doc.get('selectedValue'),doc.get('displayedValue'));
        masterData[doc.get('item')+"_"+doc.get('selectedValue')]=doc.get('displayedValue');
      });

      await boxMaster.close();
    });


    Directory appDocDir = await getApplicationDocumentsDirectory();
    File localFile = File("${appDocDir.path}/mainPhoto.png");
    _img = Image.file(localFile,width:90);




  }
  Future<void> arrangeUserDataUnit(String item) async {
    userData[item]=snapshot!.docs[0].get(item);
    await box.put(item,snapshot!.docs[0].get(item));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providerから値を受け取る
    final infoText = ref.watch(infoTextProvider);
    final email = ref.watch(emailProvider);
    final password = ref.watch(passwordProvider);

    return Scaffold(
      body: SafeArea(
        child:Column(
          children: <Widget>[
            Container(
                child:Text("ログイン")
            ),
            TextFormField(
              // テキスト入力のラベルを設定
              decoration: InputDecoration(labelText: "メールアドレス"),
              onChanged: (String value) {

                ref.read(emailProvider.state).update((state) => value);
              },
            ),
            const SizedBox(height: 8),
            TextFormField(
              decoration: InputDecoration(labelText: "パスワード（６文字以上）"),
              // パスワードが見えないようにする
              obscureText: true,
              onChanged: (String value) {

                ref.read(passwordProvider.state).update((state) => value);
              },
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () async {
                try {
                  // メール/パスワードでユーザー登録
                  final FirebaseAuth auth = FirebaseAuth.instance;
                  final UserCredential result =
                  await auth.createUserWithEmailAndPassword(
                    email: email,
                    password: password,
                  );

                  // 登録したユーザー情報
                  ref.read(userProvider.state).update((state) => result.user);

                  ref.read(infoTextProvider.state).update((state) => "登録OK:"+ref.watch(emailProvider));
                    await _insertUser(email);
                    // ログインに成功した場合
                    // チャット画面に遷移＋ログイン画面を破棄
                    await Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) {
                        return RootWidget(
                            argumentUserData: userData,
                            argumentMasterData: masterData,
                            argumentFriendData: friendData,
                            argumentMainPhotoData:_img);
                      }),
                    );
                } catch (e) {
                  // 登録に失敗した場合

                  ref.read(infoTextProvider.state).update((state) => "登録NG:${e.toString()}");
                }


              },
              child: Text("ユーザー登録"),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              // ログイン登録ボタン
              child: OutlinedButton(
                child: Text('ログイン'),
                onPressed: () async {
                  try {
                    // メール/パスワードでログイン
                    final FirebaseAuth auth = FirebaseAuth.instance;
                    final UserCredential result = await auth.signInWithEmailAndPassword(
                      email: email,
                      password: password,
                    );

                    // ログインしたユーザー情報
                    ref.read(userProvider.state).update((state) => result.user);
                    await _insertUser(email);
                    // ログインに成功した場合
                    // チャット画面に遷移＋ログイン画面を破棄
                    await Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) {
                        return RootWidget(
                            argumentUserData: userData,
                            argumentMasterData: masterData,
                            argumentFriendData: friendData,
                            argumentMainPhotoData:_img);
                      }),
                    );

                  } catch (e) {
                    // ログインに失敗した場合
                      ref.read(infoTextProvider.state).update((state) => "ログインに失敗しました:${e.toString()}");
                  }
                },
              ),
            ),
            Text(infoText),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              child: OutlinedButton(
                child: Text('テストデータ登録'),
                onPressed: ()  {

                  //TODO テストデータ登録

                },
              ),
            ),
          ],
        ),
      ),
    );
  }



}