import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planningkun/commonEntity/userData.dart';
import 'package:planningkun/routes/setting_route.dart';
import '../commonEntity/commonEntity.dart';
import '../commonEntity/topicEntity.dart';
import '../insertTestData.dart';
import '../login.dart';
import 'topicRegister.dart';
import 'categoryRegister.dart';

class MyPage extends ConsumerWidget {
  MyPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: SafeArea(
            child: Container(
                child: Column(children: [
      Container(
        decoration: BoxDecoration(
            border: const Border(
                bottom: const BorderSide(color: Colors.black38, width: 0.5))),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Column(children: [
              Text(
                ref.watch(userDataProvider).userData["name"]!,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black87,
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  await Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) {
                      return Setting();
                    }),
                  );
                },
                child: Text(
                  "Edit Profile",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.white,
                  primary: Colors.deepOrange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  side: const BorderSide(),
                ),
              )
            ]),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: CircleAvatar(
              radius: 40,
              backgroundColor: Colors.white,
              backgroundImage:
                  ref.watch(mainPhotoDataProvider).mainPhotoData ==
                          null
                      ? null
                      : ref
                          .watch(mainPhotoDataProvider)
                          .mainPhotoData!
                          .image,
            ),
          ),
        ]),
      ),
      Column(children: [
        ElevatedButton(
          style: ButtonStyle(),
          onPressed: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) {
                return TopicRegister();
              }),
            );
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
                return CategoryRegister();
              }),
            );
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
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          child: OutlinedButton(
            child: Text('テストデータ登録'),
            onPressed: () {
              insertTestData();
            },
          ),
        ),
        ElevatedButton(
          style: ButtonStyle(),
          onPressed: () async {
            // ログアウト処理
            // 内部で保持しているログイン情報等が初期化される
            // （現時点ではログアウト時はこの処理を呼び出せばOKと、思うぐらいで大丈夫です）
            await FirebaseAuth.instance.signOut();
            // ログイン画面に遷移＋チャット画面を破棄
            await Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) {
                return LoginPage();
              }),
            );
          },
          child: Text(
            "Logout",
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
            ref
                .read(topicDataProvider.notifier)
                .clearHiveAndMemoryAndDirectory();
          },
          child: Text(
            "clearLocalTopicData",
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
        Text("カレンダ"),
        Text("本人認証")
      ])
    ]))));
  }
}
