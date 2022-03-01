import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';
import '../commonEntity/userEntity.dart';
import '../commonLogic/commonUI.dart';
import '../config/realtime_database_service.dart';
import 'now_routeEntity.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description: 'This channel is used for important notifications.', // description
  importance: Importance.high,
);


class Now extends ConsumerWidget {
  Now({
    Key? key,
  }) : super(key: key){

    _firebaseMessaging.getToken().then((String? token) {
      print(token==null?"":token);
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("フォアグラウンドでメッセージを受け取りました");
      RemoteNotification notification = message.notification!;
      AndroidNotification android = message.notification!.android!;

      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription:channel.description,
                icon: 'launch_background',
              ),
            ));
      }
    });
  }



  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  bool initialProcessFlg=true;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if(initialProcessFlg){
      initialProcessFlg=false;
      ref.watch(nowImageDataProvider.notifier).initialize();
    }
    return Scaffold(
        body: SafeArea(
            child: Column(
              children: [
                Container(
                    child:ref.watch(nowImageDataProvider).bytes==null
                    ?null
                    :Image.memory(ref.watch(nowImageDataProvider).bytes!)
                ),
                whiteBorderRoundButton(
                    text:"presence management",
                    onPressed: () async{
                      //プレゼンス管理
                      final RealtimeDatabaseService _realtimeDatabaseService=ref.watch(realtimeDatabaseServiceProvider);
                      await _realtimeDatabaseService
                          .updateUserPresence(ref.watch(userDataProvider).userData["userDocId"] );
                    })
              ],
            )
        )
    );
  }
}
