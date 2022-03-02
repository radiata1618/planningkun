import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planningkun/commonEntity/userEntity.dart';
import 'package:planningkun/routes/setting_route.dart';
import '../commonEntity/categoryEntity.dart';
import '../commonEntity/countryEntity.dart';
import '../commonEntity/friendEntity.dart';
import '../commonEntity/chatMessageEntity.dart';
import '../commonEntity/topicEntity.dart';
import '../commonLogic/commonLogic.dart';
import '../developerLogic/insertTestCategoriesData.dart';
import '../developerLogic/insertTestCountriesData.dart';
import '../developerLogic/insertTestTopicsData.dart';
import '../developerLogic/insertTestUsersData.dart';
import '../login.dart';
import 'calendar.dart';
import 'daily.dart';
import 'editInterest.dart';
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
            child: SingleChildScrollView(
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
                Text(ref.watch(userDataProvider).userData["name"]!,
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
                    ref.watch(userDataProvider).mainPhotoData ==
                            null
                        ? null
                        : ref
                            .watch(userDataProvider)
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
                  return EditInterest();
                }),
              );
          },
          child: Text(
              "Edit my interest",
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
                return Daily();
              }),
            );
          },
          child: Text(
            "Write daily",
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
                  return TopicRegister();
                }),
              );
          },
          child: Text(
              "トピックマスタ登録画面",
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
              "カテゴリマスタ登録画面",
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
              child: Text('InsertTestUserData'),
              onPressed: () {
                insertTestUserData(ref);
              },
          ),
        ),
        ElevatedButton(
          style: ButtonStyle(),
          onPressed: () async {

              await closeStreams(ref);
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
              ref.read(categoryDataProvider.notifier)
                  .clearIsar();
          },
          child: Text(
              "clearLocalCategoryData",
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
              ref.read(topicDataProvider.notifier)
                  .clearIsar();
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
        ElevatedButton(
          style: ButtonStyle(),
          onPressed: () async {
              ref.read(friendDataProvider.notifier)
                  .clearHiveAndMemoryAndDirectory();
          },
          child: Text(
              "clearLocalFriendData",
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
              ref.read(userDataProvider.notifier)
                  .clearHiveAndMemoryAndDirectory();
          },
          child: Text(
              "clearLocalUserData",
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
              ref.read(chatMessagesDataProvider.notifier)
                  .clearIsarAndDirectory();
          },
          child: Text(
              "clearMessageData",
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
            ref.read(countryDataProvider.notifier)
                .clearIsar();
          },
          child: Text(
            "clearLocalCountryData",
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
              insertTestTopicData(ref);
          },
          child: Text(
              "insertTestTopicData",
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
              insertTestCategoryData(ref);
          },
          child: Text(
              "insertTestCategoryData",
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
            insertTestCountryData(ref);
          },
          child: Text(
            "insertTestCountryData",
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
                return Calendar();
              }),
            );
          },
          child: Text(
            "Calendar",
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
        Text("本人認証")
      ])
    ])),
            )));
  }
}
