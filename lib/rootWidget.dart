import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planningkun/routes/myPage_route.dart';

import 'commonEntity/friendEntity.dart';
import 'commonEntity/masterEntity.dart';
import 'commonEntity/userEntity.dart';
import 'routes/myPage_route.dart';
import 'routes/talk_route.dart';
import 'routes/search_route.dart';
import 'routes/topic_route.dart';
import 'routes/now_route.dart';
import 'commonEntity/commonEntity.dart';
import 'rootWidgetEntity.dart';
import 'dart:core';

final _selectedIndexProvider = StateProvider.autoDispose((ref) {
  return 0;
});

class RootWidget extends ConsumerWidget {
  RootWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    ref.read(bottomNavigationBarItemsProvider.notifier).initialize();
    final _selectedIndex = ref.watch(_selectedIndexProvider);

    return Scaffold(
      body: routeElement(
          _selectedIndex,
          ref.watch(userDataProvider.notifier).userData["email"]!,
          ref.watch(userDataProvider.notifier).userData["userDocId"]!,
          ref),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed, // これを書かないと3つまでしか表示されない
          items: ref.watch(bottomNavigationBarItemsProvider.notifier)
              .bottomNavigationBarItems,
          currentIndex: _selectedIndex,
          //selectedItemColor: Colors.black,
          onTap: (int index) {
            ref.read(bottomNavigationBarItemsProvider.notifier)
                .activateButton(_selectedIndex, index);
            ref.read(_selectedIndexProvider.state).update((state) => index);
          }),
    );
  }

  Widget routeElement(
      int selectedIndex, String email, String userDocId, WidgetRef ref) {
    switch (selectedIndex) {
      case 0:
        return Now();
      case 1:
        return Talk();
      case 2:
        return Search();
      case 3:
        return Topic(
        );
      default:
        return MyPage();

    }
  }
}
