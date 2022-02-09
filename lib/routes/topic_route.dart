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

    if(initialProcessflg){
      initialProcessflg=false;
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
          children: horizonalDetailList(),
        ));
  }

  List<Widget> horizonalDetailList() {

    final List<Widget> outputList = workCategoryList;

    if(outputList.length==0){
      return [Text("")];
    }else{

      return outputList;
    }

  }

  Future<void> setCategoryLines() async {


    // await setCategoryUnit("food");
    await setCategoryUnit("nature");
    // await setCategoryUnit("religion");

    setState(() {

    });
  }

  Future<void> setCategoryUnit(String categoryName) async {
    List<Widget> topicList = [];

    await FirebaseFirestore.instance.collection('topics')
        .where('categoryName', isEqualTo: categoryName)
        .get().then((QuerySnapshot snapshot)async {


      snapshot.docs.forEach((doc) async{
        //
        // Reference imageRef = await storage.ref(doc.get("photoPath"));
        // String imageUrl = await imageRef.getDownloadURL();
        // Image img =await Image.network(imageUrl,width:90);

        topicList.add(
          // Padding(
          //   padding:const EdgeInsets.symmetric(horizontal:4,vertical:3 ),
          //   child:Container(
          //     width:100,
          //     child: Column(
          //       children:[
          //
          //         // CircleAvatar(
          //         //   radius: 90,
          //         //   backgroundColor: Colors.white,
          //         //   backgroundImage:  img.image,
          //         // ),

                  Text(doc.get("topicName"),
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                      color: Colors.black45,
                    ),)
          //       ]
          //     ),
          //   )
          // )


        );
      });
    });

    workCategoryList.add(Container(
      height:40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: topicList,
      ),
    ));

    //topicList.clear();
  }
}
