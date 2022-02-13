import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import 'categoryRegisterEntity.dart';

class CategoryRegister extends ConsumerWidget {
  CategoryRegister({
    Key? key,
  }) : super(key: key) {
    categoryNameEditingController = new TextEditingController(text: '');
  }

  TextEditingController? categoryNameEditingController;

  Future<void> setImage(WidgetRef ref) async {
    XFile? pickerFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 400,
        maxHeight: 400,
        imageQuality: 40);
    if (pickerFile != null) {
      ref
          .watch(categoryImagePhotoFileProvider.notifier)
          .setCategoryImagePhotoFile(File(pickerFile.path));
      //TODO 圧縮率などは調整
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoryName = ref.watch(categoryNameProvider);

    return Scaffold(
        body: SafeArea(
            child: Container(
                child: Column(children: [
      Center(
        child: CircleAvatar(
          radius: 80,
          backgroundColor: Colors.white,
          backgroundImage: ref
                      .watch(categoryImagePhotoFileProvider)
                      .categoryImagePhotoFile ==
                  null
              ? null
              : Image.file(ref
                      .watch(categoryImagePhotoFileProvider)
                      .categoryImagePhotoFile!)
                  .image,
        ),
      ),
      MaterialButton(
          onPressed: () async {
            await setImage(ref);
          },
          child: const Text('写真アップロード') //,
          ),
      const SizedBox(height: 8),
      TextFormField(
        decoration: InputDecoration(labelText: "Category Name"),
        controller: categoryNameEditingController,
        onChanged: (String value) {
          ref.read(categoryNameProvider.state).update((state) => value);
        },
      ),
      const SizedBox(height: 8),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          color: Colors.orangeAccent,
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            style: ButtonStyle(),
            onPressed: () async {
              if (await checkCategoryData(context, ref, categoryName)) {
                await insertCategory(ref, categoryName);

                ref.read(categoryNameProvider.state).update((state) => "");
                categoryNameEditingController = new TextEditingController(text: '');

                ref.watch(categoryImagePhotoFileProvider.notifier)
                    .clearCategoryImagePhotoFile();

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

  Future<bool> checkCategoryData(BuildContext context, WidgetRef ref,String categoryName) async{

    //画像NULLチェック
    if(ref.watch(categoryImagePhotoFileProvider).categoryImagePhotoFile == null){
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
    }else if(categoryName==""){
      await showDialog(
          context: context,
          builder: (_) => CupertinoAlertDialog(
            title: Text("Info"),
            content: Text("category name is null"),
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
