import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:planningkun/routes/topicRoot_routeEntity.dart';
import '../config/topicDatabase.dart';
import 'dart:io';

class TopicPage extends ConsumerWidget {
  TopicPage({
    Key? key,
  }) : super(key: key) {
    //コンストラクタ
  }

  double screenHeight = 1;
  double screenWidth = 1;
  double screenAdjustSizeH = 1;

  Widget build(BuildContext context, WidgetRef ref) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    screenAdjustSizeH = MediaQuery.of(context).size.height * 0.0011;

    if(ref.watch(topicPageDataProvider).upperButtonsList.length==0){
      ref.read(topicPageDataProvider.notifier).initialize(ref);
    }

    return Scaffold(
        body: SafeArea(
            child: Column(children: [
      upperButtonsSlide(ref),
              topicsBody(ref.watch(topicPageDataProvider).categoryId)
    ])));
  }

  Widget upperButtonsSlide(WidgetRef ref) {

    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: ref.watch(topicPageDataProvider).upperButtonsList
            )));
  }



  Widget topicsBody(String CategoryDocId) {
    // return Text(CategoryDocId);

    var isarInstance = Isar.getInstance();
    Query<Topic>? topicsDataQuery =
    isarInstance?.topics.filter().categoryDocIdEqualTo(CategoryDocId).build();

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

  Widget topicItemUnit(Topic topic) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:0),
      child: Column(children: [
      //   ClipRRect(
      // clipper:new CustomClipper()
      //       borderRadius: BorderRadius.circular(8.0),
      //       child:Image.memory(topic.photoFile)
      //   ),
      //   ClipRRect(child:Container(
      //     width: 110.0,
      //     height: 110.0,
      //     decoration: BoxDecoration(
      //         shape: BoxShape.rectangle,
      //         image: DecorationImage(
      //             fit: BoxFit.fill,
      //             image: Image.memory(topic.photoFile).image
      //         )
      //     ),
      //   ),),
        // ClipRect(
        //   child: Align(
        //     alignment: Alignment.center,
        //     heightFactor: 0.8,
        //     widthFactor: 0.8,
        //     child: Image.memory(topic.photoFile)
        //   ),
        // ),
        CircleAvatar(radius: 55*screenAdjustSizeH,
            backgroundImage: Image.memory(topic.photoFile).image),
        Text(topic.topicName)
      ]),
    );
  }

}
