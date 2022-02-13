import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../commonEntity.dart';

final topicNameProvider = StateProvider.autoDispose((ref) {
  return '';
});

class CategoryItemsNotifier extends ChangeNotifier {
  List<DropdownMenuItem<String>> _categoryItems=[];
  get categoryItems => _categoryItems ;

  String _selectedCategoryItem="";
  get selectedCategoryItem=>_selectedCategoryItem;

  CategoryItemsNotifier()  {
    setCategoryItemsProvider();
  }

  void clearCategoryItemsNotifier()  {
    _selectedCategoryItem = _categoryItems[0].value!;
    notifyListeners();
  }

  void setCategoryItemId(String id){

    _selectedCategoryItem = id;
    notifyListeners();
  }

  Future<void> setCategoryItemsProvider() async {

    //マスタデータをFirebaseからHiveへ
    await FirebaseFirestore.instance
        .collection('categories')
        .get()
        .then((QuerySnapshot snapshot) async {
      snapshot.docs.forEach((doc) async {
        // //TODO Hiveとメモリにデータをセットする処理を追加
        // await boxMaster.put(doc.get('item')+"_"+doc.get('selectedValue'),doc.get('displayedValue'));
        // masterData[doc.get('item')+"_"+doc.get('selectedValue')]=doc.get('displayedValue');

        _categoryItems
          ..add(DropdownMenuItem(
            child: Text(
              doc.get('categoryName'),
              style: TextStyle(fontSize: 16.0),
            ),
            value: doc.id,
          ));
      });

      // await boxMaster.close();
    });
    _selectedCategoryItem = _categoryItems[0].value!;

    notifyListeners();
  }
}

final categoryItemsProvider = ChangeNotifierProvider(
        (ref) => CategoryItemsNotifier());


class TopicImagePhotoFile extends ChangeNotifier {
  File? _topicImagePhotoFile;
  get topicImagePhotoFile => _topicImagePhotoFile ;


  void clearTopicImagePhotoFile() {
    _topicImagePhotoFile=null;
    notifyListeners();
  }

   void setTopicImagePhotoFile(File? imageFile) {
    _topicImagePhotoFile=imageFile;
    notifyListeners();
  }
}

final topicImagePhotoFileProvider = ChangeNotifierProvider(
        (ref) => TopicImagePhotoFile());



Future<void> insertTopic(WidgetRef ref,String topicName) async {

  String insertedDocId="";


  try {
    var firebaseUserData = await FirebaseFirestore.instance
        .collection('categories')
        .doc(ref.watch(categoryItemsProvider).selectedCategoryItem)
        .get();

    await FirebaseFirestore.instance.collection('topics').add(
      {'categoryDocId':ref.watch(categoryItemsProvider).selectedCategoryItem ,
        'categoryName':firebaseUserData.get("categoryName"),
        'photoPath':'',
        'photoUpdateCnt':'0',
        'topicName':topicName,
        'insertUserDocId':ref.watch(userDataProvider.notifier).userData["userDocId"],
        'insertProgramId': "topicRegister",
        'insertTime': DateTime.now().toString(),

      },
    ).then((value){
      insertedDocId=value.id;
    });

    FirebaseStorage storage = FirebaseStorage.instance;
    String pathStr= ref.watch(topicImagePhotoFileProvider.notifier).topicImagePhotoFile!.path;
    await storage.ref("topics/" + insertedDocId + pathStr.substring(pathStr.lastIndexOf('.'),))
        .putFile(ref.watch(topicImagePhotoFileProvider.notifier).topicImagePhotoFile!);

    await FirebaseFirestore.instance.collection('topics').doc(insertedDocId)
        .update({"photoUpdateCnt":"1",
      "photoPath": "topics/" + insertedDocId + pathStr.substring(pathStr.lastIndexOf('.'),),
      'updateUserDocId':ref.watch(userDataProvider.notifier).userData["userDocId"],
      'updateProgramId': "topicRegister",
      'updateTime': DateTime.now().toString(),
    });

    //TODO Hive,メモリへのデータ登録

  } catch (e) {
    print(e);
  }
}