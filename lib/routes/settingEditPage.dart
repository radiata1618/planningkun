import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planningkun/routes/settingEditPageEntity.dart';

class SettingEditPage extends ConsumerWidget {
  SettingEditPage({
    required this.displayedItem,
    required this.databaseItem,
    required this.value,
    Key? key,
  }) : super(key: key) {
  }
  String displayedItem;
  String databaseItem;
  String value;
  bool initialProcessFlg=true;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if(initialProcessFlg){
      initialProcessFlg=false;
      ref.watch(userItemDataProvider.notifier).initialize(displayedItem,databaseItem,value);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white10,
        elevation: .0,
        title: Text(
          ref.watch(userItemDataProvider).userItemDisplayedItem,
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
            child:EditItemContainer(context,  ref),),
            const SizedBox(height: 8),
            (ref.watch(userItemDataProvider).userItemDataDatabaseItem=="level"||ref.watch(userItemDataProvider).userItemDataDatabaseItem=="gender")
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
                    ref.watch(userItemDataProvider.notifier).updateUserInfo(context, ref);
                    Navigator.pop(context);
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

  Container EditItemContainer(BuildContext context, WidgetRef ref){

    if(ref.watch(userItemDataProvider).userItemDataDatabaseItem=="gender"){
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
                  onPressed: () async{
                    ref.watch(userItemDataProvider.notifier).setUserItemDataValue("1");
                    await ref.watch(userItemDataProvider.notifier).updateUserInfo(context, ref);
                    Navigator.pop(context);
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
                  onPressed: () async{
                    ref.watch(userItemDataProvider.notifier).setUserItemDataValue("2");
                    await ref.watch(userItemDataProvider.notifier).updateUserInfo(context, ref);
                    Navigator.pop(context);
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
                  onPressed: () async{
                    ref.watch(userItemDataProvider.notifier).setUserItemDataValue("3");
                    await ref.watch(userItemDataProvider.notifier).updateUserInfo(context, ref);
                    Navigator.pop(context);
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

    }else if(ref.watch(userItemDataProvider).userItemDataDatabaseItem=="level"){

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
                      onPressed: () async{
                        ref.watch(userItemDataProvider.notifier).setUserItemDataValue("1");
                        await ref.watch(userItemDataProvider.notifier).updateUserInfo(context, ref);
                        Navigator.pop(context);
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
                      onPressed: () async{
                        ref.watch(userItemDataProvider.notifier).setUserItemDataValue("2");
                        await ref.watch(userItemDataProvider.notifier).updateUserInfo(context, ref);
                        Navigator.pop(context);
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
                      onPressed: () async{
                        ref.watch(userItemDataProvider.notifier).setUserItemDataValue("3");
                        await ref.watch(userItemDataProvider.notifier).updateUserInfo(context, ref);
                        Navigator.pop(context);
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
                      onPressed: () async{
                        ref.watch(userItemDataProvider.notifier).setUserItemDataValue("4");
                        await ref.watch(userItemDataProvider.notifier).updateUserInfo(context, ref);
                        Navigator.pop(context);
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

    }else if(ref.watch(userItemDataProvider).userItemDataDatabaseItem=="age"){
      return Container(
        child:TextFormField(
          // テキスト入力のラベルを設定
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(labelText: ref.watch(userItemDataProvider).userItemDisplayedItem),
          initialValue:ref.watch(userItemDataProvider).userItemDataValue,
          onChanged: (String inputValue) {
            ref.watch(userItemDataProvider.notifier).setUserItemDataValue(inputValue);
          },
        ),
      );
    }else{
      return Container(
        child:TextFormField(
          // テキスト入力のラベルを設定
          decoration: InputDecoration(labelText: ref.watch(userItemDataProvider).userItemDisplayedItem),
          initialValue:ref.watch(userItemDataProvider).userItemDataValue,
          onChanged: (String inputValue) {
              ref.watch(userItemDataProvider.notifier).setUserItemDataValue(inputValue);
          },
        ),
      );

    }



  }


}
