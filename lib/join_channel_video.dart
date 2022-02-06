import 'dart:developer';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:cloud_firestore/cloud_firestore.dart';

//import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'config/agora.config.dart' as config;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

/// MultiChannel Example
class JoinChannelVideo extends StatefulWidget {
  Map<String, String> argumentUserData;
  Map<String, String> argumentMasterData;
  Map<String, Map<String, String>> argumentFriendData;
  String argumentFriendUserDocId;

  JoinChannelVideo({required this.argumentUserData,
    required this.argumentMasterData,
    required this.argumentFriendData,
  required this.argumentFriendUserDocId});

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<JoinChannelVideo> {
  late final RtcEngine _engine;
  String channelId = "";
  bool isJoined = false,
      switchCamera = true,
      switchRender = true;
  List<int> remoteUid = [];
  bool initialProcessFlg=true;


  Future<void> call()async{

    await FirebaseFirestore.instance.collection('calls').add({
      'sender':widget.argumentUserData["userDocId"],
      'receiver':widget.argumentFriendUserDocId,
      'startTime': DateTime.now().toString(),
      'status':'yet',
      'endTime': "",
      'insertUserDocId':widget.argumentUserData["userDocId"],
      'insertProgramId': "join_channel_video",
      'insertTime': DateTime.now().toString(),
    }).then((value){
      channelId=value.id;
    });;


    await FirebaseFirestore.instance.collection('messages').add({
      'content': "",
      'userDocId': widget.argumentUserData["userDocId"],
      'oppositeUserDocId': widget.argumentFriendUserDocId,
      'receiveSend': "send",
      'sendTime': DateTime.now().toString(),
      'messageType':"call",
      'callChannelId':channelId,
      'insertUserDocId':widget.argumentUserData["userDocId"],
      'insertProgramId': "join_channel_video",
      'insertTime': DateTime.now().toString(),
    });

    await FirebaseFirestore.instance.collection('messages').add({
      'content': "",
      'userDocId': widget.argumentFriendUserDocId,
      'oppositeUserDocId': widget.argumentUserData["userDocId"],
      'receiveSend': "receive",
      'sendTime': DateTime.now().toString(),
      'messageType':"call",
      'callChannelId':channelId,
      'insertUserDocId':widget.argumentUserData["userDocId"],
      'insertProgramId': "join_channel_video",
      'insertTime': DateTime.now().toString(),
    });

    await this._joinChannel();

  }

  //TextEditingController? _controller;

  @override
  void initState() {
    super.initState();
    // _controller = TextEditingController(text: channelId);
    this._initEngine();
  }

  @override
  void dispose() {
    super.dispose();
    _engine.destroy();
  }

  _initEngine() async {
    _engine = await RtcEngine.createWithContext(RtcEngineContext(config.appId));
    this._addListeners();
    await _engine.enableVideo();
    await _engine.startPreview();
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine.setClientRole(ClientRole.Broadcaster);
  }

  _addListeners() {
    _engine.setEventHandler(RtcEngineEventHandler(
      joinChannelSuccess: (channel, uid, elapsed) {
        log('joinChannelSuccess ${channel} ${uid} ${elapsed}');
        setState(() {
          isJoined = true;
        });
      },
      userJoined: (uid, elapsed) {
        log('userJoined  ${uid} ${elapsed}');
        setState(() {
          remoteUid.add(uid);
        });
      },
      userOffline: (uid, reason) {
        log('userOffline  ${uid} ${reason}');
        setState(() {
          remoteUid.removeWhere((element) => element == uid);
        });
      },
      leaveChannel: (stats) {
        log('leaveChannel ${stats.toJson()}');
        setState(() {
          isJoined = false;
          remoteUid.clear();
        });
      },
    ));
  }

  _joinChannel() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      await [Permission.microphone, Permission.camera].request();
    }
    await _engine.joinChannel("", channelId, null, 0);

    setState(() {
    });
  }

  _leaveChannel() async {
    await _engine.leaveChannel();
    await FirebaseFirestore.instance.collection('calls').doc(channelId)
        .update({"status": "already",
      'updateUserDocId':widget.argumentUserData["userDocId"],
      'updateProgramId': "join_channel_video",
      'updateTime': DateTime.now().toString(),
    });

    setState(() {
    });
  }

  _switchCamera() {
    _engine.switchCamera().then((value) {
      setState(() {
        switchCamera = !switchCamera;
      });
    }).catchError((err) {
      log('switchCamera $err');
    });
  }

  _switchRender() {
    setState(() {
      switchRender = !switchRender;
      remoteUid = List.of(remoteUid.reversed);
    });
  }

  @override
  Widget build(BuildContext context) {

    if (initialProcessFlg){
      initialProcessFlg=false;
      call();
    }

    return Scaffold(
      appBar:AppBar(title:Container(
          child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:[
                Text(widget.argumentFriendData[widget.argumentFriendUserDocId]![
                "friendUserName"]!,
                  style: TextStyle(color: Colors.black87),),
                Container(
                    width: 40,
                    child: Align(
                        alignment: Alignment.center,
                        child: GestureDetector(
                            onTap: () async {

                            },
                            child: Icon(Icons.widgets_outlined,
                                color: Colors.black87, size: 26))))


              ]
      ))),
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  Text(channelId),
                  Container(
                    height: 40,
                    child: ElevatedButton(
                      onPressed: isJoined ? this._leaveChannel : this
                          ._joinChannel,
                      child: Text('${isJoined ? 'Leave' : 'Join'} channel'),
                    ),
                  ),
                  Row(children: [_renderVideo()],)
                ],
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      onPressed: this._switchCamera,
                      child: Text('Camera ${switchCamera ? 'front' : 'rear'}'),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
    );
  }

  Container _renderVideo() {
    return Container(
      height: 100,
      width: 120,
      child: Stack(
        children: [
          RtcLocalView.SurfaceView(),
          Align(
            alignment: Alignment.topLeft,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.of(remoteUid.map(
                      (e) =>
                      GestureDetector(
                        onTap: this._switchRender,
                        child: Container(
                          width: 120,
                          height: 120,
                          child: RtcRemoteView.SurfaceView(
                            uid: e,
                          ),
                        ),
                      ),
                )),
              ),
            ),
          )
        ],
      ),
    );
  }
}
