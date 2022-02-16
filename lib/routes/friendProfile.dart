import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../chat.dart';
import '../commonEntity.dart';
import '../commonUI.dart';
import 'friendProfileEntity.dart';

class FriendProfile extends ConsumerWidget {
  FriendProfile({
    required this.argumentFriendUserDocId,
    Key? key,
  }) : super(key: key);
  String argumentFriendUserDocId;
  bool initialProcessFlg = true;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (initialProcessFlg) {
      initialProcessFlg = false;

//一旦前回データをクリア
      ref.read(friendProfileDataProvider.notifier).clearFriendProfileData();

      ref
          .read(friendProfileDataProvider.notifier)
          .readFriendProfileDataFromFirebase(ref, argumentFriendUserDocId);
      //TODO フレンドの場合はローカルからデータを取得
      return Scaffold(
          appBar: whiteAppbar(
              text: (ref
                          .watch(friendProfileDataProvider)
                          .friendProfileData["name"] ==
                      null)
                  ? "Friend Profile"
                  : "Friend Profile"), //Profileデータ読み込み後の再構築のため
          body: Center(child: CircularProgressIndicator()));
    } else {
      return Scaffold(
          appBar: whiteAppbar(text: "Friend Profile"),
          body: Column(children: [
            Expanded(
              child: SingleChildScrollView(
                child: SafeArea(
                    child: Column(children: <Widget>[
                  Center(
                    child: CircleAvatar(
                        radius: 80,
                        backgroundColor: Colors.white,
                        backgroundImage: ref
                                    .watch(friendProfileDataProvider)
                                    .friendProfilePhotoData ==
                                null
                            ? null
                            : ref
                                .watch(friendProfileDataProvider)
                                .friendProfilePhotoData!
                                .image),
                  ),
                  SizedBox(height: 10),
                  linePadding(
                    ref,
                    "Name",
                    "name",
                  ),
                  linePadding(ref, "E-mail", "email"),
                  linePadding(ref, "Age", "age"),
                  linePadding(ref, "English Level", "level"),
                  linePadding(ref, "Occupation", "occupation"),
                  linePadding(ref, "Mother Tongue", "nativeLang"),
                  linePadding(ref, "Country", "country"),
                  linePadding(ref, "Town", "town"),
                  linePadding(ref, "Home Country", "homeCountry"),
                  linePadding(ref, "Home Town", "homeTown"),
                  linePadding(ref, "Gender", "gender"),
                  linePadding(ref, "Place I wanna go", "placeWannaGo"),
                  linePadding(ref, "Greeting", "greeting"),
                  linePadding(ref, "Description", "description"),
                ])),
              ),
            ),
            Container(
                height: 40,
                child: ref.watch(friendProfileDataProvider).friendProfileData["friendFlg"] =="true"
                    ? ElevatedButton(
                        onPressed: () async {
                          await Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) {
                              return Chat(
                                  friendUserDocId:
                                      argumentFriendUserDocId);
                            }),
                          );
                        },
                        style: ButtonStyle(),
                        child: Text(
                          "Talk",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      )
                    : ElevatedButton(
                        onPressed: () async {
                          await ref
                              .read(friendDataProvider.notifier)
                              .insertFriend(ref, argumentFriendUserDocId);

                          await Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) {
                              return Chat(
                                  friendUserDocId:
                                      argumentFriendUserDocId);
                            }),
                          );
                        },
                        style: ButtonStyle(),
                        child: Text(
                          "add to Friends",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ))
          ]));
    }
  }

  Padding linePadding(
      WidgetRef ref, String displayedItem, String databaseItem) {
    //TODO プロフィールを見た後、すぐに他のユーザのプロフィールを見ると前のデータが残っている。→フレンドプロフィールをクリアする処理が必要というか、Riverpodで持つべきでない？
    String value = (ref
                .watch(friendProfileDataProvider)
                .friendProfileData[databaseItem] ==
            null)
        ? ""
        : ref.watch(friendProfileDataProvider).friendProfileData[databaseItem];
    //valueType:String or int or selectString(セグメント)
    String displayedValue;
    if ((databaseItem == "gender" || databaseItem == "level") && value != "") {
      displayedValue =
          ref.watch(masterDataProvider).masterData[databaseItem + "_" + value]!;
    } else {
      displayedValue = value;
    }
    return Padding(
        padding: const EdgeInsets.only(left: 14, right: 14, bottom: 10),
        child: Container(
          height: 52,
          child: Column(children: [
            Container(
              width: double.infinity,
              child: Text(
                displayedItem,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 12,
                  color: Colors.deepOrange,
                ),
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Container(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        displayedValue,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 18,
                          color: Colors.black87,
                        ),
                      ),
                    ]),
              )
            ]),
          ]),
          decoration: BoxDecoration(
            border: const Border(
              bottom: const BorderSide(
                color: Colors.black26,
                width: 0.5,
              ),
            ),
          ),
        ));
  }
}
