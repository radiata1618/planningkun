import 'dart:async';

import 'package:algolia/algolia.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../chat.dart';
import 'friendProfile.dart';
import '../NotUse_friendList.dart';
import '../commonEntity.dart';
import 'SearchConditionPage.dart';

class Search extends StatefulWidget {
  Map<String, String>  argumentUserData;
  Map<String, String> argumentMasterData;
  Map<String,Map<String,String>>  argumentFriendData;
  Image? argumentMainPhotoData;


  Search({required this.argumentUserData,required this.argumentMasterData,required this.argumentFriendData,required this.argumentMainPhotoData});

  @override
  _Search createState() => _Search();
}
class Application {
  static final Algolia algolia = Algolia.init(
    applicationId: '41YFHNYKRN',
    apiKey: '0e766cd86ee6c9465c229119c69009d0',
  );
}


class _Search extends State<Search> {

  bool searchProcessFlg=true;//検索を実行するかどうか、条件画面から検索ボタンで戻ってきたときにONになっている
  AlgoliaQuerySnapshot? snap;
  List<AlgoliaObjectSnapshot> objectList=[];


  String addConditionList(String conditionString, String conditionItemName,String itemName){

    if((widget.argumentUserData[conditionItemName]!)!=""){

      conditionString= conditionString + " AND (";

      List<String > countryConditionList=FromTextToList(widget.argumentUserData[conditionItemName]!);
      for(int i=0;i<countryConditionList.length;i++){
        if(i!=0){
          conditionString= conditionString + " OR ";
        }
        conditionString= conditionString + " "+itemName+":"+countryConditionList[i];
      }
      conditionString= conditionString + " )";
    }

    return conditionString;

  }


  Future<void> userSearch(Algolia algolia)async {



    AlgoliaQuery query = algolia.instance.index('planningkun').query("");
    snap = await query.getObjects();


    List<String > ageConditionList=FromTextToList(widget.argumentUserData["searchConditionAge"]!);

    String filterConditions = "ageNumber:"+ageConditionList[0]+" TO "+ageConditionList[1];
    filterConditions=filterConditions+" AND NOT objectID:"+widget.argumentUserData["userDocId"]!+" ";

    //filterConditions=addConditionList(filterConditions,"searchConditionLevel","level");
    //filterConditions=addConditionList(filterConditions,"searchConditionNativeLang","nativeLang");TODO なぜか追加すると検索できない
    filterConditions=addConditionList(filterConditions,"searchConditionCountry","country");
    //filterConditions=addConditionList(filterConditions,"searchConditionGender","gender");TODO なぜか追加すると検索できない

        //query=query.filters("country:USA");文字検索の成功例
    //query=query.filters("ageNumber:30 TO 40");
    //query=query.facetFilter(["ageNumber:"+ageConditionList[0]+" TO "+ageConditionList[1]]);
    //query=query.filters("country:"+widget.argumentUserData["searchConditionCountry"]!);
    //query=query.filters("country:JPN");
    query=query.filters(filterConditions);
    //query=query.filters("nativeLang:JPN");TODO NATIVELANGが取れない
    //query=query.filters("ageNumber:"+ageConditionList[0]+" TO "+ageConditionList[1]);
   // query.search
    //query=query.filters("age:30");数字情報の検索も成功
    //query=query.facetFilter(["age:30"],);
    //query=query.filters(value)
    snap = await query.getObjects();
    objectList=snap!.hits;

    setState(() {
    });
  }

  //検索後にOFFにする

  @override
  Widget build(BuildContext context) {


    Algolia algolia = Application.algolia;
    if(searchProcessFlg==true){

      searchProcessFlg=false;
      userSearch(algolia);

    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white10,
          elevation: 0.0,
          title: Text("Search",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 21,
              color: Colors.black87,
            ),),
        ),
        body: SafeArea(
            child:Padding(padding:const EdgeInsets.only(top:14,left:14,right:14,bottom:10),
              child:Column(
                children:[
                  Padding(
                    padding: const EdgeInsets.only(bottom:10.0),
                    child: Container(
                      height: 42,
                      child:Row(
                        children:[
                          Expanded(
                      child:Container(
                            child:Padding(
                              padding:const EdgeInsets.symmetric(horizontal:13),
                              child:Row(
                              children:[Align(
                                alignment:Alignment.centerLeft
                                ,child:Text("set conditions",
                              style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 18,
                              color: Colors.deepOrangeAccent,
                            ),
                            )),
                                Expanded(
                                  child:Align(
                                        alignment:Alignment.centerRight
                                        ,child:GestureDetector(
                                    onTap: () async{
                                      await Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                          return SearchConditionPage(
                                            argumentUserData: widget.argumentUserData,
                                            argumentMasterData:widget.argumentMasterData,
                                            argumentSearchProcessFlg: searchProcessFlg ,
                                            //★★★★★★★★★★searchProcessFlgは帰ってきたときにしっかり値が入っているのか
                                          );
                                        }),
                                      );

                                    },
                                    child: Icon(
                                        Icons.view_headline_sharp,
                                        color: Colors.deepOrangeAccent,
                                        size:26
                                    )
                                )
                                  ),
                                )
                              ],),),
                            decoration: BoxDecoration(
                              color:Color.fromRGBO(	252,217,151, 1),
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),),
                          Container(
                            width:40,
                          child:Align(
                              alignment:Alignment.center,
                              child:GestureDetector(
                                  onTap: () async{

                                    userSearch(algolia);
                                  },
                                  child: Icon(
                                      Icons.search,
                                      color: Colors.black87,
                                      size:26
                                  )
                              )
                          ))
                        ]
                      )
                    ),
                  ),
                Expanded(
                    child:ListView.builder(
                        itemCount:objectList.length,
                        itemBuilder:(BuildContext context,int index){
                          return userResultList(objectList[index]);
                        }
                ))
                ]
              )
            )
        )
    );
  }

  Widget userResultList(AlgoliaObjectSnapshot userData){
    return GestureDetector(
      onTap:()async{
        await Navigator.of(context).push(
          MaterialPageRoute(builder: (context) {
            return FriendProfile(
                argumentUserData: widget.argumentUserData,
                argumentMasterData:widget.argumentMasterData,
                argumentFriendData:widget.argumentFriendData,
                argumentFriendUserDocId:userData.data["objectID"],
              argumentMainPhotoData: widget.argumentMainPhotoData!,
            );
          }),
        );
      },
      child: Container(
        color: Colors.white10,
        height:80,
        child:Row(
          children:[
            Container(
              child:CircleAvatar(radius:32),
                  width:80
            ),
            Expanded(
              child:Column(
                children:[
                  Padding(
                    padding: const EdgeInsets.only(top:8.0),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child:Text(userData.data["name"],
                            style:TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:4.0),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child:Text(userData.data["country"],
                          style:TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            color: Colors.black54,
                          ),
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:4.0),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child:Text(userData.data["greeting"],
                          style:TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            color: Colors.black54,
                          ),
                        )
                    ),
                  ),
                ],
              )
            ),
            Container(
                width:70,
              child:Column(
                children:[
                  Padding(
                    padding: const EdgeInsets.only(top:8.0),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child:Text(userData.data["ageNumber"].toString(),
                          style:TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            color: Colors.black54,
                          ),
                        )
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () async{
                        await InsertFriend(userData.data["objectID"],userData.data["name"],userData.data["profilePhotoPath"],userData.data["profilePhotoUpdateCnt"]);

                    await Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) {
                        return Chat(
                       argumentUserData: widget.argumentUserData,
                          argumentMasterData:widget.argumentMasterData,
                            argumentFriendData:widget.argumentFriendData,
                          argumentFriendUserDocId:userData.data["objectID"]
                        );
                      }),
                    );
                  },

                    style:ButtonStyle(
                    ),
                    child: Text("add",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                      color: Colors.white,
                    ),),)
                ]
              )
            )
          ]
        )

      ),
    );

  }


  Future<void> InsertFriend(String friendUserDocId,String friendUserName,String friendProfilePhotoPath ,String friendProfilePhotoUpdateCnt) async{
    String insertedDocId="";

    //相手側のFriendデータもFirebaseのみに作成する
    FirebaseFirestore.instance.collection('friends').add(
      {'userDocId':friendUserDocId ,
        'friendUserDocId': widget.argumentUserData["userDocId"] ,
        'friendUserName': widget.argumentUserData["name"] ,
        'profilePhotoPath': widget.argumentUserData["profilePhotoPath"] ,
        'profilePhotoUpdateCnt': widget.argumentUserData["profilePhotoUpdateCnt"] ,
        'lastMessageContent': "",
        'lastMessageDocId': "",
        'lastTime': DateTime.now().toString(),
        'insertUserDocId':widget.argumentUserData["userDocId"],
        'insertProgramId': "search_route",
        'insertTime': DateTime.now().toString(),
      },
    );

    FirebaseFirestore.instance.collection('friends').add(
      {'userDocId':widget.argumentUserData["userDocId"] ,
        'friendUserDocId': friendUserDocId,
        'friendUserName': friendUserName ,
        'profilePhotoPath': friendProfilePhotoPath ,
        'profilePhotoUpdateCnt': friendProfilePhotoUpdateCnt,
        'lastMessageContent': "",
        'lastMessageDocId': "",
        'lastTime': DateTime.now().toString(),
        'insertUserDocId':widget.argumentUserData["userDocId"],
        'insertProgramId': "search_route",
        'insertTime': DateTime.now().toString(),
      },
    ).then((value){
      insertedDocId=value.id;
    });

    var friendBox = await Hive.openBox('friend');
    await friendBox.put(friendUserDocId,{
      'friendUserDocId': insertedDocId,
      'friendUserName': friendUserName,
      'profilePhotoPath': friendProfilePhotoPath ,
      'profilePhotoUpdateCnt': friendProfilePhotoUpdateCnt,
      'lastMessageContent': "",
      'lastMessageDocId': "",
      'lastTime': DateTime.now().toString(),
    });
    await friendBox.close();

    widget.argumentFriendData[friendUserDocId]={
      'friendUserDocId': insertedDocId,
      'friendUserName': friendUserName,
      'profilePhotoPath': friendProfilePhotoPath ,
      'profilePhotoUpdateCnt': friendProfilePhotoUpdateCnt,
      'lastMessageContent': "",
      'lastMessageDocId': "",
      'lastTime': DateTime.now().toString(),
    };

  }


}