import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:planningkun/routes/topicRegisterEntity.dart';

class TopicRegister extends ConsumerWidget {
  TopicRegister({
    Key? key,
  }) : super(key: key) {
    topicEditingController = new TextEditingController(text: '');
  }

  TextEditingController? topicEditingController;

  Future<void> setImage(WidgetRef ref) async {
    XFile? pickerFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 400,
        maxHeight: 400,
        imageQuality: 40);
    if (pickerFile != null) {
      ref
          .watch(topicImagePhotoFileProvider.notifier)
          .setTopicImagePhotoFile(File(pickerFile.path));
      //TODO 圧縮率などは調整
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final topicName = ref.watch(topicNameProvider);

    return Scaffold(
        body: SafeArea(
            child: Container(
                child: Column(children: [
      Center(
        child: CircleAvatar(
          radius: 80,
          backgroundColor: Colors.white,
          backgroundImage:
              ref.watch(topicImagePhotoFileProvider).topicImagePhotoFile == null
                  ? null
                  : Image.file(ref
                          .watch(topicImagePhotoFileProvider)
                          .topicImagePhotoFile!)
                      .image,
        ),
      ),
      MaterialButton(
          onPressed: () async {
            await setImage(ref);
          },
          child: const Text('写真アップロード') //,
          ),
      TextFormField(
        // テキスト入力のラベルを設定
        decoration: InputDecoration(labelText: "Topic Name"),
        controller: topicEditingController,
        onChanged: (String value) {
          ref.read(topicNameProvider.state).update((state) => value);
        },
      ),
      const SizedBox(height: 8),
      DropdownButton(
        items: ref.watch(categoryItemsProvider).categoryItems,
        value: ref.watch(categoryItemsProvider).selectedCategoryItem,
        onChanged: (value) => {
          ref
              .watch(categoryItemsProvider.notifier)
              .setCategoryItemId(value.toString())
        },
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          color: Colors.orangeAccent,
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            style: ButtonStyle(),
            onPressed: () async {
              if (await checkTopicData(context,ref,topicName)) {
                await insertTopic(ref, topicName);
                ref.watch(categoryItemsProvider.notifier)
                    .clearCategoryItemsNotifier();

                ref.read(topicNameProvider.state).update((state) => "");
                topicEditingController = new TextEditingController(text: '');

                ref.watch(topicImagePhotoFileProvider.notifier)
                    .clearTopicImagePhotoFile();

                await showDialog(
                    context: context,
                    builder: (_) => CupertinoAlertDialog(
                          title: Text("Info"),
                          content: Text("data has been inserted"),
                          actions: [
                            CupertinoDialogAction(
                              child: Text('OK'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        ));
              }
            },
            child: Text(
              "Register",
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    ]))));
  }

  Future<bool> checkTopicData(BuildContext context, WidgetRef ref,String topicName) async{

    //画像NULLチェック
    if(ref.watch(topicImagePhotoFileProvider).topicImagePhotoFile == null){
      await showDialog(
          context: context,
          builder: (_) => CupertinoAlertDialog(
        title: Text("Info"),
        content: Text("image is null"),
        actions: [
          CupertinoDialogAction(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ));

      return false;
    }else if(topicName==""){
      await showDialog(
          context: context,
          builder: (_) => CupertinoAlertDialog(
            title: Text("Info"),
            content: Text("topic name is null"),
            actions: [
              CupertinoDialogAction(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          ));

      return false;

    }else{
      return true;
    }

  }
}
