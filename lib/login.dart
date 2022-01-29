import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'chat.dart';
import 'register.dart';
import 'rootWidget.dart';


class login extends StatefulWidget {
  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  // 入力されたメールアドレス
  String email = "";
  // 入力されたパスワード
  String password = "";
  // 登録・ログインに関する情報を表示
  String infoText = "";
  String userDocId = "";
  Future<void> _insertUser(String email) async {

    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get();

    if(snapshot.size==0){
      FirebaseFirestore.instance.collection('users').add(
        {'email':email , 'name': "テスト用", 'age':21 },
      );

      snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .get();
    }

    userDocId=snapshot.docs[0].id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(32),
          child: Column(
            children: <Widget>[
              TextFormField(
                // テキスト入力のラベルを設定
                decoration: InputDecoration(labelText: "メールアドレス"),
                onChanged: (String value) {
                  setState(() {
                    email = value;
                  });
                },
              ),
              // const SizedBox(height: 8),
              // TextFormField(
              //   decoration: InputDecoration(labelText: "パスワード（６文字以上）"),
              //   // パスワードが見えないようにする
              //   obscureText: true,
              //   onChanged: (String value) {
              //     setState(() {
              //       password = value;
              //     });
              //   },
              // ),
              // const SizedBox(height: 8),
              // ElevatedButton(
              //   onPressed: () async {
              //     try {
              //       // メール/パスワードでユーザー登録
              //       final FirebaseAuth auth = FirebaseAuth.instance;
              //       final UserCredential result =
              //       await auth.createUserWithEmailAndPassword(
              //         email: email,
              //         password: password,
              //       );
              //
              //       _insertUser(email);
              //
              //       await Navigator.of(context).pushReplacement(
              //         MaterialPageRoute(builder: (context) {
              //           return Register(argumentEmail:email);
              //         }),
              //       );
              //
              //       // 登録したユーザー情報
              //       final User user = result.user!;
              //       setState(() {
              //         infoText = "登録OK：${user.email}";
              //       });
              //     } catch (e) {
              //       // 登録に失敗した場合
              //       setState(() {
              //         infoText = "登録NG：${e.toString()}";
              //       });
              //     }
              //
              //
              //   },
              //   child: Text("ユーザー登録"),
              // ),
              // const SizedBox(height: 8),
              // Container(
              //   width: double.infinity,
              //   // ログイン登録ボタン
              //   child: OutlinedButton(
              //     child: Text('ログイン'),
              //     onPressed: () async {
              //       try {
              //         // メール/パスワードでログイン
              //         final FirebaseAuth auth = FirebaseAuth.instance;
              //         await auth.signInWithEmailAndPassword(
              //           email: email,
              //           password: password,
              //         );
              //         // ログインに成功した場合
              //         // チャット画面に遷移＋ログイン画面を破棄
              //         await Navigator.of(context).pushReplacement(
              //           MaterialPageRoute(builder: (context) {
              //             return RootWidget(
              //               argumentEmail: email,
              //               argumentUserDocId: userDocId,);
              //           }),
              //         );
              //       } catch (e) {
              //         // ログインに失敗した場合
              //         setState(() {
              //           infoText = "ログインに失敗しました：${e.toString()}";
              //         });
              //       }
              //     },
              //   ),
              // ),
              Text(infoText),
            ],
          ),
        ),
      ),
    );
  }
}
