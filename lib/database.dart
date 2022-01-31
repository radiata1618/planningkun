import 'package:hive/hive.dart';

part 'database.g.dart';
//// $ flutter pub run build_runner buildが必要
//そして、このコードをバージョン管理(git)などにも上げると思いますが、その後に生成コマンドを叩くと、ファイルが消せない！とエラーが出ます。
// その場合は、エラーメッセージにも書いてありますが、生成コマンドに--delete-conflicting-outputsオプションを付ければ良いようです。

@HiveType(typeId: 0)
class UserData extends HiveObject {
  @HiveField(0)
  String userDocId;
  @HiveField(1)
  String email;
  @HiveField(2)
  String name;
  @HiveField(3)
  int age;
  @HiveField(4)
  int level;
  @HiveField(5)
  String occupation;
  @HiveField(6)
  String nativeLang;
  @HiveField(7)
  String country;
  @HiveField(8)
  String town;
  @HiveField(9)
  String homeCountry;
  @HiveField(10)
  String homeTown;
  @HiveField(11)
  int gender;
  @HiveField(12)
  String placeWannaGo;
  @HiveField(13)
  String greeting;
  @HiveField(14)
  String description;

  UserData(
      this.userDocId,
      this.email,
      this.name,
      this.age,
      this.level,
      this.occupation,
      this.nativeLang,
      this.country,
      this.town,
      this.homeCountry,
      this.homeTown,
      this.gender,
      this.placeWannaGo,
      this.greeting,
      this.description);
}

/// Boxを内包するクラス
/// Singletonやboxを開くのを非同期で待つのに使う
/// Boxのファイル名を間違えないようにするためにもこれを起点にアクセスすることとする
class RecordModelBox {
  Future<Box> box = Hive.openBox<UserData>('record');

  /// deleteFromDiskをした後はdatabaseが閉じてしまうため、もう一度開くための関数
  Future<void> open() async {
    Box b = await box;
    if (!b.isOpen) {
      box = Hive.openBox<UserData>('record');
    }
  }
}
