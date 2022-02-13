
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'rootWidget.dart';
import 'commonEntity.dart';


class LoginPage extends ConsumerWidget  {
  LoginPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providerから値を受け取る
    final infoText = ref.watch(infoTextProvider);
    final email = ref.watch(emailProvider);
    final password = ref.watch(passwordProvider);


    return Scaffold(
      body: SafeArea(
        child:Column(
          children: <Widget>[
            Container(
                child:Text("ログイン")
            ),
            TextFormField(
              // テキスト入力のラベルを設定
              decoration: InputDecoration(labelText: "メールアドレス"),
              onChanged: (String value) {

                ref.read(emailProvider.state).update((state) => value);
              },
            ),
            const SizedBox(height: 8),
            TextFormField(
              decoration: InputDecoration(labelText: "パスワード（６文字以上）"),
              // パスワードが見えないようにする
              obscureText: true,
              onChanged: (String value) {

                ref.read(passwordProvider.state).update((state) => value);
              },
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () async {
                try {
                  // メール/パスワードでユーザー登録
                  final FirebaseAuth auth = FirebaseAuth.instance;
                  final UserCredential result =
                  await auth.createUserWithEmailAndPassword(
                    email: email,
                    password: password,
                  );

                  // 登録したユーザー情報
                  ref.read(userProvider.state).update((state) => result.user);

                  ref.read(infoTextProvider.state).update((state) => "登録OK:"+ref.watch(emailProvider));

                  await ref.read(userDataProvider.notifier).insertAndReadUserData(email);
                  loginCommonProcess(context, ref,email);
                } catch (e) {
                  // 登録に失敗した場合

                  ref.read(infoTextProvider.state).update((state) => "登録NG:${e.toString()}");
                }
              },
              child: Text("ユーザー登録"),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              // ログイン登録ボタン
              child: OutlinedButton(
                child: Text('ログイン'),
                onPressed: () async {
                  try {
                    // メール/パスワードでログイン
                    final FirebaseAuth auth = FirebaseAuth.instance;
                    final UserCredential result = await auth.signInWithEmailAndPassword(
                      email: email,
                      password: password,
                    );

                    // ログインしたユーザー情報
                    ref.read(userProvider.state).update((state) => result.user);
                    loginCommonProcess(context, ref,email);

                  } catch (e) {
                    // ログインに失敗した場合
                      ref.read(infoTextProvider.state).update((state) => "ログインに失敗しました:${e.toString()}");
                  }
                },
              ),
            ),
            Text(infoText)
          ],
        ),
      ),
    );
  }

  Future<void> loginCommonProcess(BuildContext context, WidgetRef ref,String email)async{

    await ref.read(userDataProvider.notifier).readUserDataFirebaseToHiveAndMemoryByEmail(email);
    await ref.read(friendDataProvider.notifier).readFriendDataFromFirebaseToHiveAndMemory(ref.watch(userDataProvider.notifier).userData["userDocId"]!);
    await ref.read(masterDataProvider.notifier).readMasterDataFromFirebaseToHiveAndMemory();
    // ログインに成功した場合
    // チャット画面に遷移＋ログイン画面を破棄
    await Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) {
        return RootWidget();
      }),
    );

  }
}