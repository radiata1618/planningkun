import 'package:algolia/algolia.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'commonEntity.dart';

class Application {
  static final Algolia algolia = Algolia.init(
    applicationId: '41YFHNYKRN',
    apiKey: '0e766cd86ee6c9465c229119c69009d0',
  );
}



String addConditionList(WidgetRef ref,String conditionString, String conditionItemName,String itemName){

  if((ref.watch(userDataProvider).userData[conditionItemName]!)!=""){

    conditionString= conditionString + " AND (";

    List<String > countryConditionList=FromTextToList(ref.watch(userDataProvider).userData[conditionItemName]!);
    for(int i=0;i<countryConditionList.length;i++){
      if(i!=0){
        conditionString= conditionString + " OR ";
      }
      conditionString= conditionString + " "+itemName+":"+countryConditionList[i];
    }
    conditionString= conditionString + " )";
  }

  return conditionString;

}


Future<List<AlgoliaObjectSnapshot>> userSearch(WidgetRef ref,Algolia algolia)async {

  AlgoliaQuery query = algolia.instance.index('planningkun').query("");
  AlgoliaQuerySnapshot? snap = await query.getObjects();

  List<String > ageConditionList=FromTextToList(ref.watch(userDataProvider).userData["searchConditionAge"]!);

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
  return snap!.hits;

}