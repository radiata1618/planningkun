import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';



//TODO　もともとのユーザとことなるユーザがログインされたら、警告を出して、リセット
Future<void> insertUserToFirebase(String email) async {
  String insertedDocId="";
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('users')
      .where('email', isEqualTo: email)
      .get();

  if (snapshot.size == 0) {
    await FirebaseFirestore.instance.collection('users').add(
      {
        'email': email,
        'name': "notifierTest",
        'age': "21",
        'ageNumber': 21,
        'level': "1",
        'occupation': 'consultant',
        'nativeLang': "JPN",
        'country': "JPN",
        'town': "Tokyo",
        'homeCountry': "JPN",
        'homeTown': "Nagano",
        'gender': "1",
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
        'lastLoginTime': FieldValue.serverTimestamp(),
        'insertUserDocId':"myself",
        'insertProgramId': "login",
        'insertTime': FieldValue.serverTimestamp(),
        'updateUserDocId':"myself",
        'updateProgramId': "login",
        'updateTime': FieldValue.serverTimestamp(),
        'readableFlg': true,
        'deleteFlg': false,
      }).then((value){
        insertedDocId=value.id;
      });

    var box= await Hive.openBox("setting");
    box.put("email",email);
    box.put("userDocId",insertedDocId);


  }
}