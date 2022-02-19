import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> insertTestData() async {
  insertUnitData("wendy",37,"1","JPN");
  insertUnitData("gene",21,"1","JPN");
  insertUnitData("macky",45,"1","JPN");
  insertUnitData("marc",17,"1","JPN");
  insertUnitData("wendy",50,"1","JPN");
  insertUnitData("idolic",34,"2","JPN");
  insertUnitData("mimi",78,"2","JPN");
  insertUnitData("cail",29,"2","JPN");
  insertUnitData("wan",70,"2","JPN");
  insertUnitData("loi",41,"2","USA");
  insertUnitData("coco",33,"2","USA");
  insertUnitData("ois",87,"2","USA");
  insertUnitData("lam",34,"2","USA");
  insertUnitData("cindy",78,"2","USA");
  insertUnitData("qeii",29,"2","USA");
  insertUnitData("natsu",70,"1","USA");
  insertUnitData("wei",41,"1","USA");
  insertUnitData("sand",33,"1","USA");
  insertUnitData("u-ma",87,"1","USA");

}

Future<void> insertUnitData(String name,int age,String gender,String country)async {

  await FirebaseFirestore.instance.collection('users').add(
      {
        'email': name+"@gmail.com",
        'name': name,
        'age': age.toString(),
        'ageNumber': age,
        'level': "1",
        'occupation': 'consultant',
        'nativeLang': country,
        'country': country,
        'town': "Tokyo",
        'homeCountry': country,
        'homeTown': "Nagano",
        'gender': gender,
        'placeWannaGo': 'antarctic',
        'greeting': 'おはようございます！',
        'description': 'わたしは～～～',
        'searchConditionAge': '18,30',
        'searchConditionLevel': '1,2,3,4',
        'searchConditionNativeLang': 'JPN',
        'searchConditionCountry': 'JPN,USA',
        'searchConditionGender': '1,2,3',
        'profilePhotoNameSuffix':"",
        'profilePhotoUpdateCnt': 0,
        'insertUserDocId':"myself",
        'insertProgramId': "login",
        'insertTime': FieldValue.serverTimestamp(),
        'updateUserDocId':"myself",
        'updateProgramId': "login",
        'updateTime': FieldValue.serverTimestamp(),
        'readableFlg': true,
        'deleteFlg': false,
      });

}