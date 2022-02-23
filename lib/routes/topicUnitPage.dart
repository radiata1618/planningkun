import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planningkun/config/topicDatabase.dart';

class TopicUnitPage extends ConsumerWidget {
  TopicUnitPage({
    required this.argumentTopic,
    Key? key,
  }) : super(key: key);
  Topic argumentTopic;


  double screenHeight = 1;
  double screenWidth = 1;
  double screenAdjustSizeH = 1;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    screenAdjustSizeH = MediaQuery
        .of(context)
        .size
        .height * 0.0011;

    return Scaffold(
        body: SafeArea(
            child: Column(children: [
              Image.memory(argumentTopic.photoFile),

            ])));
  }
}