import 'dart:typed_data';
import 'dart:ui';

import 'package:isar/isar.dart';

part 'countryDatabase.g.dart';

//flutter pub run build_runner build
@Collection()
class Country {

  Country(this.countryDocId,
      this.countryName,
      this.countryCode,
      this.imageFile,
      this.imageNameSuffix,
      this.imageUpdateCnt,
      this.insertUserDocId,
      this.insertProgramId,
      this.insertTime,
      this.updateUserDocId,
      this.updateProgramId,
      this.updateTime,
      this.readableFlg,
      this.deleteFlg
      );

  @Id()
  int id = Isar.autoIncrement;
  late String countryDocId;
  late String countryName;
  late String countryCode;
  late Uint8List imageFile;
  late String imageNameSuffix;
  late int imageUpdateCnt;
  late String insertUserDocId;
  late String insertProgramId;
  late DateTime insertTime;
  late String updateUserDocId;
  late String updateProgramId;
  late DateTime updateTime;
  late bool readableFlg;
  late bool deleteFlg;
}