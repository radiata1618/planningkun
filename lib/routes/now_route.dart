import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';
import 'now_routeEntity.dart';


class Now extends ConsumerWidget {
  Now({
    Key? key,
  }) : super(key: key);

  bool initialProcessFlg=true;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if(initialProcessFlg){
      initialProcessFlg=false;
      ref.watch(nowImageDataProvider.notifier).initialize();
    }
    return Scaffold(
        body: SafeArea(
            child: Container(
                child:ref.watch(nowImageDataProvider).bytes==null
                ?null
                :Image.memory(ref.watch(nowImageDataProvider).bytes!)
            )
        )
    );
  }
}
