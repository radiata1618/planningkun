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
import 'join_channel_video.dart';
// =============================================

final _selectedIndexProvider = StateProvider.autoDispose((ref) {
  return 0;
});

final _bottomNavigationBarItemsProvider = StateProvider.autoDispose((ref) {

  List<BottomNavigationBarItem>_bottomNavigationBarItems = <BottomNavigationBarItem>[];
  return _bottomNavigationBarItems;
});

class RootWidget extends ConsumerWidget  {
  Map<String,String>  argumentUserData;
  Map<String, String> argumentMasterData;
  Map<String,Map<String,String>>  argumentFriendData;
  Image? argumentMainPhotoData;
  // int _selectedIndex=0;

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

  void _onItemTapped(int index, WidgetRef ref) {

    final _selectedIndex=ref.watch(_selectedIndexProvider);

    ref.watch(_bottomNavigationBarItemsProvider.state).update((state){
      state[_selectedIndex] = _UpdateDeactiveState(_selectedIndex);
      state[index] = _UpdateActiveState(index);
      return state;}  );

    ref.read(_selectedIndexProvider.state).update((state) => index); // 1加算する
  }

  RootWidget({required this.argumentUserData,required this.argumentMasterData,required this.argumentFriendData, required this.argumentMainPhotoData}) {

  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {


    final _selectedIndex=ref.watch(_selectedIndexProvider);

    ref.watch(_bottomNavigationBarItemsProvider.state).update((state){
      state.clear();
      state.add(_UpdateActiveState(0));
      for (var i = 1; i < _footerItemNames.length; i++) {
        state.add(_UpdateDeactiveState(i));
      }
      return state;}  );

    final _bottomNavigationBarItems=ref.watch(_bottomNavigationBarItemsProvider);

    return Scaffold(
      body:
      routeElement(_selectedIndex,argumentUserData["email"]!,argumentUserData["userDocId"]!),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // これを書かないと3つまでしか表示されない
        items: _bottomNavigationBarItems,
        currentIndex: _selectedIndex,
        onTap: (int index){ _onItemTapped(index,ref);
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
