// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chatMessageDatabase.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast

extension GetChatMessageCollection on Isar {
  IsarCollection<ChatMessage> get chatMessages {
    return getCollection('ChatMessage');
  }
}

final ChatMessageSchema = CollectionSchema(
  name: 'ChatMessage',
  schema:
      '{"name":"ChatMessage","idName":"id","properties":[{"name":"callChannelId","type":"String"},{"name":"chatMessageDocId","type":"String"},{"name":"content","type":"String"},{"name":"deleteFlg","type":"Bool"},{"name":"fileNameSuffix","type":"String"},{"name":"friendUserDocId","type":"String"},{"name":"insertProgramId","type":"String"},{"name":"insertTime","type":"Long"},{"name":"insertUserDocId","type":"String"},{"name":"messageType","type":"String"},{"name":"readableFlg","type":"Bool"},{"name":"receiveSendType","type":"String"},{"name":"sendTime","type":"Long"},{"name":"updateProgramId","type":"String"},{"name":"updateTime","type":"Long"},{"name":"updateUserDocId","type":"String"},{"name":"userDocId","type":"String"}],"indexes":[],"links":[]}',
  nativeAdapter: const _ChatMessageNativeAdapter(),
  webAdapter: const _ChatMessageWebAdapter(),
  idName: 'id',
  propertyIds: {
    'callChannelId': 0,
    'chatMessageDocId': 1,
    'content': 2,
    'deleteFlg': 3,
    'fileNameSuffix': 4,
    'friendUserDocId': 5,
    'insertProgramId': 6,
    'insertTime': 7,
    'insertUserDocId': 8,
    'messageType': 9,
    'readableFlg': 10,
    'receiveSendType': 11,
    'sendTime': 12,
    'updateProgramId': 13,
    'updateTime': 14,
    'updateUserDocId': 15,
    'userDocId': 16
  },
  listProperties: {},
  indexIds: {},
  indexTypes: {},
  linkIds: {},
  backlinkIds: {},
  linkedCollections: [],
  getId: (obj) {
    if (obj.id == Isar.autoIncrement) {
      return null;
    } else {
      return obj.id;
    }
  },
  setId: (obj, id) => obj.id = id,
  getLinks: (obj) => [],
  version: 2,
);

class _ChatMessageWebAdapter extends IsarWebTypeAdapter<ChatMessage> {
  const _ChatMessageWebAdapter();

  @override
  Object serialize(IsarCollection<ChatMessage> collection, ChatMessage object) {
    final jsObj = IsarNative.newJsObject();
    IsarNative.jsObjectSet(jsObj, 'callChannelId', object.callChannelId);
    IsarNative.jsObjectSet(jsObj, 'chatMessageDocId', object.chatMessageDocId);
    IsarNative.jsObjectSet(jsObj, 'content', object.content);
    IsarNative.jsObjectSet(jsObj, 'deleteFlg', object.deleteFlg);
    IsarNative.jsObjectSet(jsObj, 'fileNameSuffix', object.fileNameSuffix);
    IsarNative.jsObjectSet(jsObj, 'friendUserDocId', object.friendUserDocId);
    IsarNative.jsObjectSet(jsObj, 'id', object.id);
    IsarNative.jsObjectSet(jsObj, 'insertProgramId', object.insertProgramId);
    IsarNative.jsObjectSet(
        jsObj, 'insertTime', object.insertTime.toUtc().millisecondsSinceEpoch);
    IsarNative.jsObjectSet(jsObj, 'insertUserDocId', object.insertUserDocId);
    IsarNative.jsObjectSet(jsObj, 'messageType', object.messageType);
    IsarNative.jsObjectSet(jsObj, 'readableFlg', object.readableFlg);
    IsarNative.jsObjectSet(jsObj, 'receiveSendType', object.receiveSendType);
    IsarNative.jsObjectSet(
        jsObj, 'sendTime', object.sendTime.toUtc().millisecondsSinceEpoch);
    IsarNative.jsObjectSet(jsObj, 'updateProgramId', object.updateProgramId);
    IsarNative.jsObjectSet(
        jsObj, 'updateTime', object.updateTime.toUtc().millisecondsSinceEpoch);
    IsarNative.jsObjectSet(jsObj, 'updateUserDocId', object.updateUserDocId);
    IsarNative.jsObjectSet(jsObj, 'userDocId', object.userDocId);
    return jsObj;
  }

  @override
  ChatMessage deserialize(
      IsarCollection<ChatMessage> collection, dynamic jsObj) {
    final object = ChatMessage(
      IsarNative.jsObjectGet(jsObj, 'chatMessageDocId') ?? '',
      IsarNative.jsObjectGet(jsObj, 'userDocId') ?? '',
      IsarNative.jsObjectGet(jsObj, 'friendUserDocId') ?? '',
      IsarNative.jsObjectGet(jsObj, 'content') ?? '',
      IsarNative.jsObjectGet(jsObj, 'receiveSendType') ?? '',
      IsarNative.jsObjectGet(jsObj, 'messageType') ?? '',
      IsarNative.jsObjectGet(jsObj, 'sendTime') != null
          ? DateTime.fromMillisecondsSinceEpoch(
                  IsarNative.jsObjectGet(jsObj, 'sendTime'),
                  isUtc: true)
              .toLocal()
          : DateTime.fromMillisecondsSinceEpoch(0),
      IsarNative.jsObjectGet(jsObj, 'callChannelId') ?? '',
      IsarNative.jsObjectGet(jsObj, 'fileNameSuffix') ?? '',
      IsarNative.jsObjectGet(jsObj, 'insertUserDocId') ?? '',
      IsarNative.jsObjectGet(jsObj, 'insertProgramId') ?? '',
      IsarNative.jsObjectGet(jsObj, 'insertTime') != null
          ? DateTime.fromMillisecondsSinceEpoch(
                  IsarNative.jsObjectGet(jsObj, 'insertTime'),
                  isUtc: true)
              .toLocal()
          : DateTime.fromMillisecondsSinceEpoch(0),
      IsarNative.jsObjectGet(jsObj, 'updateUserDocId') ?? '',
      IsarNative.jsObjectGet(jsObj, 'updateProgramId') ?? '',
      IsarNative.jsObjectGet(jsObj, 'updateTime') != null
          ? DateTime.fromMillisecondsSinceEpoch(
                  IsarNative.jsObjectGet(jsObj, 'updateTime'),
                  isUtc: true)
              .toLocal()
          : DateTime.fromMillisecondsSinceEpoch(0),
      IsarNative.jsObjectGet(jsObj, 'readableFlg') ?? false,
      IsarNative.jsObjectGet(jsObj, 'deleteFlg') ?? false,
    );
    object.id = IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity;
    return object;
  }

  @override
  P deserializeProperty<P>(Object jsObj, String propertyName) {
    switch (propertyName) {
      case 'callChannelId':
        return (IsarNative.jsObjectGet(jsObj, 'callChannelId') ?? '') as P;
      case 'chatMessageDocId':
        return (IsarNative.jsObjectGet(jsObj, 'chatMessageDocId') ?? '') as P;
      case 'content':
        return (IsarNative.jsObjectGet(jsObj, 'content') ?? '') as P;
      case 'deleteFlg':
        return (IsarNative.jsObjectGet(jsObj, 'deleteFlg') ?? false) as P;
      case 'fileNameSuffix':
        return (IsarNative.jsObjectGet(jsObj, 'fileNameSuffix') ?? '') as P;
      case 'friendUserDocId':
        return (IsarNative.jsObjectGet(jsObj, 'friendUserDocId') ?? '') as P;
      case 'id':
        return (IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity)
            as P;
      case 'insertProgramId':
        return (IsarNative.jsObjectGet(jsObj, 'insertProgramId') ?? '') as P;
      case 'insertTime':
        return (IsarNative.jsObjectGet(jsObj, 'insertTime') != null
            ? DateTime.fromMillisecondsSinceEpoch(
                    IsarNative.jsObjectGet(jsObj, 'insertTime'),
                    isUtc: true)
                .toLocal()
            : DateTime.fromMillisecondsSinceEpoch(0)) as P;
      case 'insertUserDocId':
        return (IsarNative.jsObjectGet(jsObj, 'insertUserDocId') ?? '') as P;
      case 'messageType':
        return (IsarNative.jsObjectGet(jsObj, 'messageType') ?? '') as P;
      case 'readableFlg':
        return (IsarNative.jsObjectGet(jsObj, 'readableFlg') ?? false) as P;
      case 'receiveSendType':
        return (IsarNative.jsObjectGet(jsObj, 'receiveSendType') ?? '') as P;
      case 'sendTime':
        return (IsarNative.jsObjectGet(jsObj, 'sendTime') != null
            ? DateTime.fromMillisecondsSinceEpoch(
                    IsarNative.jsObjectGet(jsObj, 'sendTime'),
                    isUtc: true)
                .toLocal()
            : DateTime.fromMillisecondsSinceEpoch(0)) as P;
      case 'updateProgramId':
        return (IsarNative.jsObjectGet(jsObj, 'updateProgramId') ?? '') as P;
      case 'updateTime':
        return (IsarNative.jsObjectGet(jsObj, 'updateTime') != null
            ? DateTime.fromMillisecondsSinceEpoch(
                    IsarNative.jsObjectGet(jsObj, 'updateTime'),
                    isUtc: true)
                .toLocal()
            : DateTime.fromMillisecondsSinceEpoch(0)) as P;
      case 'updateUserDocId':
        return (IsarNative.jsObjectGet(jsObj, 'updateUserDocId') ?? '') as P;
      case 'userDocId':
        return (IsarNative.jsObjectGet(jsObj, 'userDocId') ?? '') as P;
      default:
        throw 'Illegal propertyName';
    }
  }

  @override
  void attachLinks(Isar isar, int id, ChatMessage object) {}
}

class _ChatMessageNativeAdapter extends IsarNativeTypeAdapter<ChatMessage> {
  const _ChatMessageNativeAdapter();

  @override
  void serialize(
      IsarCollection<ChatMessage> collection,
      IsarRawObject rawObj,
      ChatMessage object,
      int staticSize,
      List<int> offsets,
      AdapterAlloc alloc) {
    var dynamicSize = 0;
    final value0 = object.callChannelId;
    final _callChannelId = IsarBinaryWriter.utf8Encoder.convert(value0);
    dynamicSize += (_callChannelId.length) as int;
    final value1 = object.chatMessageDocId;
    final _chatMessageDocId = IsarBinaryWriter.utf8Encoder.convert(value1);
    dynamicSize += (_chatMessageDocId.length) as int;
    final value2 = object.content;
    final _content = IsarBinaryWriter.utf8Encoder.convert(value2);
    dynamicSize += (_content.length) as int;
    final value3 = object.deleteFlg;
    final _deleteFlg = value3;
    final value4 = object.fileNameSuffix;
    final _fileNameSuffix = IsarBinaryWriter.utf8Encoder.convert(value4);
    dynamicSize += (_fileNameSuffix.length) as int;
    final value5 = object.friendUserDocId;
    final _friendUserDocId = IsarBinaryWriter.utf8Encoder.convert(value5);
    dynamicSize += (_friendUserDocId.length) as int;
    final value6 = object.insertProgramId;
    final _insertProgramId = IsarBinaryWriter.utf8Encoder.convert(value6);
    dynamicSize += (_insertProgramId.length) as int;
    final value7 = object.insertTime;
    final _insertTime = value7;
    final value8 = object.insertUserDocId;
    final _insertUserDocId = IsarBinaryWriter.utf8Encoder.convert(value8);
    dynamicSize += (_insertUserDocId.length) as int;
    final value9 = object.messageType;
    final _messageType = IsarBinaryWriter.utf8Encoder.convert(value9);
    dynamicSize += (_messageType.length) as int;
    final value10 = object.readableFlg;
    final _readableFlg = value10;
    final value11 = object.receiveSendType;
    final _receiveSendType = IsarBinaryWriter.utf8Encoder.convert(value11);
    dynamicSize += (_receiveSendType.length) as int;
    final value12 = object.sendTime;
    final _sendTime = value12;
    final value13 = object.updateProgramId;
    final _updateProgramId = IsarBinaryWriter.utf8Encoder.convert(value13);
    dynamicSize += (_updateProgramId.length) as int;
    final value14 = object.updateTime;
    final _updateTime = value14;
    final value15 = object.updateUserDocId;
    final _updateUserDocId = IsarBinaryWriter.utf8Encoder.convert(value15);
    dynamicSize += (_updateUserDocId.length) as int;
    final value16 = object.userDocId;
    final _userDocId = IsarBinaryWriter.utf8Encoder.convert(value16);
    dynamicSize += (_userDocId.length) as int;
    final size = staticSize + dynamicSize;

    rawObj.buffer = alloc(size);
    rawObj.buffer_length = size;
    final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
    final writer = IsarBinaryWriter(buffer, staticSize);
    writer.writeBytes(offsets[0], _callChannelId);
    writer.writeBytes(offsets[1], _chatMessageDocId);
    writer.writeBytes(offsets[2], _content);
    writer.writeBool(offsets[3], _deleteFlg);
    writer.writeBytes(offsets[4], _fileNameSuffix);
    writer.writeBytes(offsets[5], _friendUserDocId);
    writer.writeBytes(offsets[6], _insertProgramId);
    writer.writeDateTime(offsets[7], _insertTime);
    writer.writeBytes(offsets[8], _insertUserDocId);
    writer.writeBytes(offsets[9], _messageType);
    writer.writeBool(offsets[10], _readableFlg);
    writer.writeBytes(offsets[11], _receiveSendType);
    writer.writeDateTime(offsets[12], _sendTime);
    writer.writeBytes(offsets[13], _updateProgramId);
    writer.writeDateTime(offsets[14], _updateTime);
    writer.writeBytes(offsets[15], _updateUserDocId);
    writer.writeBytes(offsets[16], _userDocId);
  }

  @override
  ChatMessage deserialize(IsarCollection<ChatMessage> collection, int id,
      IsarBinaryReader reader, List<int> offsets) {
    final object = ChatMessage(
      reader.readString(offsets[1]),
      reader.readString(offsets[16]),
      reader.readString(offsets[5]),
      reader.readString(offsets[2]),
      reader.readString(offsets[11]),
      reader.readString(offsets[9]),
      reader.readDateTime(offsets[12]),
      reader.readString(offsets[0]),
      reader.readString(offsets[4]),
      reader.readString(offsets[8]),
      reader.readString(offsets[6]),
      reader.readDateTime(offsets[7]),
      reader.readString(offsets[15]),
      reader.readString(offsets[13]),
      reader.readDateTime(offsets[14]),
      reader.readBool(offsets[10]),
      reader.readBool(offsets[3]),
    );
    object.id = id;
    return object;
  }

  @override
  P deserializeProperty<P>(
      int id, IsarBinaryReader reader, int propertyIndex, int offset) {
    switch (propertyIndex) {
      case -1:
        return id as P;
      case 0:
        return (reader.readString(offset)) as P;
      case 1:
        return (reader.readString(offset)) as P;
      case 2:
        return (reader.readString(offset)) as P;
      case 3:
        return (reader.readBool(offset)) as P;
      case 4:
        return (reader.readString(offset)) as P;
      case 5:
        return (reader.readString(offset)) as P;
      case 6:
        return (reader.readString(offset)) as P;
      case 7:
        return (reader.readDateTime(offset)) as P;
      case 8:
        return (reader.readString(offset)) as P;
      case 9:
        return (reader.readString(offset)) as P;
      case 10:
        return (reader.readBool(offset)) as P;
      case 11:
        return (reader.readString(offset)) as P;
      case 12:
        return (reader.readDateTime(offset)) as P;
      case 13:
        return (reader.readString(offset)) as P;
      case 14:
        return (reader.readDateTime(offset)) as P;
      case 15:
        return (reader.readString(offset)) as P;
      case 16:
        return (reader.readString(offset)) as P;
      default:
        throw 'Illegal propertyIndex';
    }
  }

  @override
  void attachLinks(Isar isar, int id, ChatMessage object) {}
}

extension ChatMessageQueryWhereSort
    on QueryBuilder<ChatMessage, ChatMessage, QWhere> {
  QueryBuilder<ChatMessage, ChatMessage, QAfterWhere> anyId() {
    return addWhereClauseInternal(const WhereClause(indexName: null));
  }
}

extension ChatMessageQueryWhere
    on QueryBuilder<ChatMessage, ChatMessage, QWhereClause> {
  QueryBuilder<ChatMessage, ChatMessage, QAfterWhereClause> idEqualTo(int id) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [id],
      includeLower: true,
      upper: [id],
      includeUpper: true,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterWhereClause> idNotEqualTo(
      int id) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(WhereClause(
        indexName: null,
        upper: [id],
        includeUpper: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: null,
        lower: [id],
        includeLower: false,
      ));
    } else {
      return addWhereClauseInternal(WhereClause(
        indexName: null,
        lower: [id],
        includeLower: false,
      )).addWhereClauseInternal(WhereClause(
        indexName: null,
        upper: [id],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterWhereClause> idGreaterThan(
    int id, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [id],
      includeLower: include,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterWhereClause> idLessThan(
    int id, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      upper: [id],
      includeUpper: include,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterWhereClause> idBetween(
    int lowerId,
    int upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [lowerId],
      includeLower: includeLower,
      upper: [upperId],
      includeUpper: includeUpper,
    ));
  }
}

extension ChatMessageQueryFilter
    on QueryBuilder<ChatMessage, ChatMessage, QFilterCondition> {
  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      callChannelIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'callChannelId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      callChannelIdGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'callChannelId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      callChannelIdLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'callChannelId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      callChannelIdBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'callChannelId',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      callChannelIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'callChannelId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      callChannelIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'callChannelId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      callChannelIdContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'callChannelId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      callChannelIdMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'callChannelId',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      chatMessageDocIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'chatMessageDocId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      chatMessageDocIdGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'chatMessageDocId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      chatMessageDocIdLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'chatMessageDocId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      chatMessageDocIdBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'chatMessageDocId',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      chatMessageDocIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'chatMessageDocId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      chatMessageDocIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'chatMessageDocId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      chatMessageDocIdContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'chatMessageDocId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      chatMessageDocIdMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'chatMessageDocId',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition> contentEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'content',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      contentGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'content',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition> contentLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'content',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition> contentBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'content',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      contentStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'content',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition> contentEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'content',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition> contentContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'content',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition> contentMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'content',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      deleteFlgEqualTo(bool value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'deleteFlg',
      value: value,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      fileNameSuffixEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'fileNameSuffix',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      fileNameSuffixGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'fileNameSuffix',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      fileNameSuffixLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'fileNameSuffix',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      fileNameSuffixBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'fileNameSuffix',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      fileNameSuffixStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'fileNameSuffix',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      fileNameSuffixEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'fileNameSuffix',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      fileNameSuffixContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'fileNameSuffix',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      fileNameSuffixMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'fileNameSuffix',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      friendUserDocIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'friendUserDocId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      friendUserDocIdGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'friendUserDocId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      friendUserDocIdLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'friendUserDocId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      friendUserDocIdBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'friendUserDocId',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      friendUserDocIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'friendUserDocId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      friendUserDocIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'friendUserDocId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      friendUserDocIdContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'friendUserDocId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      friendUserDocIdMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'friendUserDocId',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition> idEqualTo(
      int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition> idGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition> idLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition> idBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'id',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      insertProgramIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'insertProgramId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      insertProgramIdGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'insertProgramId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      insertProgramIdLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'insertProgramId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      insertProgramIdBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'insertProgramId',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      insertProgramIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'insertProgramId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      insertProgramIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'insertProgramId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      insertProgramIdContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'insertProgramId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      insertProgramIdMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'insertProgramId',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      insertTimeEqualTo(DateTime value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'insertTime',
      value: value,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      insertTimeGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'insertTime',
      value: value,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      insertTimeLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'insertTime',
      value: value,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      insertTimeBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'insertTime',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      insertUserDocIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'insertUserDocId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      insertUserDocIdGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'insertUserDocId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      insertUserDocIdLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'insertUserDocId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      insertUserDocIdBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'insertUserDocId',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      insertUserDocIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'insertUserDocId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      insertUserDocIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'insertUserDocId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      insertUserDocIdContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'insertUserDocId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      insertUserDocIdMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'insertUserDocId',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      messageTypeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'messageType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      messageTypeGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'messageType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      messageTypeLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'messageType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      messageTypeBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'messageType',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      messageTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'messageType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      messageTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'messageType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      messageTypeContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'messageType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      messageTypeMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'messageType',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      readableFlgEqualTo(bool value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'readableFlg',
      value: value,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      receiveSendTypeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'receiveSendType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      receiveSendTypeGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'receiveSendType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      receiveSendTypeLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'receiveSendType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      receiveSendTypeBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'receiveSendType',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      receiveSendTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'receiveSendType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      receiveSendTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'receiveSendType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      receiveSendTypeContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'receiveSendType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      receiveSendTypeMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'receiveSendType',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition> sendTimeEqualTo(
      DateTime value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'sendTime',
      value: value,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      sendTimeGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'sendTime',
      value: value,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      sendTimeLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'sendTime',
      value: value,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition> sendTimeBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'sendTime',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      updateProgramIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'updateProgramId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      updateProgramIdGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'updateProgramId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      updateProgramIdLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'updateProgramId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      updateProgramIdBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'updateProgramId',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      updateProgramIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'updateProgramId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      updateProgramIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'updateProgramId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      updateProgramIdContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'updateProgramId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      updateProgramIdMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'updateProgramId',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      updateTimeEqualTo(DateTime value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'updateTime',
      value: value,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      updateTimeGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'updateTime',
      value: value,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      updateTimeLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'updateTime',
      value: value,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      updateTimeBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'updateTime',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      updateUserDocIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'updateUserDocId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      updateUserDocIdGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'updateUserDocId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      updateUserDocIdLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'updateUserDocId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      updateUserDocIdBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'updateUserDocId',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      updateUserDocIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'updateUserDocId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      updateUserDocIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'updateUserDocId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      updateUserDocIdContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'updateUserDocId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      updateUserDocIdMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'updateUserDocId',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      userDocIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'userDocId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      userDocIdGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'userDocId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      userDocIdLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'userDocId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      userDocIdBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'userDocId',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      userDocIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'userDocId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      userDocIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'userDocId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      userDocIdContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'userDocId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      userDocIdMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'userDocId',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }
}

extension ChatMessageQueryLinks
    on QueryBuilder<ChatMessage, ChatMessage, QFilterCondition> {}

extension ChatMessageQueryWhereSortBy
    on QueryBuilder<ChatMessage, ChatMessage, QSortBy> {
  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> sortByCallChannelId() {
    return addSortByInternal('callChannelId', Sort.asc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy>
      sortByCallChannelIdDesc() {
    return addSortByInternal('callChannelId', Sort.desc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy>
      sortByChatMessageDocId() {
    return addSortByInternal('chatMessageDocId', Sort.asc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy>
      sortByChatMessageDocIdDesc() {
    return addSortByInternal('chatMessageDocId', Sort.desc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> sortByContent() {
    return addSortByInternal('content', Sort.asc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> sortByContentDesc() {
    return addSortByInternal('content', Sort.desc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> sortByDeleteFlg() {
    return addSortByInternal('deleteFlg', Sort.asc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> sortByDeleteFlgDesc() {
    return addSortByInternal('deleteFlg', Sort.desc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> sortByFileNameSuffix() {
    return addSortByInternal('fileNameSuffix', Sort.asc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy>
      sortByFileNameSuffixDesc() {
    return addSortByInternal('fileNameSuffix', Sort.desc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> sortByFriendUserDocId() {
    return addSortByInternal('friendUserDocId', Sort.asc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy>
      sortByFriendUserDocIdDesc() {
    return addSortByInternal('friendUserDocId', Sort.desc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> sortByInsertProgramId() {
    return addSortByInternal('insertProgramId', Sort.asc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy>
      sortByInsertProgramIdDesc() {
    return addSortByInternal('insertProgramId', Sort.desc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> sortByInsertTime() {
    return addSortByInternal('insertTime', Sort.asc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> sortByInsertTimeDesc() {
    return addSortByInternal('insertTime', Sort.desc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> sortByInsertUserDocId() {
    return addSortByInternal('insertUserDocId', Sort.asc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy>
      sortByInsertUserDocIdDesc() {
    return addSortByInternal('insertUserDocId', Sort.desc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> sortByMessageType() {
    return addSortByInternal('messageType', Sort.asc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> sortByMessageTypeDesc() {
    return addSortByInternal('messageType', Sort.desc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> sortByReadableFlg() {
    return addSortByInternal('readableFlg', Sort.asc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> sortByReadableFlgDesc() {
    return addSortByInternal('readableFlg', Sort.desc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> sortByReceiveSendType() {
    return addSortByInternal('receiveSendType', Sort.asc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy>
      sortByReceiveSendTypeDesc() {
    return addSortByInternal('receiveSendType', Sort.desc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> sortBySendTime() {
    return addSortByInternal('sendTime', Sort.asc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> sortBySendTimeDesc() {
    return addSortByInternal('sendTime', Sort.desc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> sortByUpdateProgramId() {
    return addSortByInternal('updateProgramId', Sort.asc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy>
      sortByUpdateProgramIdDesc() {
    return addSortByInternal('updateProgramId', Sort.desc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> sortByUpdateTime() {
    return addSortByInternal('updateTime', Sort.asc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> sortByUpdateTimeDesc() {
    return addSortByInternal('updateTime', Sort.desc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> sortByUpdateUserDocId() {
    return addSortByInternal('updateUserDocId', Sort.asc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy>
      sortByUpdateUserDocIdDesc() {
    return addSortByInternal('updateUserDocId', Sort.desc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> sortByUserDocId() {
    return addSortByInternal('userDocId', Sort.asc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> sortByUserDocIdDesc() {
    return addSortByInternal('userDocId', Sort.desc);
  }
}

extension ChatMessageQueryWhereSortThenBy
    on QueryBuilder<ChatMessage, ChatMessage, QSortThenBy> {
  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> thenByCallChannelId() {
    return addSortByInternal('callChannelId', Sort.asc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy>
      thenByCallChannelIdDesc() {
    return addSortByInternal('callChannelId', Sort.desc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy>
      thenByChatMessageDocId() {
    return addSortByInternal('chatMessageDocId', Sort.asc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy>
      thenByChatMessageDocIdDesc() {
    return addSortByInternal('chatMessageDocId', Sort.desc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> thenByContent() {
    return addSortByInternal('content', Sort.asc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> thenByContentDesc() {
    return addSortByInternal('content', Sort.desc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> thenByDeleteFlg() {
    return addSortByInternal('deleteFlg', Sort.asc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> thenByDeleteFlgDesc() {
    return addSortByInternal('deleteFlg', Sort.desc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> thenByFileNameSuffix() {
    return addSortByInternal('fileNameSuffix', Sort.asc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy>
      thenByFileNameSuffixDesc() {
    return addSortByInternal('fileNameSuffix', Sort.desc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> thenByFriendUserDocId() {
    return addSortByInternal('friendUserDocId', Sort.asc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy>
      thenByFriendUserDocIdDesc() {
    return addSortByInternal('friendUserDocId', Sort.desc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> thenByInsertProgramId() {
    return addSortByInternal('insertProgramId', Sort.asc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy>
      thenByInsertProgramIdDesc() {
    return addSortByInternal('insertProgramId', Sort.desc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> thenByInsertTime() {
    return addSortByInternal('insertTime', Sort.asc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> thenByInsertTimeDesc() {
    return addSortByInternal('insertTime', Sort.desc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> thenByInsertUserDocId() {
    return addSortByInternal('insertUserDocId', Sort.asc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy>
      thenByInsertUserDocIdDesc() {
    return addSortByInternal('insertUserDocId', Sort.desc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> thenByMessageType() {
    return addSortByInternal('messageType', Sort.asc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> thenByMessageTypeDesc() {
    return addSortByInternal('messageType', Sort.desc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> thenByReadableFlg() {
    return addSortByInternal('readableFlg', Sort.asc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> thenByReadableFlgDesc() {
    return addSortByInternal('readableFlg', Sort.desc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> thenByReceiveSendType() {
    return addSortByInternal('receiveSendType', Sort.asc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy>
      thenByReceiveSendTypeDesc() {
    return addSortByInternal('receiveSendType', Sort.desc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> thenBySendTime() {
    return addSortByInternal('sendTime', Sort.asc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> thenBySendTimeDesc() {
    return addSortByInternal('sendTime', Sort.desc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> thenByUpdateProgramId() {
    return addSortByInternal('updateProgramId', Sort.asc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy>
      thenByUpdateProgramIdDesc() {
    return addSortByInternal('updateProgramId', Sort.desc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> thenByUpdateTime() {
    return addSortByInternal('updateTime', Sort.asc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> thenByUpdateTimeDesc() {
    return addSortByInternal('updateTime', Sort.desc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> thenByUpdateUserDocId() {
    return addSortByInternal('updateUserDocId', Sort.asc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy>
      thenByUpdateUserDocIdDesc() {
    return addSortByInternal('updateUserDocId', Sort.desc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> thenByUserDocId() {
    return addSortByInternal('userDocId', Sort.asc);
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> thenByUserDocIdDesc() {
    return addSortByInternal('userDocId', Sort.desc);
  }
}

extension ChatMessageQueryWhereDistinct
    on QueryBuilder<ChatMessage, ChatMessage, QDistinct> {
  QueryBuilder<ChatMessage, ChatMessage, QDistinct> distinctByCallChannelId(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('callChannelId', caseSensitive: caseSensitive);
  }

  QueryBuilder<ChatMessage, ChatMessage, QDistinct> distinctByChatMessageDocId(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('chatMessageDocId',
        caseSensitive: caseSensitive);
  }

  QueryBuilder<ChatMessage, ChatMessage, QDistinct> distinctByContent(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('content', caseSensitive: caseSensitive);
  }

  QueryBuilder<ChatMessage, ChatMessage, QDistinct> distinctByDeleteFlg() {
    return addDistinctByInternal('deleteFlg');
  }

  QueryBuilder<ChatMessage, ChatMessage, QDistinct> distinctByFileNameSuffix(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('fileNameSuffix',
        caseSensitive: caseSensitive);
  }

  QueryBuilder<ChatMessage, ChatMessage, QDistinct> distinctByFriendUserDocId(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('friendUserDocId',
        caseSensitive: caseSensitive);
  }

  QueryBuilder<ChatMessage, ChatMessage, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<ChatMessage, ChatMessage, QDistinct> distinctByInsertProgramId(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('insertProgramId',
        caseSensitive: caseSensitive);
  }

  QueryBuilder<ChatMessage, ChatMessage, QDistinct> distinctByInsertTime() {
    return addDistinctByInternal('insertTime');
  }

  QueryBuilder<ChatMessage, ChatMessage, QDistinct> distinctByInsertUserDocId(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('insertUserDocId',
        caseSensitive: caseSensitive);
  }

  QueryBuilder<ChatMessage, ChatMessage, QDistinct> distinctByMessageType(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('messageType', caseSensitive: caseSensitive);
  }

  QueryBuilder<ChatMessage, ChatMessage, QDistinct> distinctByReadableFlg() {
    return addDistinctByInternal('readableFlg');
  }

  QueryBuilder<ChatMessage, ChatMessage, QDistinct> distinctByReceiveSendType(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('receiveSendType',
        caseSensitive: caseSensitive);
  }

  QueryBuilder<ChatMessage, ChatMessage, QDistinct> distinctBySendTime() {
    return addDistinctByInternal('sendTime');
  }

  QueryBuilder<ChatMessage, ChatMessage, QDistinct> distinctByUpdateProgramId(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('updateProgramId',
        caseSensitive: caseSensitive);
  }

  QueryBuilder<ChatMessage, ChatMessage, QDistinct> distinctByUpdateTime() {
    return addDistinctByInternal('updateTime');
  }

  QueryBuilder<ChatMessage, ChatMessage, QDistinct> distinctByUpdateUserDocId(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('updateUserDocId',
        caseSensitive: caseSensitive);
  }

  QueryBuilder<ChatMessage, ChatMessage, QDistinct> distinctByUserDocId(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('userDocId', caseSensitive: caseSensitive);
  }
}

extension ChatMessageQueryProperty
    on QueryBuilder<ChatMessage, ChatMessage, QQueryProperty> {
  QueryBuilder<ChatMessage, String, QQueryOperations> callChannelIdProperty() {
    return addPropertyNameInternal('callChannelId');
  }

  QueryBuilder<ChatMessage, String, QQueryOperations>
      chatMessageDocIdProperty() {
    return addPropertyNameInternal('chatMessageDocId');
  }

  QueryBuilder<ChatMessage, String, QQueryOperations> contentProperty() {
    return addPropertyNameInternal('content');
  }

  QueryBuilder<ChatMessage, bool, QQueryOperations> deleteFlgProperty() {
    return addPropertyNameInternal('deleteFlg');
  }

  QueryBuilder<ChatMessage, String, QQueryOperations> fileNameSuffixProperty() {
    return addPropertyNameInternal('fileNameSuffix');
  }

  QueryBuilder<ChatMessage, String, QQueryOperations>
      friendUserDocIdProperty() {
    return addPropertyNameInternal('friendUserDocId');
  }

  QueryBuilder<ChatMessage, int, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<ChatMessage, String, QQueryOperations>
      insertProgramIdProperty() {
    return addPropertyNameInternal('insertProgramId');
  }

  QueryBuilder<ChatMessage, DateTime, QQueryOperations> insertTimeProperty() {
    return addPropertyNameInternal('insertTime');
  }

  QueryBuilder<ChatMessage, String, QQueryOperations>
      insertUserDocIdProperty() {
    return addPropertyNameInternal('insertUserDocId');
  }

  QueryBuilder<ChatMessage, String, QQueryOperations> messageTypeProperty() {
    return addPropertyNameInternal('messageType');
  }

  QueryBuilder<ChatMessage, bool, QQueryOperations> readableFlgProperty() {
    return addPropertyNameInternal('readableFlg');
  }

  QueryBuilder<ChatMessage, String, QQueryOperations>
      receiveSendTypeProperty() {
    return addPropertyNameInternal('receiveSendType');
  }

  QueryBuilder<ChatMessage, DateTime, QQueryOperations> sendTimeProperty() {
    return addPropertyNameInternal('sendTime');
  }

  QueryBuilder<ChatMessage, String, QQueryOperations>
      updateProgramIdProperty() {
    return addPropertyNameInternal('updateProgramId');
  }

  QueryBuilder<ChatMessage, DateTime, QQueryOperations> updateTimeProperty() {
    return addPropertyNameInternal('updateTime');
  }

  QueryBuilder<ChatMessage, String, QQueryOperations>
      updateUserDocIdProperty() {
    return addPropertyNameInternal('updateUserDocId');
  }

  QueryBuilder<ChatMessage, String, QQueryOperations> userDocIdProperty() {
    return addPropertyNameInternal('userDocId');
  }
}
