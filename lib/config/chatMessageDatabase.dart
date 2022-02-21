import 'package:isar/isar.dart';

part 'chatMessageDatabase.g.dart';

//flutter pub run build_runner build
@Collection()
class ChatMessage {

  ChatMessage(this.chatMessageDocId,
  this.userDocId,
  this.friendUserDocId,
  this.content,
  this.receiveSendType,
  this.messageType,
  this.sendTime,
  this.callChannelId,
  this.fileNameSuffix,
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
  late String chatMessageDocId;
  late String userDocId;
  late String friendUserDocId;
  late String content;
  late String receiveSendType;
  late String messageType;
  late DateTime sendTime;
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