import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

import '../firebase_config.dart';
import '../common.dart';

class SettingEditPage extends StatefulWidget {
  UserInfoData argumentUserData;
  Map<String, String> argumentMasterData;
  String displayedItem;
  String databaseItem;
  String? stringValue;
  int? intValue;
  String valueType;

  SettingEditPage({
    required this.argumentUserData,
    required this.argumentMasterData,
    required this.displayedItem,
    required this.databaseItem,
    this.stringValue,
    this.intValue,
    required this.valueType
  });

  @override
  _SettingTextEdit createState() => _SettingTextEdit();
}

class _SettingTextEdit extends State<SettingEditPage> {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
  FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    //TODO ChangeNotifierProviderによる変わった値のウィジェットのみを再生成する
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white10,
        elevation: .0,
        title: Text(
          widget.displayedItem,
          style: TextStyle(color: Colors.black87),
        ),
        iconTheme: IconThemeData(color: Colors.black87),
      ),

      body: SafeArea(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[

        Padding(padding:const EdgeInsets.symmetric(horizontal:10),
            child:EditItemContainer(),),
            const SizedBox(height: 8),

            Padding(padding:const EdgeInsets.symmetric(horizontal:10),
              child:Container(
                color:Colors.orangeAccent,
                width: double.infinity,
                height:50,
                child:ElevatedButton(
                  style:ButtonStyle(
                  ),
                onPressed: () {
                  _updateUserInfo();
                },
                child: Text("OK",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                    color: Colors.white,
                  ),),
              ),),
            )

          ],
        ),
      ),
    );
  }

  Future<void> _updateUserInfo() async {


    await FirebaseFirestore.instance.collection('users').doc(widget.argumentUserData.getUserDocId())
        .update({widget.databaseItem: widget.valueType=="int"? widget.intValue:widget.stringValue});

    var box = await Hive.openBox('record');

    //FirebaseのデータをHiveに取得
    await box.put(widget.databaseItem, widget.valueType=="int"? widget.intValue:widget.stringValue);

    Navigator.pop(context);
  }

  Container EditItemContainer(){

    if(widget.valueType=="int"){

      return Container(
        child:TextFormField(
          // テキスト入力のラベルを設定
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(labelText: widget.displayedItem),
          controller: TextEditingController(text: widget.intValue!.toString()),
          onChanged: (String value) {
            setState(() {
              widget.intValue = int.parse(value);
            });
          },
        ),
      );

    }else if(widget.valueType=="String"){


      return Container(
        child:TextFormField(
          // テキスト入力のラベルを設定
          decoration: InputDecoration(labelText: widget.displayedItem),
          initialValue: widget.stringValue,
          onChanged: (String value) {
            setState(() {
              widget.stringValue = value;
            });
          },
        ),
      );

    }else{
      return Container(
        child:TextFormField(//仮おき
          // テキスト入力のラベルを設定
          decoration: InputDecoration(labelText: widget.displayedItem),
          onChanged: (String value) {
            setState(() {
              widget.stringValue = value;
            });
          },
        ),
      );
    }

  }


}
