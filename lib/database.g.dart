// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserDataAdapter extends TypeAdapter<UserData> {
  @override
  final int typeId = 0;

  @override
  UserData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserData(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as int,
      fields[4] as int,
      fields[5] as String,
      fields[6] as String,
      fields[7] as String,
      fields[8] as String,
      fields[9] as String,
      fields[10] as String,
      fields[11] as int,
      fields[12] as String,
      fields[13] as String,
      fields[14] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserData obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.userDocId)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.age)
      ..writeByte(4)
      ..write(obj.level)
      ..writeByte(5)
      ..write(obj.occupation)
      ..writeByte(6)
      ..write(obj.nativeLang)
      ..writeByte(7)
      ..write(obj.country)
      ..writeByte(8)
      ..write(obj.town)
      ..writeByte(9)
      ..write(obj.homeCountry)
      ..writeByte(10)
      ..write(obj.homeTown)
      ..writeByte(11)
      ..write(obj.gender)
      ..writeByte(12)
      ..write(obj.placeWannaGo)
      ..writeByte(13)
      ..write(obj.greeting)
      ..writeByte(14)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
