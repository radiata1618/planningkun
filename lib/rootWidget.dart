import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// == 作成したWidget をインポート ==================
import 'routes/home_route.dart';
import 'routes/talk_route.dart';
import 'routes/timeline_route.dart';
import 'routes/map_route.dart';
import 'routes/news_route.dart';
// =============================================

class RootWidget extends StatefulWidget {
  final argumentEmail;

  RootWidget({this.argumentEmail});

  @override
  _RootWidgetState createState() => _RootWidgetState();
}

class _RootWidgetState extends State<RootWidget> {
  int _selectedIndex = 0;
  final _bottomNavigationBarItems = <BottomNavigationBarItem>[];

  static const _footerIcons = [
    Icons.home,
    Icons.textsms,
    Icons.access_time,
    Icons.content_paste,
    Icons.work,
  ];

  static const _footerItemNames = [
    'おすすめ',
    'トーク',
    'カレンダ',
    'Me',
    'マップ',
  ];

  // === 追加部分 ===
  var _routes = [
    Home(),
    Talk(),
    TimeLine(),
    News(),
    Map(),
  ];

  // ==============

  @override
  void initState() {
    super.initState();

    //String email = widget.argumentEmail;
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
      routeElement(_selectedIndex,widget.argumentEmail),
      //Home(),
      //_routes.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // これを書かないと3つまでしか表示されない
        items: _bottomNavigationBarItems,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget routeElement(int selectedIndex,String email) {
    switch (selectedIndex) {
      case 0:
        return Home();
        break;
      case 1:
        return Talk(argumentEmail: email,);
        break;
      case 2:
        return TimeLine();
      case 3:
        return News();
      default:
        return Map();
    }
  }
}
