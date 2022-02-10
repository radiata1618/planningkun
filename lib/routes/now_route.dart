import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'topicRegister.dart';
import 'categoryRegister.dart';

class Now extends StatefulWidget {
  Map<String,String>  argumentUserData;
  Map<String, String> argumentMasterData;
  Map<String,Map<String,String>>  argumentFriendData;
  Image argumentMainPhotoData;

  Now({required this.argumentUserData,required this.argumentMasterData,required this.argumentFriendData, required this.argumentMainPhotoData});
  @override
  _Now createState() => _Now();
}

class _Now extends State<Now> {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
  FirebaseAnalyticsObserver(analytics: analytics);

  DateTime? startDateTime;
  DateTime? endDateTime;

  int status = 1; //1:スタート時間を選択中、2:エンド時間を選択中

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
                child: Column(children: [
                  ElevatedButton(
                    style: ButtonStyle(),
                    onPressed: () async {
                      await Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) {
                          return TopicRegister(argumentUserData: widget.argumentUserData,
                              argumentMasterData:widget.argumentMasterData,
                              argumentFriendData:widget.argumentFriendData,
                              argumentMainPhotoData:widget.argumentMainPhotoData);
                        }),
                      );
                      setState(
                              () {}); //TODO FutureBuilderを使用するようにして非同期のデータ取得のあとSetStateするダサい処理を削除したい
                    },
                    child: Text(
                      "トピック登録画面",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(),
                    onPressed: () async {
                      await Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) {
                          return CategoryRegister(argumentUserData: widget.argumentUserData,
                              argumentMasterData:widget.argumentMasterData,
                              argumentFriendData:widget.argumentFriendData,
                              argumentMainPhotoData:widget.argumentMainPhotoData);
                        }),
                      );
                      setState(
                              () {}); //TODO FutureBuilderを使用するようにして非同期のデータ取得のあとSetStateするダサい処理を削除したい
                    },
                    child: Text(
                      "カテゴリ登録画面",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  )
                ]))));
  }
}
