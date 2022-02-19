import 'dart:developer';

import "package:flutter/src/foundation/platform.dart";
import 'package:permission_handler/permission_handler.dart';

import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;

import '../config/agora.config.dart' as config;
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
class MapPage extends StatefulWidget {

  @override
  _MapPage createState() => _MapPage();
}


class _MapPage extends State<MapPage> {
  late final RtcEngine _engine;
  bool isJoined = false, switchCamera = true, switchRender = true;
  List<int> remoteUid = [];

  @override
  void initState() {
    super.initState();
    //this._initEngine();
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

  //Future <void>
  _leaveAndJoinChannel(bool ifJoined,String channelId) async {
    await this._initEngine();

    if (ifJoined){
      await _leaveChannel();
    }else{
      await  _joinChannel(channelId);
    }

  }

  String channel = "aaaaa";
  int userId=0;
  _joinChannel(String channel) async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      await [Permission.microphone, Permission.camera].request();
    }
    await _engine.joinChannel("", channel, null, userId);
  }

  _leaveChannel() async {
    await _engine.leaveChannel();
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
    return Scaffold(
        appBar: AppBar(
          title: Text("ビデオテスト"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                // テキスト入力のラベルを設定
                decoration: InputDecoration(labelText: "チャネルID"),
                onChanged: (String value) {
                  setState(() {
                    channel = value;
                  });
                },
              ),
              // ElevatedButton(onPressed: _joinChannel(channel), child: Text("Join")),
              // ElevatedButton(onPressed: _joinChannel(channel), child: Text("Leave")),
              ElevatedButton(
                  onPressed:this._leaveAndJoinChannel(isJoined,channel),
                  // isJoined
                      // ? this._leaveChannel
                      // :this._joinChannel(channel),
                child: Text('${isJoined ? 'Leave' : 'Join'} channel'),),
              ElevatedButton(
                onPressed: this._switchCamera,
                child: Text('Camera ${switchCamera ? 'front' : 'rear'}'),
              ),

              _renderVideo(),
            ],
          ),
        ));
  }

  _renderVideo() {
    return Expanded(
      child: Stack(
        children: [
          RtcLocalView.SurfaceView(),
          Align(
            alignment: Alignment.topLeft,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.of(remoteUid.map(
                      (e) => GestureDetector(
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


