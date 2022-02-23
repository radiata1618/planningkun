import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

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
  ,'food'];

  Future<void> initialize(WidgetRef ref)async{
    upperButtonsList=[
      upperButtonUnit( icon: Icons.vpn_lock,ref:ref,index:0),
      upperButtonUnit(
          icon: Icons.accessibility_new_rounded,ref:ref,index:1),
      upperButtonUnit( icon: Icons.wine_bar_sharp,ref:ref,index:2),
      upperButtonUnit( icon: Icons.airplanemode_active,ref:ref,index:3),
      upperButtonUnit(
          icon: Icons.add_photo_alternate_outlined,ref:ref,index:4),
      upperButtonUnit( icon: Icons.wine_bar_sharp,ref:ref,index:5),
    ];

    await tapButton(0);
  }

  Future<void> tapButton(int tappedIndex) async{
    // deactiveButton(selectedIndex);
    // activeButton(tappedIndex);
    await setCategoryId(categoryList[tappedIndex]);
    selectedIndex=tappedIndex;

    notifyListeners();
  }

  activeButton(int index){

  }

  Future<void> setCategoryId(String categoryName) async {

    QuerySnapshot<Map<String, dynamic>> categoryData=await FirebaseFirestore.instance
        .collection('categories')
        .where('categoryName', isEqualTo: categoryName)
        .get();

    categoryId=categoryData.docs[0].id;
  }

  Widget upperButtonUnit({ required IconData icon, required WidgetRef ref,required int index}) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          child: Container(
              height: 40,
              width: 50,
              child: Column(
                children: [Icon(icon), Text(categoryList[index])],
              )),
          onTap: () {
            tapButton(index);
          },
        ));
  }
}
