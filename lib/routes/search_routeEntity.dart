import 'package:algolia/algolia.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planningkun/commonEntity/userData.dart';
import 'package:planningkun/commonLogic/commonLogic.dart';

import '../commonAlgoria.dart';
import '../commonEntity/commonEntity.dart';




final SearchResultProvider = ChangeNotifierProvider(
      (ref) => SearchResultNotifier(),
);


class SearchResultNotifier extends ChangeNotifier {
  List<AlgoliaObjectSnapshot> _searchResultList=[];
  get searchResultList => _searchResultList;


  Map<String,Image?> _friendImage={};
  get friendImage => _friendImage;

  void clear(){
    _searchResultList=[];
    _friendImage={};
  }
  Future<void> userSearch(WidgetRef ref)async {

    Algolia algolia = Application.algolia;

    AlgoliaQuery query = algolia.instance.index('planningkun').query("");
    AlgoliaQuerySnapshot? snap = await query.getObjects();

    List<String > ageConditionList=fromTextToList(ref.watch(userDataProvider).userData["searchConditionAge"]!);

    String filterConditions = "ageNumber:"+ageConditionList[0]+" TO "+ageConditionList[1];
    filterConditions=filterConditions+" AND NOT objectID:"+ref.watch(userDataProvider).userData["userDocId"]!+" ";

    //filterConditions=addConditionList(filterConditions,"searchConditionLevel","level");
    //filterConditions=addConditionList(filterConditions,"searchConditionNativeLang","nativeLang");TODO なぜか追加すると検索できない
    filterConditions=addConditionList(ref,filterConditions,"searchConditionCountry","country");
    //filterConditions=addConditionList(filterConditions,"searchConditionGender","gender");TODO なぜか追加すると検索できない

    //query=query.filters("country:USA");文字検索の成功例
    //query=query.filters("ageNumber:30 TO 40");
    //query=query.facetFilter(["ageNumber:"+ageConditionList[0]+" TO "+ageConditionList[1]]);
    //query=query.filters("country:"+widget.argumentUserData["searchConditionCountry"]!);
    //query=query.filters("country:JPN");
    query=query.filters(filterConditions);
    //query=query.filters("nativeLang:JPN");TODO NATIVELANGが取れない
    //query=query.filters("ageNumber:"+ageConditionList[0]+" TO "+ageConditionList[1]);
    // query.search
    //query=query.filters("age:30");数字情報の検索も成功
    //query=query.facetFilter(["age:30"],);
    //query=query.filters(value)
    snap = await query.getObjects();

    _searchResultList=snap.hits;
    await setFriendPhoto();
    notifyListeners();

  }

  Future<void> setFriendPhoto()async {
    _friendImage.clear();
    FirebaseStorage storage =  FirebaseStorage.instance;

    for(int i=0;i<_searchResultList.length;i++){
      String photoPath=_searchResultList[i].data["profilePhotoPath"];

      if(photoPath.contains("mainPhoto")){
        //写真が登録されている場合

        try {

          Reference imageRef = storage.ref().child("profile").child(
              _searchResultList[i].data["objectID"]!).child("mainPhoto_small."+photoPath.substring(photoPath.lastIndexOf('.') + 1,));
          await imageRef.getDownloadURL().then((imageUrl){
            _friendImage[_searchResultList[i].data["objectID"]!] =Image.network(imageUrl, width: 90);
          });


        }catch(e){
          //写真があるはずなのになぜかエラーだった
          _friendImage[_searchResultList[i].data["objectID"]!] =null;

        }

      }else{
        //写真が登録されていない場合

        _friendImage[_searchResultList[i].data["objectID"]!] =null;
      }


    }

}

}
