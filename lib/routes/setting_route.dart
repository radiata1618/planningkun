
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planningkun/commonEntity/masterEntity.dart';
import 'package:planningkun/commonEntity/userEntity.dart';
import 'package:planningkun/routes/settingEditPage.dart';
import 'package:flutter/material.dart';

import '../commonEntity/commonEntity.dart';


class Setting extends ConsumerWidget {
  Setting({
    Key? key,
  }) : super(key: key) {
    //コンストラクタ
  }

  bool initialProcessFlg=true;

  Widget build(BuildContext context, WidgetRef ref) {
    if (initialProcessFlg){
      initialProcessFlg=false;
      //_showLocalPhoto();
      getFirebaseUserData(ref);
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white10,
          elevation: 0.0,
          title: Text("Settings",
        style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 21,
        color: Colors.black87,
          ), // <- (※2)
        ),),
        body: SingleChildScrollView(
          child: SafeArea(
              child: Column(children: <Widget>[
                Center(
                  child: CircleAvatar(
                    radius: 80,
                    backgroundColor: Colors.white,
                    backgroundImage:ref.watch(mainPhotoDataProvider).mainPhotoData ==null
                        ? null
                        : ref.watch(mainPhotoDataProvider).mainPhotoData!.image,
                  ),
                ),
                MaterialButton(
                    onPressed: () async{
                      await setImage(ref);
                    },
                    child: const Text('写真アップロード') //,
                ),
                linePadding(context,ref,"Name","name", ref.watch(userDataProvider).userData["name"]!),
                linePadding(context,ref,"E-mail","email", ref.watch(userDataProvider).userData["email"]!),
                linePadding(context,ref,"Age","age", ref.watch(userDataProvider).userData["age"]!),
                linePadding(context,ref,"English Level","level", ref.watch(userDataProvider).userData["level"]!),
                linePadding(context,ref,"Occupation","occupation", ref.watch(userDataProvider).userData["occupation"]!),
                linePadding(context,ref,"mother Tongue","nativeLang", ref.watch(userDataProvider).userData["nativeLang"]!),
                linePadding(context,ref,"Country","country", ref.watch(userDataProvider).userData["country"]!),
                linePadding(context,ref,"Town","town", ref.watch(userDataProvider).userData["town"]!),
                linePadding(context,ref,"Home Country","homeCountry", ref.watch(userDataProvider).userData["homeCountry"]!),
                linePadding(context,ref,"Home Town","homeTown", ref.watch(userDataProvider).userData["homeTown"]!),
                linePadding(context,ref,"gender","gender", ref.watch(userDataProvider).userData["gender"]!),
                linePadding(context,ref,"Place I wanna go","placeWannaGo", ref.watch(userDataProvider).userData["placeWannaGo"]!),
                linePadding(context,ref,"Greeting","greeting", ref.watch(userDataProvider).userData["greeting"]!),
                linePadding(context,ref,"Description","description", ref.watch(userDataProvider).userData["description"]!),


          ])),
        ));
  }


  Padding linePadding (BuildContext context,WidgetRef ref,String displayedItem,String databaseItem, String value) {
    //valueType:String or int or selectString(セグメント)
    String displayedValue;
    if(databaseItem=="gender"
    ||databaseItem=="level"){
      displayedValue=ref.watch(masterDataProvider.notifier).masterData[databaseItem+"_"+value]!;
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
                                return SettingEditPage(
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
