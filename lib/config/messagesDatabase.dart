import 'package:isar/isar.dart';

part 'messagesDatabase.g.dart';

@Collection()
class Messages {
  @Id()
  int? id;
  late String messageDocId;
  late String userDocId;
  late String friendUserDoc;
  late String content;
  late String receiveSendTy;
  late String messageType;
  late String sendTime;
  late String callChannelId;
  late String fileNameSuffix;
  late String insertUserDocId;
  late String insertProgramId;
  late DateTime insertTime;
  late String updateUserDocId;
  late String updateProgramId;
  late DateTime updateTime;
  late bool readableFlg;
  late bool deleteFlg;
}