import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../chat.dart';
import '../FriendList.dart';
import '../common.dart';
import 'SearchConditionPage.dart';

class Search extends StatefulWidget {
  Map<String, String>  argumentUserData;
  Map<String, String> argumentMasterData;


  Search({required this.argumentUserData,required this.argumentMasterData});

  @override
  _Search createState() => _Search();
}

class _Search extends State<Search> {

  bool searchProcessFlg=true;//検索を実行するかどうか、条件画面から検索ボタンで戻ってきたときにONになっている
  //検索後にOFFにする

  @override
  Widget build(BuildContext context) {
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
                  Container(
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
                              )),)
                            ],),),
                          decoration: BoxDecoration(
                            color:Color.fromRGBO(	255,228,181, 1),
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),),
                        Container(
                          width:40,
                        child:Align(
                            alignment:Alignment.center,
                            child:GestureDetector(
                                onTap: () async{

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
                  )
                ]
              )
            )
        )
    );
  }
}