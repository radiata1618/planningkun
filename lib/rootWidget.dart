import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planningkun/routes/myPage_route.dart';

// == 作成したWidget をインポート ==================
import 'routes/myPage_route.dart';
import 'routes/talk_route.dart';
import 'routes/search_route.dart';
import 'routes/mapPage_route.dart';
import 'routes/setting_route.dart';
import 'routes/topic_route.dart';
import 'routes/now_route.dart';
import 'commonEntity.dart';
import 'dart:core';
// =============================================

final _selectedIndexProvider = StateProvider.autoDispose((ref) {
  return 0;
});

class BottomNavigationBarItems extends StateNotifier<List<BottomNavigationBarItem>> {
  BottomNavigationBarItems() : super(<BottomNavigationBarItem>[]);

  static const _footerItemNames = [
    'Now',
    'Talk',
    'Find',
    'Topic',
    'MyPage',
  ];

  static const List _footerIcons = [
    Icons.access_time,
    Icons.textsms,
    Icons.search,
    Icons.wallpaper_sharp,
    Icons.work_outline,
  ];

  void initialize(){
    state.clear();
    state.add(_UpdateActiveState(0));
    for (var i = 1; i < _footerItemNames.length; i++) {
      state.add(_UpdateDeactiveState(i));
    }

  }

  /// インデックスのアイテムをアクティベートする
  BottomNavigationBarItem _UpdateActiveState(int index) {
    return BottomNavigationBarItem(
        icon: Icon(
          _footerIcons[index],
          color: Colors.black87,
        ),
        title: Text(
          _footerItemNames[index],
          style: TextStyle(
            color: Colors.black87,
          ),
        ));
  }

  BottomNavigationBarItem _UpdateDeactiveState(int index) {
    return BottomNavigationBarItem(
        icon: Icon(
          _footerIcons[index],
          color: Colors.black26,
        ),
        title: Text(
          _footerItemNames[index],
          style: TextStyle(
            color: Colors.black26,
          ),
        ));
  }

  void activateButton(int beforeSelectedIndex,int newSelectedIndex) {
    state[beforeSelectedIndex] = _UpdateDeactiveState(beforeSelectedIndex);
    state[newSelectedIndex] = _UpdateActiveState(newSelectedIndex);
  }
}


final _bottomNavigationBarItemsProvider = StateNotifierProvider<BottomNavigationBarItems,List<BottomNavigationBarItem>>((refs) =>BottomNavigationBarItems());

class RootWidget extends ConsumerWidget  {
  Map<String,String>  argumentUserData;
  Map<String, String> argumentMasterData;
  Map<String,Map<String,String>>  argumentFriendData;
  Image? argumentMainPhotoData;


  RootWidget({required this.argumentUserData,required this.argumentMasterData,required this.argumentFriendData, required this.argumentMainPhotoData}) {

  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final bottomNavigationBarItems = ref.watch(_bottomNavigationBarItemsProvider);
    ref.read(_bottomNavigationBarItemsProvider.notifier).initialize();
    final _selectedIndex=ref.watch(_selectedIndexProvider);

    return Scaffold(
      body:
      routeElement(_selectedIndex,argumentUserData["email"]!,argumentUserData["userDocId"]!),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // これを書かないと3つまでしか表示されない
        items: bottomNavigationBarItems,
        currentIndex: _selectedIndex,
        onTap: (int index){

          ref.read(_bottomNavigationBarItemsProvider.notifier).activateButton(_selectedIndex, index);
          ref.read(_selectedIndexProvider.state).update((state) => index);
        }
      ),
    );
  }

  Widget routeElement(int selectedIndex,String email,String userDocId) {
    switch (selectedIndex) {
      case 0:
        return Now(argumentUserData: argumentUserData,
            argumentMasterData:argumentMasterData,
            argumentFriendData:argumentFriendData,
            argumentMainPhotoData:argumentMainPhotoData);
      case 1:
        return Talk(argumentUserData: argumentUserData,
            argumentMasterData:argumentMasterData,
            argumentFriendData:argumentFriendData);
        break;
      case 2:
        return Search(argumentUserData: argumentUserData,
            argumentMasterData:argumentMasterData,
            argumentFriendData:argumentFriendData,
            argumentMainPhotoData:argumentMainPhotoData);
      case 3:
        return Topic(argumentUserData: argumentUserData,
            argumentMasterData:argumentMasterData,
            argumentFriendData:argumentFriendData,
            argumentMainPhotoData:argumentMainPhotoData);
      default:
        return MyPage(argumentUserData: argumentUserData,
            argumentMasterData:argumentMasterData,
            argumentFriendData:argumentFriendData,
            argumentMainPhotoData:argumentMainPhotoData);
        break;
        //return JoinChannelVideo();

    }
  }
}
