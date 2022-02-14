import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> getFireBaseData()async {

}
final friendProfileDataProvider = ChangeNotifierProvider(
      (ref) => FriendProfileDataNotifier(),
);


class FriendProfileDataNotifier extends ChangeNotifier {
  Map<String, String> _friendProfileData = {};
  get friendProfileData => _friendProfileData;

  Future<void> readFriendProfileDataFromFirebase(WidgetRef ref,String friendUserDocId)async {
    DocumentSnapshot docSnapShot = await FirebaseFirestore.instance
        .collection('users')
        .doc(friendUserDocId)
        .get();

    //TODO　もともとのユーザとことなるユーザがログインされたら、警告を出して、リセット
    _friendProfileData["userDocId"] = docSnapShot.id;
    _friendProfileData["name"] = docSnapShot["name"];
    _friendProfileData["email"] = docSnapShot["email"];
    _friendProfileData["age"] = docSnapShot["age"];
    _friendProfileData["level"] = docSnapShot["level"];
    _friendProfileData["occupation"] = docSnapShot["occupation"];
    _friendProfileData["nativeLang"] = docSnapShot["nativeLang"];
    _friendProfileData["country"] = docSnapShot["country"];
    _friendProfileData["town"] = docSnapShot["town"];
    _friendProfileData["homeCountry"] = docSnapShot["homeCountry"];
    _friendProfileData["homeTown"] = docSnapShot["homeTown"];
    _friendProfileData["gender"] = docSnapShot["gender"];
    _friendProfileData["placeWannaGo"] = docSnapShot["placeWannaGo"];
    _friendProfileData["greeting"] = docSnapShot["greeting"];
    _friendProfileData["description"] = docSnapShot["description"];
    _friendProfileData["profilePhotoPath"] = docSnapShot["profilePhotoPath"];
    notifyListeners();
  }

}

class FriendProfilePhotoDataNotifier extends ChangeNotifier {
  Image? _img;
  Image? get friendProfilePhotoData => _img;

  Future<void> readFriendProfilePhotoDataFromDirectoryToMemory() async {

  }
}


final friendProfilePhotoDataProvider = ChangeNotifierProvider(
      (ref) => FriendProfilePhotoDataNotifier(),
);

