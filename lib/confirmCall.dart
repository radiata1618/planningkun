import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'chat.dart';
import 'rootWidget.dart';
import 'join_channel_video.dart';


class confirmCall extends StatefulWidget {
  Map<String, String>  argumentUserData;
  Map<String, String> argumentMasterData;
  Map<String,Map<String,String>>  argumentFriendData;
  String argumentFriendUserDocId;
  String argumentChannelId;

  confirmCall({required this.argumentUserData,required this.argumentMasterData,required this.argumentFriendData,required this.argumentFriendUserDocId,required this.argumentChannelId});

  @override
  _confirmCall createState() => _confirmCall();
}

class _confirmCall extends State<confirmCall> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(32),
          child: Column(
            children: <Widget>[
              ElevatedButton(
                style:ButtonStyle(
                ),
                onPressed: ()async {
                  await Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) {
                      return JoinChannelVideo(
                        argumentUserData: widget.argumentUserData,
                        argumentMasterData:widget.argumentMasterData,
                        argumentFriendData:widget.argumentFriendData,
                        argumentChannelId: widget.argumentChannelId,
                        argumentFriendUserDocId: widget.argumentFriendUserDocId,

                      );
                    }),
                  );
                },
                child: Text("電話に参加",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                    color: Colors.white,
                  ),),
              ),
              ElevatedButton(
                style:ButtonStyle(
                ),
                onPressed: ()async {
                  Navigator.pop(context);
                },
                child: Text("電話を拒否",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                    color: Colors.white,
                  ),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
