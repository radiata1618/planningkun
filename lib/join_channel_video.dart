import 'dart:developer';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'commonEntity/commonEntity.dart';
import 'commonEntity/friendEntity.dart';
import 'commonEntity/userEntity.dart';
import 'config/agora.config.dart' as config;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

/// MultiChannel Example
class JoinChannelVideo extends ConsumerWidget {
  String argumentFriendUserDocId;
  String argumentChannelId;//Sender側の場合は値が""、Receiverのときのみ値が入っている
  JoinChannelVideo({
    required this.argumentFriendUserDocId,
    required this.argumentChannelId,
    Key? key,
  }) : super(key: key){

    this._initEngine();
  }

  late final RtcEngine _engine;
  String channelId = "";
  bool isJoined = false,
      switchCamera = true,
      switchRender = true;
  List<int> remoteUid = [];
  bool initialProcessFlg=true;


  Future<void> call(WidgetRef ref)async{

    if(argumentChannelId==""){


    await FirebaseFirestore.instance.collection('calls').add({
      'sender':ref.watch(userDataProvider).userData["userDocId"],
      'receiver':argumentFriendUserDocId,
      'startTime': DateTime.now().toString(),
      'status':'yet',
      'endTime': "",
      'insertUserDocId':ref.watch(userDataProvider).userData["userDocId"],
      'insertProgramId': "join_channel_video",
      'insertTime': DateTime.now().toString(),
    }).then((value){
      channelId=value.id;
    });;


    await FirebaseFirestore.instance.collection('messages').add({
      'content': "",
      'userDocId': ref.watch(userDataProvider).userData["userDocId"],
      'oppositeUserDocId': argumentFriendUserDocId,
      'receiveSend': "send",
      'sendTime': DateTime.now().toString(),
      'messageType':"call",
      'callChannelId':channelId,
      'insertUserDocId':ref.watch(userDataProvider).userData["userDocId"],
      'insertProgramId': "join_channel_video",
      'insertTime': DateTime.now().toString(),
    });

    await FirebaseFirestore.instance.collection('messages').add({
      'content': "",
      'userDocId': argumentFriendUserDocId,
      'oppositeUserDocId': ref.watch(userDataProvider).userData["userDocId"],
      'receiveSend': "receive",
      'sendTime': DateTime.now().toString(),
      'messageType':"call",
      'callChannelId':channelId,
      'insertUserDocId':ref.watch(userDataProvider).userData["userDocId"],
      'insertProgramId': "join_channel_video",
      'insertTime': DateTime.now().toString(),
    });

    }else{

      channelId=argumentChannelId;

    }

    await this._joinChannel();

  }

  //TextEditingController? _controller;


  @override
  void dispose() {
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
          isJoined = true;
      },
      userJoined: (uid, elapsed) {
        log('userJoined  ${uid} ${elapsed}');
          remoteUid.add(uid);
      },
      userOffline: (uid, reason) {
        log('userOffline  ${uid} ${reason}');
          remoteUid.removeWhere((element) => element == uid);
      },
      leaveChannel: (stats) {
        log('leaveChannel ${stats.toJson()}');
          isJoined = false;
          remoteUid.clear();
      },
    ));
  }

  _joinChannel() async {

    if (defaultTargetPlatform == TargetPlatform.android) {
      await [Permission.microphone, Permission.camera].request();
    }
    await _engine.joinChannel("", channelId, null, 0);

  }

  _leaveChannel(WidgetRef ref) async {
    await _engine.leaveChannel();
    await FirebaseFirestore.instance.collection('calls').doc(channelId)
        .update({"status": "already",
      'updateUserDocId':ref.watch(userDataProvider).userData["userDocId"],
      'updateProgramId': "join_channel_video",
      'updateTime': DateTime.now().toString(),
    });

  }

  _switchCamera() {
    _engine.switchCamera().then((value) {
        switchCamera = !switchCamera;
    }).catchError((err) {
      log('switchCamera $err');
    });
  }

  _switchRender() {
      switchRender = !switchRender;
      remoteUid = List.of(remoteUid.reversed);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    if (initialProcessFlg){
      initialProcessFlg=false;
      call(ref);
    }

    return Scaffold(
      appBar:AppBar(title:Container(
          child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:[
                Text(ref.watch(friendDataProvider).friendData[argumentFriendUserDocId]![
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
                      onPressed: isJoined ? this._leaveChannel(ref) : this
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
                            channelId:channelId,
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
