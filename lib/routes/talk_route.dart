import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planningkun/commonEntity/friendEntity.dart';
import 'package:planningkun/commonEntity/userEntity.dart';
import "package:intl/intl.dart";
import 'package:intl/date_symbol_data_local.dart';

import '../chat.dart';
import '../commonUI.dart';

class Talk extends ConsumerWidget {
  Talk({
    Key? key,
  }) : super(key: key);

  double screenHeight=1;
  double screenWidth=1;
  double screenAdjustSizeH=1;


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    
    return Scaffold(
      appBar: whiteAppbar(text: 'Talk'),
      body: buildTalkList(context,ref,ref.watch(userDataProvider).userData["userDocId"]!),
    );
  }

  Future<void> moveToChat(String friendUserDocId, BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Chat(friendUserDocId:friendUserDocId
            ,friendUserName:""),
      ),
    );
  }

  Widget buildTalkList(BuildContext context,WidgetRef ref,String userDocId) {

    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    screenAdjustSizeH = MediaQuery.of(context).size.height * 0.0011;

    List tmpList=[];
    Map<String,Map<String,dynamic>> tmpMap =ref.read(friendDataProvider.notifier).friendData;

    //リスト化
    tmpMap.forEach((key, value) {
      value["friendUserDocId"]=key;
      tmpList.add(value);
    });

    //表示順にソート
    tmpList.sort((a,b) => b["lastMessageTime"].compareTo(a["lastMessageTime"]));

        return ListView.builder(
          itemCount:tmpList.length,
    itemBuilder:(BuildContext context,int index){
    return talkListUnit( context,  ref,tmpList[index]);
          }
      );

}

  Widget talkListUnit(BuildContext context,WidgetRef ref,Map<String,dynamic> friendDataMap) {
    String todayStr=new DateFormat('MM/dd', "ja_JP").format(DateTime.now());

    return  Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0*screenAdjustSizeH),
              child: Container(
                height: 70,
                child: GestureDetector(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15*screenAdjustSizeH),
                          child: CircleAvatar(radius: 35*screenAdjustSizeH,
                              backgroundImage: ref
                              .watch(friendDataProvider)
                              .friendPhotoData['friendUserDocId'] ==null
                              ? null
                              : ref.watch(friendDataProvider)
                                  .friendPhotoData['friendUserDocId'] !
                              .image),
                        ),
                        Column(children: [
                          Container(
                            height: 20,
                            width:screenWidth-15.0*screenAdjustSizeH*2-35*screenAdjustSizeH*2-60*screenAdjustSizeH,
                            child: Text(
                              friendDataMap['friendUserName'],
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          Container(
                            height: 45,
                            width:screenWidth-15.0*screenAdjustSizeH*2-35*screenAdjustSizeH*2-60*screenAdjustSizeH,
                            child: Text(
                              friendDataMap['lastMessageContent'],
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 15,
                                color: Colors.black45,
                              ),
                            ),
                          ),
                        ]),
                        Container(
                            width: 60*screenAdjustSizeH,
                            child: Column(children: [
                              Container(
                                height: 16,
                                child: Text(
                                    todayStr== DateFormat('MM/dd', "ja_JP").format(friendDataMap["lastMessageTime"])
                                  ? DateFormat('hh:mm', "ja_JP").format(friendDataMap["lastMessageTime"])
                                  : DateFormat('MM/dd', "ja_JP").format(friendDataMap["lastMessageTime"]),
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15,
                                    color: Colors.black45,
                                  ),
                                ),
                              ),
                            ]))
                      ]),
                  onTap: () {
                    moveToChat(friendDataMap['friendUserDocId'], context);
                  },
                ),
              ),
            );
      }
}
