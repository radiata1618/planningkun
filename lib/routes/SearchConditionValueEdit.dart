import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';


class SearchConditionValueEdit extends StatefulWidget {
  Map<String, String>  argumentUserData;
  Map<String, String> argumentMasterData;
  String displayedItem;
  String databaseItem;
  String value;

  SearchConditionValueEdit({
    required this.argumentUserData,
    required this.argumentMasterData,
    required this.displayedItem,
    required this.databaseItem,
    required this.value,
  });

  @override
  _SettingTextEdit createState() => _SettingTextEdit();
}

class _SettingTextEdit extends State<SearchConditionValueEdit> {


  @override
  Widget build(BuildContext context) {
    //TODO ChangeNotifierProviderによる変わった値のウィジェットのみを再生成する
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white10,
        elevation: .0,
        title: Text(
          widget.displayedItem,
          style: TextStyle(color: Colors.black87,
              fontWeight: FontWeight.bold),
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
            (widget.databaseItem=="level"||widget.databaseItem=="gender")
                ?const SizedBox(height: 8)
                :Padding(padding:const EdgeInsets.symmetric(horizontal:10),
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
            ),

          ],
        ),
      ),
    );
  }

  Future<void> _updateUserInfo() async {


    await FirebaseFirestore.instance.collection('users').doc(widget.argumentUserData["userDocId"])
        .update({
      widget.databaseItem: widget.value,
      'updateUserDocId':widget.argumentUserData["userDocId"],
      'updateProgramId': "SearchConditionValueEdit",
      'updateTime': DateTime.now().toString(),
        });

    var box = await Hive.openBox('record');

    //FirebaseのデータをHiveに取得
    await box.put(widget.databaseItem, widget.value);
    await box.close();

    widget.argumentUserData[widget.databaseItem]=widget.value;
    Navigator.pop(context);
  }

  Container EditItemContainer(){

    if(widget.databaseItem=="gender"){
      return Container(
          child:Column(
              children:[
                Padding(padding:const EdgeInsets.symmetric(horizontal:10,vertical:20),
                  child:Container(
                    color:Colors.orangeAccent,
                    width: double.infinity,
                    height:50,
                    child:ElevatedButton(
                      style:ButtonStyle(
                      ),
                      onPressed: () {
                        widget.value="1";
                        _updateUserInfo();
                      },
                      child: Text("Male",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                          color: Colors.white,
                        ),),
                    ),),
                ),
                Padding(padding:const EdgeInsets.symmetric(horizontal:10,vertical:20),
                  child:Container(
                    color:Colors.orangeAccent,
                    width: double.infinity,
                    height:50,
                    child:ElevatedButton(
                      style:ButtonStyle(
                      ),
                      onPressed: () {
                        widget.value="2";
                        _updateUserInfo();
                      },
                      child: Text("Female",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                          color: Colors.white,
                        ),),
                    ),),
                ),
                Padding(padding:const EdgeInsets.symmetric(horizontal:10,vertical:20),
                  child:Container(
                    color:Colors.orangeAccent,
                    width: double.infinity,
                    height:50,
                    child:ElevatedButton(
                      style:ButtonStyle(
                      ),
                      onPressed: () {
                        widget.value="3";
                        _updateUserInfo();
                      },
                      child: Text("Other",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                          color: Colors.white,
                        ),),
                    ),),
                )

              ]
          ));

    }else if(widget.databaseItem=="level"){

      return Container(
          child:Column(
              children:[
                Padding(padding:const EdgeInsets.symmetric(horizontal:10,vertical:20),
                  child:Container(
                    color:Colors.orangeAccent,
                    width: double.infinity,
                    height:50,
                    child:ElevatedButton(
                      style:ButtonStyle(
                      ),
                      onPressed: () {
                        widget.value="1";
                        _updateUserInfo();
                      },
                      child: Text("beginner",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                          color: Colors.white,
                        ),),
                    ),),
                ),
                Padding(padding:const EdgeInsets.symmetric(horizontal:10,vertical:20),
                  child:Container(
                    color:Colors.orangeAccent,
                    width: double.infinity,
                    height:50,
                    child:ElevatedButton(
                      style:ButtonStyle(
                      ),
                      onPressed: () {
                        widget.value="2";
                        _updateUserInfo();
                      },
                      child: Text("intermediate",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                          color: Colors.white,
                        ),),
                    ),),
                ),
                Padding(padding:const EdgeInsets.symmetric(horizontal:10,vertical:20),
                  child:Container(
                    color:Colors.orangeAccent,
                    width: double.infinity,
                    height:50,
                    child:ElevatedButton(
                      style:ButtonStyle(
                      ),
                      onPressed: () {
                        widget.value="3";
                        _updateUserInfo();
                      },
                      child: Text("advanced",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                          color: Colors.white,
                        ),),
                    ),),
                ),
                Padding(padding:const EdgeInsets.symmetric(horizontal:10,vertical:20),
                  child:Container(
                    color:Colors.orangeAccent,
                    width: double.infinity,
                    height:50,
                    child:ElevatedButton(
                      style:ButtonStyle(
                      ),
                      onPressed: () {
                        widget.value="4";
                        _updateUserInfo();
                      },
                      child: Text("native",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                          color: Colors.white,
                        ),),
                    ),),
                ),

              ]
          ));

    }else if(widget.databaseItem=="age"){
      return Container(
        child:TextFormField(
          // テキスト入力のラベルを設定
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(labelText: widget.displayedItem),
          initialValue:widget.value,
          onChanged: (String inputValue) {
            setState(() {
              widget.value = inputValue;
            });
          },
        ),
      );
    }else{
      return Container(
        child:TextFormField(
          // テキスト入力のラベルを設定
          decoration: InputDecoration(labelText: widget.displayedItem),
          initialValue:widget.value,
          onChanged: (String inputValue) {
            setState(() {
              widget.value = inputValue;
            });
          },
        ),
      );

    }

  }


}
