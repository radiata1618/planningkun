import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'commonEntity/friendEntity.dart';
import 'commonEntity/masterEntity.dart';
import 'commonEntity/topicEntity.dart';
import 'commonEntity/userData.dart';
import 'commonLogic/commonLogic.dart';
import 'commonUI.dart';
import 'rootWidget.dart';
import 'commonEntity/commonEntity.dart';

class LoginPage extends ConsumerWidget {
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: <Widget>[
                  const SizedBox(height: 20),
                  Container(
                      child: Text(
                    "Logo",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 90,
                      color: Colors.black87,
                    ),
                  )),
                  const SizedBox(height: 200),
                  borderedTextBox(
                    text: "E-Mail",
                    onChanged: (String value) {
                      ref.read(emailProvider.state).update((state) => value);
                    },
                    passwordSecure:false
                  ),
                  const SizedBox(height: 20),
                  borderedTextBox(
                      text: "Password(more than 6 letters)",
                      onChanged: (String value) {
                        ref.read(passwordProvider.state).update((state) => value);
                      }, passwordSecure: true),
                ],
              ),

              Column(
                children: <Widget>[
                  Text(infoText),
                  orangeRoundButton(
                    text: "Sign Up",
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

                        ref
                            .read(infoTextProvider.state)
                            .update((state) => "登録OK:" + ref.watch(emailProvider));

                        await ref
                            .read(userDataProvider.notifier)
                            .insertAndReadUserData(email);
                        loginCommonProcess(context, ref, email);
                      } catch (e) {
                        // 登録に失敗した場合

                        ref
                            .read(infoTextProvider.state)
                            .update((state) => "登録NG:${e.toString()}");
                      }
                    },
                  ),
                  const SizedBox(height: 8),
                  whiteBorderRoundButton(
                    text: "Log In",
                    onPressed: () async {
                      try {
                        // メール/パスワードでログイン
                        final FirebaseAuth auth = FirebaseAuth.instance;
                        final UserCredential result =
                        await auth.signInWithEmailAndPassword(
                          email: email,
                          password: password,
                        );

                        // ログインしたユーザー情報
                        ref.read(userProvider.state).update((state) => result.user);
                        loginCommonProcess(context, ref, email);
                      } catch (e) {
                        // ログインに失敗した場合
                        ref
                            .read(infoTextProvider.state)
                            .update((state) => "ログインに失敗しました:${e.toString()}");
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> loginCommonProcess(
      BuildContext context, WidgetRef ref, String email) async {
    await initialProcessLogic(ref,email);

    // ログインに成功した場合
    // チャット画面に遷移＋ログイン画面を破棄
    await Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) {
        return RootWidget();
      }),
    );
  }
}
