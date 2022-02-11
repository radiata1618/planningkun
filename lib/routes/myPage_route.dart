import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:planningkun/routes/setting_route.dart';
import 'topicRegister.dart';
import 'categoryRegister.dart';

class MyPage extends StatefulWidget {
  Map<String,String>  argumentUserData;
  Map<String, String> argumentMasterData;
  Map<String,Map<String,String>>  argumentFriendData;
  Image? argumentMainPhotoData;

  MyPage({required this.argumentUserData,required this.argumentMasterData,required this.argumentFriendData, required this.argumentMainPhotoData});
  @override
  _MyPage createState() => _MyPage();
}

class _MyPage extends State<MyPage> {
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
                child:Column(children:[Container(
                      decoration: BoxDecoration(
                      border: const Border(
                        bottom:const BorderSide(
                          color:Colors.black38,
                          width:0.5
                        )
                      )
                    ),
                        child:Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:[
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical:10),
                              child: Column(children:[Text(widget.argumentUserData["name"]!,
                                style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.black87,
                              ),),
                                ElevatedButton(onPressed: () async {
                                  await Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context) {

                                      return Setting(argumentUserData: widget.argumentUserData,
                                          argumentMasterData:widget.argumentMasterData,
                                          argumentFriendData:widget.argumentFriendData,
                                          argumentMainPhotoData:widget.argumentMainPhotoData);
                                    }),
                                  );
                                  setState(
                                          () {});
                                }, child: Text(
                                  "Edit Profile",
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16,
                                    color: Colors.black54,
                                  ),
                                ),
                                  style: OutlinedButton.styleFrom(
                                    elevation:0,
                                    backgroundColor: Colors.white,
                                    primary: Colors.deepOrange,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    side: const BorderSide(),
                                  ),

                                )


                              ]),
                            ),Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.white,
                                backgroundImage:  widget.argumentMainPhotoData!.image,
                              ),
                            ),
                          ]
                        ),
                    ),
                  Column(
                    children:[

                      ElevatedButton(
                        style: ButtonStyle(),
                        onPressed: () async {
                          await Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) {
                              return TopicRegister(argumentUserData: widget.argumentUserData,
                                  argumentMasterData:widget.argumentMasterData,
                                  argumentFriendData:widget.argumentFriendData,
                                  argumentMainPhotoData:widget.argumentMainPhotoData!);
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
                                  argumentMainPhotoData:widget.argumentMainPhotoData!);
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
                      ),
                      Text("カレンダ"),
                      Text("本人認証")
                    ]
                  )
                ])
            )));
  }
}
