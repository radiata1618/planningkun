import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

import '../config/categoryDatabase.dart';

final topicPageDataProvider = ChangeNotifierProvider(
      (ref) => TopicPageDataNotifier(),
);

class TopicPageDataNotifier extends ChangeNotifier {
  String categoryId ="";
  List<Widget> upperButtonsList=[];
  int selectedIndex = 0;

  List<String> categoryList=['top'
  ,'sports'
  ,'drink'
  ,'travel'
  ,'art'
    ,'food'
    ,'nature'];

  List<IconData> iconList=[Icons.vpn_lock
    ,Icons.accessibility_new_rounded
    ,Icons.wine_bar_sharp
    ,Icons.airplanemode_active
    ,Icons.add_photo_alternate_outlined
    ,Icons.wine_bar_sharp
  ,Icons.filter_hdr];

  Future<void> initialize(WidgetRef ref)async{

    for(int i =0;i<categoryList.length;i++){
      upperButtonsList.add(upperButtonUnit(index:i,activeBool:false));
    }

    await tapButton(0);
  }

  Future<void> tapButton(int tappedIndex) async{
    deactiveButton(selectedIndex);
    activeButton(tappedIndex);
    await setCategoryId(categoryList[tappedIndex]);
    selectedIndex=tappedIndex;

    notifyListeners();
  }

  deactiveButton(int index){
    upperButtonsList[index]=upperButtonUnit(index:index,activeBool:false);
  }

  activeButton(int index){
    upperButtonsList[index]=upperButtonUnit(index:index,activeBool:true);
  }

  Future<void> setCategoryId(String categoryName) async {

    var isarInstance = Isar.getInstance();
    Query<Category>? categoriesDataQuery =
    isarInstance?.categorys.filter()
        .categoryNameEqualTo(categoryName).build();

    categoryId=categoriesDataQuery!.findAllSync()[0].categoryDocId;
  }

  Widget upperButtonUnit({ required int index,required bool activeBool}) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          child: Container(
              height: 40,
              width: 50,
              child: Column(
                children: [Icon(iconList[index]
                ,color:activeBool
                        ?Colors.orangeAccent
                        :Colors.black54
                ),
                  Text(categoryList[index])],
              )),
          onTap: () {
            tapButton(index);
          },
        ));
  }
}
