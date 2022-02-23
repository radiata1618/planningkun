import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import '../config/categoryDatabase.dart';


class EditInterest extends ConsumerWidget {
  EditInterest({
    Key? key,
  }) : super(key: key);

  bool initialProcessFlg=true;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Scaffold(
        body: SafeArea(
            child: Container(
                child:categoriesBody(context)
            )
        )
    );
  }

  Widget categoriesBody(BuildContext context) {
    // return Text(CategoryDocId);

    var isarInstance = Isar.getInstance();
    Query<Category>? categoriesDataQuery =
    isarInstance?.categorys.filter().deleteFlgEqualTo(false).build();

    return StreamBuilder<List<Category>>(
      stream: categoriesDataQuery?.watch(initialReturn: true),
      builder: (context, AsyncSnapshot<List<Category>> categoryList) {
        if (!categoryList.hasData) {
          return const Center(
            child: const CircularProgressIndicator(),
          );
        }
        if (categoryList.hasError) {
          return const Text('Something went wrong');
        }
        return ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: ScrollPhysics(),
          children: categoryList.data!.map((Category category) {
            return categoryItemUnit(context,category);
          }).toList(),
        );
      },
    );
  }

  Widget categoryItemUnit(BuildContext context,Category category) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Row(children: [
          //TODO　丸写真でなく、矩形丸角写真にする
          CircleAvatar(radius: 50,
              backgroundImage: Image.memory(category.photoFile).image),
          Text(category.categoryName),
          Checkbox(value: false, onChanged:null)
        ]),
      ),
      onTap:() {
      },
    );
  }

}
