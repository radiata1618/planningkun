import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'topicRegister.dart';
import 'categoryRegister.dart';

class Topic extends StatefulWidget {
  Map<String, String> argumentUserData;
  Map<String, String> argumentMasterData;
  Map<String, Map<String, String>> argumentFriendData;
  Image argumentMainPhotoData;

  Topic(
      {required this.argumentUserData,
      required this.argumentMasterData,
      required this.argumentFriendData,
      required this.argumentMainPhotoData});

  @override
  _Topic createState() => _Topic();
}

class _Topic extends State<Topic> {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  List<Widget> workCategoryList = [];
  bool initialProcessflg = true;

  FirebaseStorage storage = FirebaseStorage.instance;

  @override
  Widget build(BuildContext context) {
    if (initialProcessflg) {
      initialProcessflg = false;
      setCategoryLines();
    }
    return Scaffold(
        body: SafeArea(
            child: Container(
                child: Column(children: [
      Container(color: Colors.black54, height: 40),
      Expanded(
        child: topicsEntire(),
      )
    ]))));
  }

  Widget topicsEntire() {
    return SingleChildScrollView(
        child: Column(
          children:[
          Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Topic&Text",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                        color: Colors.black45,
                      ),
                    )),
              )),
            Container(child:Column(children:horizonalDetailList(),))
            ]
    ));
  }

  List<Widget> horizonalDetailList() {
    final List<Widget> outputList = workCategoryList;

    if (outputList.length == 0) {
      return [Text("")];
    } else {
      return outputList;
    }
  }

  Future<void> setCategoryLines() async {
    await setCategoryUnit("food");
    await setCategoryUnit("nature");
    //TODO どのカテゴリを表示するか、DBから設定値を取得
    // await setCategoryUnit("religion");

    setState(() {});
  }

  Future<void> setCategoryUnit(String categoryName) async {
    List<Widget> topicList = [];

    await FirebaseFirestore.instance
        .collection('topics')
        .where('categoryName', isEqualTo: categoryName)
        .get()
        .then((QuerySnapshot snapshot) async {
      // for(int i=0;i<snapshot.docs.length;i++){

      for (int i = 0; i < snapshot.docs.length; i++) {
        Reference imageRef =
            await storage.ref(snapshot.docs[i].get("photoPath"));
        String imageUrl = await imageRef.getDownloadURL();
        Image img = await Image.network(imageUrl, height: 40, width: 70);

        topicList.add(Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
            child: Container(
              color: Colors.white10,
              height: 200,
              width: 140,
              child: Column(children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  backgroundImage: img.image,
                ),
                Text(
                  snapshot.docs[i].get("topicName"),
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                    color: Colors.black45,
                  ),
                )
              ]),
            )));
      }
      ;
    });

    workCategoryList.add(Column(
      children: [
        Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(categoryName,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                      color: Colors.black45,
                    ),
                  )),
            )),
        Container(
          color: Colors.blueAccent,
          height: 140,
          width: 500,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: topicList,
          ),
        ),
      ],
    ));

    //topicList.clear();
  }
}
