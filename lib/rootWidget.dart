import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// == 作成したWidget をインポート ==================
import 'routes/home_route.dart';
import 'routes/talk_route.dart';
import 'routes/search_route.dart';
import 'routes/mapPage_route.dart';
import 'routes/setting_route.dart';
import 'common.dart';
import 'dart:core';
// =============================================

class RootWidget extends StatefulWidget {
  Map<String,String>  argumentUserData;
  Map<String, String> argumentMasterData;
  Map<String, String> argumentFriendData;


  RootWidget({required this.argumentUserData,required this.argumentMasterData,required this.argumentFriendData});

  @override
  _RootWidgetState createState() => _RootWidgetState();
}

class _RootWidgetState extends State<RootWidget> {
  int _selectedIndex = 0;
  final _bottomNavigationBarItems = <BottomNavigationBarItem>[];

  static const _footerIcons = [
    Icons.home,
    Icons.textsms,
    Icons.search,
    Icons.content_paste,
    Icons.work,
  ];

  static const _footerItemNames = [
    'おすすめ',
    'トーク',
    'Search',
    'Me',
    'マップ',
  ];


  @override
  void initState() {
    super.initState();

    _bottomNavigationBarItems.add(_UpdateActiveState(0));
    for (var i = 1; i < _footerItemNames.length; i++) {
      _bottomNavigationBarItems.add(_UpdateDeactiveState(i));
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

  void _onItemTapped(int index) {
    setState(() {
      _bottomNavigationBarItems[_selectedIndex] =
          _UpdateDeactiveState(_selectedIndex);
      _bottomNavigationBarItems[index] = _UpdateActiveState(index);
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      routeElement(_selectedIndex,widget.argumentUserData["email"]!,widget.argumentUserData["userDocId"]!),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // これを書かないと3つまでしか表示されない
        items: _bottomNavigationBarItems,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget routeElement(int selectedIndex,String email,String userDocId) {
    switch (selectedIndex) {
      case 0:
        return Home();
        break;
      case 1:
        return Talk(argumentUserData: widget.argumentUserData,
            argumentMasterData:widget.argumentMasterData,
            argumentFriendData:widget.argumentFriendData);
        break;
      case 2:
        return Search(argumentUserData: widget.argumentUserData,
            argumentMasterData:widget.argumentMasterData,
            argumentFriendData:widget.argumentFriendData);
      case 3:
        return Setting(argumentUserData: widget.argumentUserData,
            argumentMasterData:widget.argumentMasterData,
            argumentFriendData:widget.argumentFriendData);
      default:
        return MapPage();
    }
  }
}
