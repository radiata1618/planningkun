import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:planningkun/commonEntity/masterEntity.dart';
import 'package:planningkun/commonEntity/userData.dart';
import '../commonEntity/commonEntity.dart';
import 'SearchConditionValueEdit.dart';
class SearchConditionPage extends ConsumerWidget {
  SearchConditionPage({
    Key? key,
  }) : super(key: key);
  bool initialProcessFlg=true;

  var box;
  var firebaseUserData;


  Future<void> getFirebaseData(WidgetRef ref) async {

    firebaseUserData =await FirebaseFirestore.instance.collection('users').doc(ref.watch(userDataProvider).userData["userDocId"]).get();
    box = await Hive.openBox('record');

    //FirebaseのデータをHiveに取得

    await arrangeUserDataUnit(ref,"searchConditionAge");
    await arrangeUserDataUnit(ref,"searchConditionLevel");
    await arrangeUserDataUnit(ref,"searchConditionNativeLang");
    await arrangeUserDataUnit(ref,"searchConditionCountry");
    await arrangeUserDataUnit(ref,"searchConditionGender");

    await box.close();//Closeするとエラーになるのでオープンしたまま

  }

  Future<void> arrangeUserDataUnit(WidgetRef ref,String item) async {
    await box.put(item,firebaseUserData.get(item));
    ref.watch(userDataProvider).userData[item]=await firebaseUserData.get(item);
  }


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    if (initialProcessFlg){
      initialProcessFlg=false;
      getFirebaseData(ref);
    }


    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white10,
          elevation: 0.0,
          title: Text("SearchConditionPages",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 21,
              color: Colors.black87,
            ), // <- (※2)
          ),),
        body: SingleChildScrollView(
          child: SafeArea(
              child: Column(children: <Widget>[
                linePadding(context,ref,"Age","searchConditionAge", ref.watch(userDataProvider).userData["searchConditionAge"]!),
                linePadding(context,ref,"Level","searchConditionLevel", ref.watch(userDataProvider).userData["searchConditionLevel"]!),
                linePadding(context,ref,"Mother tongue","searchConditionNativeLang", ref.watch(userDataProvider).userData["searchConditionNativeLang"]!),
                linePadding(context,ref,"Country","searchConditionCountry", ref.watch(userDataProvider).userData["searchConditionCountry"]!),
                linePadding(context,ref,"Gender","searchConditionGender", ref.watch(userDataProvider).userData["searchConditionGender"]!),
              ])),
        ));
  }

  Padding linePadding (BuildContext context,WidgetRef ref,String displayedItem,String databaseItem, String value) {

    String displayedValue;
    if(databaseItem=="searchConditionLevel"
        ||databaseItem=="searchConditionGender"){
      //displayedValue=widget.argumentMasterData[databaseItem+"_"+value]!;

      displayedValue=value;

    }else if(databaseItem=="searchConditionAge"){

      displayedValue=value;

    }else{
      displayedValue=value;
    }
    return Padding(
        padding: const EdgeInsets.only(left:14,right:14,bottom:10),
        child: Container(
          height: 52,
          child:Column(children:[
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
                      Text(displayedValue,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 18,
                          color: Colors.black87,
                        ),),

                      Padding(padding:const EdgeInsets.only(left:5),
                        child:GestureDetector(
                            onTap: () async{
                              await Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) {
                                  return SearchConditionValueEdit(
                                    argumentUserData: ref.watch(userDataProvider).userData,
                                    argumentMasterData:ref.watch(masterDataProvider).masterData,
                                    displayedItem: displayedItem,
                                    databaseItem: databaseItem,
                                    value:value,
                                  );
                                }),
                              );
                            },
                            child: Icon(
                                Icons.edit,
                                color: Colors.black87,
                                size:18
                            )
                        ),)]),
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
