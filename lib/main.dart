// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'package:algolia/algolia.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'firebase_config.dart';
import 'tabs_page.dart';
import 'login.dart';
import 'rootWidget.dart';
import 'common.dart';
import 'database.dart';
import 'common.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseConfig.platformOptions);
  await Hive.initFlutter();
  Hive.registerAdapter(UserDataAdapter());


  //Hive.registerAdapter(RecordModelAdapter());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
  FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      navigatorObservers: <NavigatorObserver>[observer],
      home: MyHomePage(
        title: 'Firebase Analytics Demo',
        analytics: analytics,
        observer: observer,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key? key,
    required this.title,
    required this.analytics,
    required this.observer,
  }) : super(key: key);

  final String title;
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _message = '';
  String email = '';
  String userDocId = '';
  // 入力されたパスワード
  String password = "";
  // 登録・ログインに関する情報を表示
  String infoText = "";
  Map<String,String> userData={};
  Map<String,String> masterData={};
  Map<String,Map<String,String>> friendData={};
  var box;
  QuerySnapshot? snapshot;


  List<String> _contents=[];
  @override
  void initState(){
  }

  Future<void> _insertUserAndMove(String email) async {

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
      // ログインに成功した場合
      // チャット画面に遷移＋ログイン画面を破棄
      await Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) {
          return RootWidget(
            argumentUserData: userData,
              argumentMasterData: masterData,
              argumentFriendData: friendData);
        }),
      );

  }
  Future<void> arrangeUserDataUnit(String item) async {
    userData[item]=snapshot!.docs[0].get(item);
    await box.put(item,snapshot!.docs[0].get(item));
  }

  @override
  Widget build(BuildContext context) {
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
              setState(() {
                email = value;
              });
            },
          ),
          const SizedBox(height: 8),
          TextFormField(
            decoration: InputDecoration(labelText: "パスワード（６文字以上）"),
            // パスワードが見えないようにする
            obscureText: true,
            onChanged: (String value) {
              setState(() {
                password = value;
              });
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
                final User user = result.user!;
                setState(() {
                  infoText = "登録OK：${user.email}";

                  _insertUserAndMove(email);
                });
              } catch (e) {
                // 登録に失敗した場合
                setState(() {
                  infoText = "登録NG：${e.toString()}";
                });
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
                  await auth.signInWithEmailAndPassword(
                    email: email,
                    password: password,
                  );
                  _insertUserAndMove(email);

                } catch (e) {
                  // ログインに失敗した場合
                  setState(() {
                    infoText = "ログインに失敗しました：${e.toString()}";
                  });
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


                FirebaseFirestore.instance.collection('users').add(
                  {'email':"testaaaaa@gmail.com" ,
                    'name': "testaaaaaさん",
                    'age':"44" ,
                    'ageNumber':44 ,
                    'level':"2",
                    'occupation':'staff',
                    'nativeLang':"ENG",
                    'country':"USA",
                    'town':"Tokyo",
                    'homeCountry':"JPN",
                    'homeTown':"Toyota",
                    'gender':"2",
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

                FirebaseFirestore.instance.collection('users').add(
                  {'email':"testbbbb@gmail.com" ,
                    'name': "testbbbbさん",
                    'age':"50" ,
                    'ageNumber':50 ,
                    'level':"4",
                    'occupation':'staff',
                    'nativeLang':"ENG",
                    'country':"USA",
                    'town':"Tokyo",
                    'homeCountry':"JPN",
                    'homeTown':"Toyota",
                    'gender':"3",
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
                FirebaseFirestore.instance.collection('users').add(
                  {'email':"testcccc@gmail.com" ,
                    'name': "testccccさん",
                    'age':"29" ,
                    'ageNumber':29 ,
                    'level':"3",
                    'occupation':'staff',
                    'nativeLang':"ENG",
                    'country':"USA",
                    'town':"Tokyo",
                    'homeCountry':"JPN",
                    'homeTown':"Toyota",
                    'gender':"3",
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

                FirebaseFirestore.instance.collection('users').add(
                  {'email':"testdddd@gmail.com" ,
                    'name': "testddddさん",
                    'age':"30" ,
                    'ageNumber':30 ,
                    'level':"3",
                    'occupation':'staff',
                    'nativeLang':"ENG",
                    'country':"USA",
                    'town':"Tokyo",
                    'homeCountry':"JPN",
                    'homeTown':"Toyota",
                    'gender':"3",
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

                FirebaseFirestore.instance.collection('users').add(
                  {'email':"testeeee@gmail.com" ,
                    'name': "testeeeeさん",
                    'age':"60" ,
                    'ageNumber':60 ,
                    'level':"3",
                    'occupation':'staff',
                    'nativeLang':"ENG",
                    'country':"USA",
                    'town':"Tokyo",
                    'homeCountry':"JPN",
                    'homeTown':"Toyota",
                    'gender':"3",
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

                FirebaseFirestore.instance.collection('users').add(
                  {'email':"testffff@gmail.com" ,
                    'name': "testffffさん",
                    'age':"37" ,
                    'ageNumber':37 ,
                    'level':"2",
                    'occupation':'staff',
                    'nativeLang':"ENG",
                    'country':"USA",
                    'town':"Tokyo",
                    'homeCountry':"JPN",
                    'homeTown':"Toyota",
                    'gender':"3",
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


                FirebaseFirestore.instance.collection('users').add(
                  {'email':"testfgggg@gmail.com" ,
                    'name': "testggggさん",
                    'age':"37" ,
                    'ageNumber':37 ,
                    'level':"2",
                    'occupation':'staff',
                    'nativeLang':"ENG",
                    'country':"USA",
                    'town':"Tokyo",
                    'homeCountry':"JPN",
                    'homeTown':"Toyota",
                    'gender':"3",
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

                FirebaseFirestore.instance.collection('users').add(
                  {'email':"testhhhf@gmail.com" ,
                    'name': "teshhhさん",
                    'age':"37" ,
                    'ageNumber':37 ,
                    'level':"2",
                    'occupation':'staff',
                    'nativeLang':"CHN",
                    'country':"JPN",
                    'town':"Tokyo",
                    'homeCountry':"JPN",
                    'homeTown':"Toyota",
                    'gender':"3",
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

                FirebaseFirestore.instance.collection('users').add(
                  {'email':"testiii@gmail.com" ,
                    'name': "tesiiiiiさん",
                    'age':"37" ,
                    'ageNumber':37 ,
                    'level':"2",
                    'occupation':'staff',
                    'nativeLang':"ENG",
                    'country':"USA",
                    'town':"Tokyo",
                    'homeCountry':"JPN",
                    'homeTown':"Toyota",
                    'gender':"3",
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


                FirebaseFirestore.instance.collection('users').add(
                  {'email':"testaaaaa@gmail.com" ,
                    'name': "testaaaaaさん",
                    'age':"44" ,
                    'ageNumber':44 ,
                    'level':"2",
                    'occupation':'staff',
                    'nativeLang':"ENG",
                    'country':"USA",
                    'town':"Tokyo",
                    'homeCountry':"JPN",
                    'homeTown':"Toyota",
                    'gender':"2",
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

                FirebaseFirestore.instance.collection('users').add(
                  {'email':"testbbbb@gmail.com" ,
                    'name': "testbbbbさん",
                    'age':"50" ,
                    'ageNumber':50 ,
                    'level':"4",
                    'occupation':'staff',
                    'nativeLang':"ENG",
                    'country':"USA",
                    'town':"Tokyo",
                    'homeCountry':"JPN",
                    'homeTown':"Toyota",
                    'gender':"3",
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
                FirebaseFirestore.instance.collection('users').add(
                  {'email':"testcccc@gmail.com" ,
                    'name': "testccccさん",
                    'age':"29" ,
                    'ageNumber':29 ,
                    'level':"3",
                    'occupation':'staff',
                    'nativeLang':"ENG",
                    'country':"USA",
                    'town':"Tokyo",
                    'homeCountry':"JPN",
                    'homeTown':"Toyota",
                    'gender':"3",
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

                FirebaseFirestore.instance.collection('users').add(
                  {'email':"testdddd@gmail.com" ,
                    'name': "testddddさん",
                    'age':"30" ,
                    'ageNumber':30 ,
                    'level':"3",
                    'occupation':'staff',
                    'nativeLang':"ENG",
                    'country':"USA",
                    'town':"Tokyo",
                    'homeCountry':"JPN",
                    'homeTown':"Toyota",
                    'gender':"3",
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

                FirebaseFirestore.instance.collection('users').add(
                  {'email':"testeeee@gmail.com" ,
                    'name': "testeeeeさん",
                    'age':"60" ,
                    'ageNumber':60 ,
                    'level':"3",
                    'occupation':'staff',
                    'nativeLang':"ENG",
                    'country':"USA",
                    'town':"Tokyo",
                    'homeCountry':"JPN",
                    'homeTown':"Toyota",
                    'gender':"3",
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

                FirebaseFirestore.instance.collection('users').add(
                  {'email':"testffff@gmail.com" ,
                    'name': "testffffさん",
                    'age':"37" ,
                    'ageNumber':37 ,
                    'level':"2",
                    'occupation':'staff',
                    'nativeLang':"ENG",
                    'country':"USA",
                    'town':"Tokyo",
                    'homeCountry':"JPN",
                    'homeTown':"Toyota",
                    'gender':"3",
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


                FirebaseFirestore.instance.collection('users').add(
                  {'email':"testfgggg@gmail.com" ,
                    'name': "testggggさん",
                    'age':"37" ,
                    'ageNumber':37 ,
                    'level':"2",
                    'occupation':'staff',
                    'nativeLang':"ENG",
                    'country':"USA",
                    'town':"Tokyo",
                    'homeCountry':"JPN",
                    'homeTown':"Toyota",
                    'gender':"3",
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

                FirebaseFirestore.instance.collection('users').add(
                  {'email':"testhhhf@gmail.com" ,
                    'name': "teshhhさん",
                    'age':"37" ,
                    'ageNumber':37 ,
                    'level':"2",
                    'occupation':'staff',
                    'nativeLang':"CHN",
                    'country':"JPN",
                    'town':"Tokyo",
                    'homeCountry':"JPN",
                    'homeTown':"Toyota",
                    'gender':"3",
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

                FirebaseFirestore.instance.collection('users').add(
                  {'email':"testiii@gmail.com" ,
                    'name': "tesiiiiiさん",
                    'age':"37" ,
                    'ageNumber':37 ,
                    'level':"2",
                    'occupation':'staff',
                    'nativeLang':"ENG",
                    'country':"USA",
                    'town':"Tokyo",
                    'homeCountry':"JPN",
                    'homeTown':"Toyota",
                    'gender':"3",
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
              },
            ),
          ),
        ],
      ),
      ),
    );
  }
}