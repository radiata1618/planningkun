import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import '../config/topicDatabase.dart';
import 'dart:io';

class TopicPage extends ConsumerWidget {
  TopicPage({
    Key? key,
  }) : super(key: key) {
    //コンストラクタ
  }

  double screenHeight=1;
  double screenWidth=1;
  double screenAdjustSizeH=1;

  Widget build(BuildContext context, WidgetRef ref) {

    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    screenAdjustSizeH = MediaQuery.of(context).size.height * 0.0011;

    return Scaffold(
        body: SafeArea(
            child: Column(children: [
      upperButtonsSlide(),
    ])));
  }
}

Widget upperButtonsSlide() {
  return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              upperButtonUnit(categoryName: 'Top', icon: Icons.vpn_lock),
              upperButtonUnit(categoryName: 'sports', icon: Icons.accessibility_new_rounded),
              upperButtonUnit(categoryName: 'drink', icon: Icons.wine_bar_sharp),
              upperButtonUnit(categoryName: 'travel', icon: Icons.airplanemode_active),
              upperButtonUnit(categoryName: 'art', icon: Icons.add_photo_alternate_outlined),
              upperButtonUnit(categoryName: 'food', icon: Icons.wine_bar_sharp),
            ],
          )));
}

Widget upperButtonUnit({required String categoryName, required IconData icon}) {
  return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          height: 40,
          width: 50,
          child: Column(
            children: [Icon(icon), Text(categoryName)],
          )));
}

Widget topicsBody(String CategoryDocId){

  var isarInstance = Isar.getInstance();
  Query<Topic>? topicsDataQuery = isarInstance?.topics.filter()
      .categoryDocIdEqualTo(CategoryDocId)
      .build();
  return StreamBuilder<List<Topic>>(
    stream: topicsDataQuery?.watch(initialReturn: true),
    builder: (context, AsyncSnapshot<List<Topic>> topicList) {
      if (!topicList.hasData) {
        return const Center(
          child: const CircularProgressIndicator(),
        );
      }
      if (topicList.hasError) {
        return const Text('Something went wrong');
      }
      return GridView(
        shrinkWrap: true, //エラー対策
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, //カラム数
        ),
        children: topicList.data!.map((Topic topic) {
          return topicItemUnit(topic);
        }).toList(),
      );
    },
  );
}

Widget topicItemUnit(Topic topic){

  return Column(
    children:[
      Image.file(File.fromRawPath(topic.photoFile)),
      Text(topic.topicName)
    ]
  );
}