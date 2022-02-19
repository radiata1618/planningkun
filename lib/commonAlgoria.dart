import 'package:algolia/algolia.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'commonEntity/userEntity.dart';
import 'commonLogic/commonLogic.dart';

class Application {
  static final Algolia algolia = Algolia.init(
    applicationId: '41YFHNYKRN',
    apiKey: '0e766cd86ee6c9465c229119c69009d0',
  );
}



String addConditionList(WidgetRef ref,String conditionString, String conditionItemName,String itemName){

  if((ref.watch(userDataProvider).userData[conditionItemName]!)!=""){

    conditionString= conditionString + " AND (";

    List<String > countryConditionList=fromTextToList(ref.watch(userDataProvider).userData[conditionItemName]!);
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

