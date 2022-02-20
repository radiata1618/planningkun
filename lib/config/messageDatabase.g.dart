// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messageDatabase.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast

extension GetMessageCollection on Isar {
  IsarCollection<Message> get messages {
    return getCollection('Message');
  }
}

final MessageSchema = CollectionSchema(
  name: 'Message',
  schema:
      '{"name":"Message","idName":"id","properties":[{"name":"callChannelId","type":"String"},{"name":"content","type":"String"},{"name":"deleteFlg","type":"Bool"},{"name":"fileNameSuffix","type":"String"},{"name":"friendUserDocId","type":"String"},{"name":"insertProgramId","type":"String"},{"name":"insertTime","type":"Long"},{"name":"insertUserDocId","type":"String"},{"name":"messageDocId","type":"String"},{"name":"messageType","type":"String"},{"name":"readableFlg","type":"Bool"},{"name":"receiveSendType","type":"String"},{"name":"sendTime","type":"Long"},{"name":"updateProgramId","type":"String"},{"name":"updateTime","type":"Long"},{"name":"updateUserDocId","type":"String"},{"name":"userDocId","type":"String"}],"indexes":[],"links":[]}',
  nativeAdapter: const _MessageNativeAdapter(),
  webAdapter: const _MessageWebAdapter(),
  idName: 'id',
  propertyIds: {
    'callChannelId': 0,
    'content': 1,
    'deleteFlg': 2,
    'fileNameSuffix': 3,
    'friendUserDocId': 4,
    'insertProgramId': 5,
    'insertTime': 6,
    'insertUserDocId': 7,
    'messageDocId': 8,
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

class _MessageWebAdapter extends IsarWebTypeAdapter<Message> {
  const _MessageWebAdapter();

  @override
  Object serialize(IsarCollection<Message> collection, Message object) {
    final jsObj = IsarNative.newJsObject();
    IsarNative.jsObjectSet(jsObj, 'callChannelId', object.callChannelId);
    IsarNative.jsObjectSet(jsObj, 'content', object.content);
    IsarNative.jsObjectSet(jsObj, 'deleteFlg', object.deleteFlg);
    IsarNative.jsObjectSet(jsObj, 'fileNameSuffix', object.fileNameSuffix);
    IsarNative.jsObjectSet(jsObj, 'friendUserDocId', object.friendUserDocId);
    IsarNative.jsObjectSet(jsObj, 'id', object.id);
    IsarNative.jsObjectSet(jsObj, 'insertProgramId', object.insertProgramId);
    IsarNative.jsObjectSet(
        jsObj, 'insertTime', object.insertTime.toUtc().millisecondsSinceEpoch);
    IsarNative.jsObjectSet(jsObj, 'insertUserDocId', object.insertUserDocId);
    IsarNative.jsObjectSet(jsObj, 'messageDocId', object.messageDocId);
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
  Message deserialize(IsarCollection<Message> collection, dynamic jsObj) {
    final object = Message(
      IsarNative.jsObjectGet(jsObj, 'messageDocId') ?? '',
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
      case 'messageDocId':
        return (IsarNative.jsObjectGet(jsObj, 'messageDocId') ?? '') as P;
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
  void attachLinks(Isar isar, int id, Message object) {}
}

class _MessageNativeAdapter extends IsarNativeTypeAdapter<Message> {
  const _MessageNativeAdapter();

  @override
  void serialize(IsarCollection<Message> collection, IsarRawObject rawObj,
      Message object, int staticSize, List<int> offsets, AdapterAlloc alloc) {
    var dynamicSize = 0;
    final value0 = object.callChannelId;
    final _callChannelId = IsarBinaryWriter.utf8Encoder.convert(value0);
    dynamicSize += (_callChannelId.length) as int;
    final value1 = object.content;
    final _content = IsarBinaryWriter.utf8Encoder.convert(value1);
    dynamicSize += (_content.length) as int;
    final value2 = object.deleteFlg;
    final _deleteFlg = value2;
    final value3 = object.fileNameSuffix;
    final _fileNameSuffix = IsarBinaryWriter.utf8Encoder.convert(value3);
    dynamicSize += (_fileNameSuffix.length) as int;
    final value4 = object.friendUserDocId;
    final _friendUserDocId = IsarBinaryWriter.utf8Encoder.convert(value4);
    dynamicSize += (_friendUserDocId.length) as int;
    final value5 = object.insertProgramId;
    final _insertProgramId = IsarBinaryWriter.utf8Encoder.convert(value5);
    dynamicSize += (_insertProgramId.length) as int;
    final value6 = object.insertTime;
    final _insertTime = value6;
    final value7 = object.insertUserDocId;
    final _insertUserDocId = IsarBinaryWriter.utf8Encoder.convert(value7);
    dynamicSize += (_insertUserDocId.length) as int;
    final value8 = object.messageDocId;
    final _messageDocId = IsarBinaryWriter.utf8Encoder.convert(value8);
    dynamicSize += (_messageDocId.length) as int;
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
    writer.writeBytes(offsets[1], _content);
    writer.writeBool(offsets[2], _deleteFlg);
    writer.writeBytes(offsets[3], _fileNameSuffix);
    writer.writeBytes(offsets[4], _friendUserDocId);
    writer.writeBytes(offsets[5], _insertProgramId);
    writer.writeDateTime(offsets[6], _insertTime);
    writer.writeBytes(offsets[7], _insertUserDocId);
    writer.writeBytes(offsets[8], _messageDocId);
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
  Message deserialize(IsarCollection<Message> collection, int id,
      IsarBinaryReader reader, List<int> offsets) {
    final object = Message(
      reader.readString(offsets[8]),
      reader.readString(offsets[16]),
      reader.readString(offsets[4]),
      reader.readString(offsets[1]),
      reader.readString(offsets[11]),
      reader.readString(offsets[9]),
      reader.readDateTime(offsets[12]),
      reader.readString(offsets[0]),
      reader.readString(offsets[3]),
      reader.readString(offsets[7]),
      reader.readString(offsets[5]),
      reader.readDateTime(offsets[6]),
      reader.readString(offsets[15]),
      reader.readString(offsets[13]),
      reader.readDateTime(offsets[14]),
      reader.readBool(offsets[10]),
      reader.readBool(offsets[2]),
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
        return (reader.readBool(offset)) as P;
      case 3:
        return (reader.readString(offset)) as P;
      case 4:
        return (reader.readString(offset)) as P;
      case 5:
        return (reader.readString(offset)) as P;
      case 6:
        return (reader.readDateTime(offset)) as P;
      case 7:
        return (reader.readString(offset)) as P;
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
  void attachLinks(Isar isar, int id, Message object) {}
}

extension MessageQueryWhereSort on QueryBuilder<Message, Message, QWhere> {
  QueryBuilder<Message, Message, QAfterWhere> anyId() {
    return addWhereClauseInternal(const WhereClause(indexName: null));
  }
}

extension MessageQueryWhere on QueryBuilder<Message, Message, QWhereClause> {
  QueryBuilder<Message, Message, QAfterWhereClause> idEqualTo(int id) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [id],
      includeLower: true,
      upper: [id],
      includeUpper: true,
    ));
  }

  QueryBuilder<Message, Message, QAfterWhereClause> idNotEqualTo(int id) {
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

  QueryBuilder<Message, Message, QAfterWhereClause> idGreaterThan(
    int id, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [id],
      includeLower: include,
    ));
  }

  QueryBuilder<Message, Message, QAfterWhereClause> idLessThan(
    int id, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      upper: [id],
      includeUpper: include,
    ));
  }

  QueryBuilder<Message, Message, QAfterWhereClause> idBetween(
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

extension MessageQueryFilter
    on QueryBuilder<Message, Message, QFilterCondition> {
  QueryBuilder<Message, Message, QAfterFilterCondition> callChannelIdEqualTo(
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

  QueryBuilder<Message, Message, QAfterFilterCondition>
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

  QueryBuilder<Message, Message, QAfterFilterCondition> callChannelIdLessThan(
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

  QueryBuilder<Message, Message, QAfterFilterCondition> callChannelIdBetween(
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

  QueryBuilder<Message, Message, QAfterFilterCondition> callChannelIdStartsWith(
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

  QueryBuilder<Message, Message, QAfterFilterCondition> callChannelIdEndsWith(
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

  QueryBuilder<Message, Message, QAfterFilterCondition> callChannelIdContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'callChannelId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Message, Message, QAfterFilterCondition> callChannelIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'callChannelId',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Message, Message, QAfterFilterCondition> contentEqualTo(
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

  QueryBuilder<Message, Message, QAfterFilterCondition> contentGreaterThan(
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

  QueryBuilder<Message, Message, QAfterFilterCondition> contentLessThan(
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

  QueryBuilder<Message, Message, QAfterFilterCondition> contentBetween(
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

  QueryBuilder<Message, Message, QAfterFilterCondition> contentStartsWith(
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

  QueryBuilder<Message, Message, QAfterFilterCondition> contentEndsWith(
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

  QueryBuilder<Message, Message, QAfterFilterCondition> contentContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'content',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Message, Message, QAfterFilterCondition> contentMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'content',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Message, Message, QAfterFilterCondition> deleteFlgEqualTo(
      bool value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'deleteFlg',
      value: value,
    ));
  }

  QueryBuilder<Message, Message, QAfterFilterCondition> fileNameSuffixEqualTo(
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

  QueryBuilder<Message, Message, QAfterFilterCondition>
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

  QueryBuilder<Message, Message, QAfterFilterCondition> fileNameSuffixLessThan(
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

  QueryBuilder<Message, Message, QAfterFilterCondition> fileNameSuffixBetween(
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

  QueryBuilder<Message, Message, QAfterFilterCondition>
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

  QueryBuilder<Message, Message, QAfterFilterCondition> fileNameSuffixEndsWith(
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

  QueryBuilder<Message, Message, QAfterFilterCondition> fileNameSuffixContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'fileNameSuffix',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Message, Message, QAfterFilterCondition> fileNameSuffixMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'fileNameSuffix',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Message, Message, QAfterFilterCondition> friendUserDocIdEqualTo(
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

  QueryBuilder<Message, Message, QAfterFilterCondition>
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

  QueryBuilder<Message, Message, QAfterFilterCondition> friendUserDocIdLessThan(
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

  QueryBuilder<Message, Message, QAfterFilterCondition> friendUserDocIdBetween(
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

  QueryBuilder<Message, Message, QAfterFilterCondition>
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

  QueryBuilder<Message, Message, QAfterFilterCondition> friendUserDocIdEndsWith(
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

  QueryBuilder<Message, Message, QAfterFilterCondition> friendUserDocIdContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'friendUserDocId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Message, Message, QAfterFilterCondition> friendUserDocIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'friendUserDocId',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Message, Message, QAfterFilterCondition> idEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<Message, Message, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Message, Message, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Message, Message, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Message, Message, QAfterFilterCondition> insertProgramIdEqualTo(
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

  QueryBuilder<Message, Message, QAfterFilterCondition>
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

  QueryBuilder<Message, Message, QAfterFilterCondition> insertProgramIdLessThan(
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

  QueryBuilder<Message, Message, QAfterFilterCondition> insertProgramIdBetween(
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

  QueryBuilder<Message, Message, QAfterFilterCondition>
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

  QueryBuilder<Message, Message, QAfterFilterCondition> insertProgramIdEndsWith(
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

  QueryBuilder<Message, Message, QAfterFilterCondition> insertProgramIdContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'insertProgramId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Message, Message, QAfterFilterCondition> insertProgramIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'insertProgramId',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Message, Message, QAfterFilterCondition> insertTimeEqualTo(
      DateTime value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'insertTime',
      value: value,
    ));
  }

  QueryBuilder<Message, Message, QAfterFilterCondition> insertTimeGreaterThan(
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

  QueryBuilder<Message, Message, QAfterFilterCondition> insertTimeLessThan(
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

  QueryBuilder<Message, Message, QAfterFilterCondition> insertTimeBetween(
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

  QueryBuilder<Message, Message, QAfterFilterCondition> insertUserDocIdEqualTo(
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

  QueryBuilder<Message, Message, QAfterFilterCondition>
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

  QueryBuilder<Message, Message, QAfterFilterCondition> insertUserDocIdLessThan(
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

  QueryBuilder<Message, Message, QAfterFilterCondition> insertUserDocIdBetween(
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

  QueryBuilder<Message, Message, QAfterFilterCondition>
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

  QueryBuilder<Message, Message, QAfterFilterCondition> insertUserDocIdEndsWith(
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

  QueryBuilder<Message, Message, QAfterFilterCondition> insertUserDocIdContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'insertUserDocId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Message, Message, QAfterFilterCondition> insertUserDocIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'insertUserDocId',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Message, Message, QAfterFilterCondition> messageDocIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'messageDocId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Message, Message, QAfterFilterCondition> messageDocIdGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'messageDocId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Message, Message, QAfterFilterCondition> messageDocIdLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'messageDocId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Message, Message, QAfterFilterCondition> messageDocIdBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'messageDocId',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Message, Message, QAfterFilterCondition> messageDocIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'messageDocId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Message, Message, QAfterFilterCondition> messageDocIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'messageDocId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Message, Message, QAfterFilterCondition> messageDocIdContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'messageDocId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Message, Message, QAfterFilterCondition> messageDocIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'messageDocId',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Message, Message, QAfterFilterCondition> messageTypeEqualTo(
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

  QueryBuilder<Message, Message, QAfterFilterCondition> messageTypeGreaterThan(
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

  QueryBuilder<Message, Message, QAfterFilterCondition> messageTypeLessThan(
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

  QueryBuilder<Message, Message, QAfterFilterCondition> messageTypeBetween(
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

  QueryBuilder<Message, Message, QAfterFilterCondition> messageTypeStartsWith(
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

  QueryBuilder<Message, Message, QAfterFilterCondition> messageTypeEndsWith(
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

  QueryBuilder<Message, Message, QAfterFilterCondition> messageTypeContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'messageType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Message, Message, QAfterFilterCondition> messageTypeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'messageType',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Message, Message, QAfterFilterCondition> readableFlgEqualTo(
      bool value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'readableFlg',
      value: value,
    ));
  }

  QueryBuilder<Message, Message, QAfterFilterCondition> receiveSendTypeEqualTo(
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

  QueryBuilder<Message, Message, QAfterFilterCondition>
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

  QueryBuilder<Message, Message, QAfterFilterCondition> receiveSendTypeLessThan(
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

  QueryBuilder<Message, Message, QAfterFilterCondition> receiveSendTypeBetween(
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

  QueryBuilder<Message, Message, QAfterFilterCondition>
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

  QueryBuilder<Message, Message, QAfterFilterCondition> receiveSendTypeEndsWith(
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

  QueryBuilder<Message, Message, QAfterFilterCondition> receiveSendTypeContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'receiveSendType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Message, Message, QAfterFilterCondition> receiveSendTypeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'receiveSendType',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Message, Message, QAfterFilterCondition> sendTimeEqualTo(
      DateTime value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'sendTime',
      value: value,
    ));
  }

  QueryBuilder<Message, Message, QAfterFilterCondition> sendTimeGreaterThan(
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

  QueryBuilder<Message, Message, QAfterFilterCondition> sendTimeLessThan(
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

  QueryBuilder<Message, Message, QAfterFilterCondition> sendTimeBetween(
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

  QueryBuilder<Message, Message, QAfterFilterCondition> updateProgramIdEqualTo(
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

  QueryBuilder<Message, Message, QAfterFilterCondition>
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

  QueryBuilder<Message, Message, QAfterFilterCondition> updateProgramIdLessThan(
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

  QueryBuilder<Message, Message, QAfterFilterCondition> updateProgramIdBetween(
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

  QueryBuilder<Message, Message, QAfterFilterCondition>
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

  QueryBuilder<Message, Message, QAfterFilterCondition> updateProgramIdEndsWith(
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

  QueryBuilder<Message, Message, QAfterFilterCondition> updateProgramIdContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'updateProgramId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Message, Message, QAfterFilterCondition> updateProgramIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'updateProgramId',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Message, Message, QAfterFilterCondition> updateTimeEqualTo(
      DateTime value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'updateTime',
      value: value,
    ));
  }

  QueryBuilder<Message, Message, QAfterFilterCondition> updateTimeGreaterThan(
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

  QueryBuilder<Message, Message, QAfterFilterCondition> updateTimeLessThan(
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

  QueryBuilder<Message, Message, QAfterFilterCondition> updateTimeBetween(
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

  QueryBuilder<Message, Message, QAfterFilterCondition> updateUserDocIdEqualTo(
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

  QueryBuilder<Message, Message, QAfterFilterCondition>
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

  QueryBuilder<Message, Message, QAfterFilterCondition> updateUserDocIdLessThan(
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

  QueryBuilder<Message, Message, QAfterFilterCondition> updateUserDocIdBetween(
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

  QueryBuilder<Message, Message, QAfterFilterCondition>
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

  QueryBuilder<Message, Message, QAfterFilterCondition> updateUserDocIdEndsWith(
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

  QueryBuilder<Message, Message, QAfterFilterCondition> updateUserDocIdContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'updateUserDocId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Message, Message, QAfterFilterCondition> updateUserDocIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'updateUserDocId',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Message, Message, QAfterFilterCondition> userDocIdEqualTo(
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

  QueryBuilder<Message, Message, QAfterFilterCondition> userDocIdGreaterThan(
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

  QueryBuilder<Message, Message, QAfterFilterCondition> userDocIdLessThan(
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

  QueryBuilder<Message, Message, QAfterFilterCondition> userDocIdBetween(
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

  QueryBuilder<Message, Message, QAfterFilterCondition> userDocIdStartsWith(
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

  QueryBuilder<Message, Message, QAfterFilterCondition> userDocIdEndsWith(
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

  QueryBuilder<Message, Message, QAfterFilterCondition> userDocIdContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'userDocId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Message, Message, QAfterFilterCondition> userDocIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'userDocId',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }
}

extension MessageQueryLinks
    on QueryBuilder<Message, Message, QFilterCondition> {}

extension MessageQueryWhereSortBy on QueryBuilder<Message, Message, QSortBy> {
  QueryBuilder<Message, Message, QAfterSortBy> sortByCallChannelId() {
    return addSortByInternal('callChannelId', Sort.asc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> sortByCallChannelIdDesc() {
    return addSortByInternal('callChannelId', Sort.desc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> sortByContent() {
    return addSortByInternal('content', Sort.asc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> sortByContentDesc() {
    return addSortByInternal('content', Sort.desc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> sortByDeleteFlg() {
    return addSortByInternal('deleteFlg', Sort.asc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> sortByDeleteFlgDesc() {
    return addSortByInternal('deleteFlg', Sort.desc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> sortByFileNameSuffix() {
    return addSortByInternal('fileNameSuffix', Sort.asc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> sortByFileNameSuffixDesc() {
    return addSortByInternal('fileNameSuffix', Sort.desc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> sortByFriendUserDocId() {
    return addSortByInternal('friendUserDocId', Sort.asc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> sortByFriendUserDocIdDesc() {
    return addSortByInternal('friendUserDocId', Sort.desc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> sortByInsertProgramId() {
    return addSortByInternal('insertProgramId', Sort.asc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> sortByInsertProgramIdDesc() {
    return addSortByInternal('insertProgramId', Sort.desc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> sortByInsertTime() {
    return addSortByInternal('insertTime', Sort.asc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> sortByInsertTimeDesc() {
    return addSortByInternal('insertTime', Sort.desc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> sortByInsertUserDocId() {
    return addSortByInternal('insertUserDocId', Sort.asc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> sortByInsertUserDocIdDesc() {
    return addSortByInternal('insertUserDocId', Sort.desc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> sortByMessageDocId() {
    return addSortByInternal('messageDocId', Sort.asc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> sortByMessageDocIdDesc() {
    return addSortByInternal('messageDocId', Sort.desc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> sortByMessageType() {
    return addSortByInternal('messageType', Sort.asc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> sortByMessageTypeDesc() {
    return addSortByInternal('messageType', Sort.desc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> sortByReadableFlg() {
    return addSortByInternal('readableFlg', Sort.asc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> sortByReadableFlgDesc() {
    return addSortByInternal('readableFlg', Sort.desc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> sortByReceiveSendType() {
    return addSortByInternal('receiveSendType', Sort.asc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> sortByReceiveSendTypeDesc() {
    return addSortByInternal('receiveSendType', Sort.desc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> sortBySendTime() {
    return addSortByInternal('sendTime', Sort.asc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> sortBySendTimeDesc() {
    return addSortByInternal('sendTime', Sort.desc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> sortByUpdateProgramId() {
    return addSortByInternal('updateProgramId', Sort.asc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> sortByUpdateProgramIdDesc() {
    return addSortByInternal('updateProgramId', Sort.desc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> sortByUpdateTime() {
    return addSortByInternal('updateTime', Sort.asc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> sortByUpdateTimeDesc() {
    return addSortByInternal('updateTime', Sort.desc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> sortByUpdateUserDocId() {
    return addSortByInternal('updateUserDocId', Sort.asc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> sortByUpdateUserDocIdDesc() {
    return addSortByInternal('updateUserDocId', Sort.desc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> sortByUserDocId() {
    return addSortByInternal('userDocId', Sort.asc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> sortByUserDocIdDesc() {
    return addSortByInternal('userDocId', Sort.desc);
  }
}

extension MessageQueryWhereSortThenBy
    on QueryBuilder<Message, Message, QSortThenBy> {
  QueryBuilder<Message, Message, QAfterSortBy> thenByCallChannelId() {
    return addSortByInternal('callChannelId', Sort.asc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> thenByCallChannelIdDesc() {
    return addSortByInternal('callChannelId', Sort.desc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> thenByContent() {
    return addSortByInternal('content', Sort.asc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> thenByContentDesc() {
    return addSortByInternal('content', Sort.desc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> thenByDeleteFlg() {
    return addSortByInternal('deleteFlg', Sort.asc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> thenByDeleteFlgDesc() {
    return addSortByInternal('deleteFlg', Sort.desc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> thenByFileNameSuffix() {
    return addSortByInternal('fileNameSuffix', Sort.asc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> thenByFileNameSuffixDesc() {
    return addSortByInternal('fileNameSuffix', Sort.desc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> thenByFriendUserDocId() {
    return addSortByInternal('friendUserDocId', Sort.asc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> thenByFriendUserDocIdDesc() {
    return addSortByInternal('friendUserDocId', Sort.desc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> thenByInsertProgramId() {
    return addSortByInternal('insertProgramId', Sort.asc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> thenByInsertProgramIdDesc() {
    return addSortByInternal('insertProgramId', Sort.desc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> thenByInsertTime() {
    return addSortByInternal('insertTime', Sort.asc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> thenByInsertTimeDesc() {
    return addSortByInternal('insertTime', Sort.desc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> thenByInsertUserDocId() {
    return addSortByInternal('insertUserDocId', Sort.asc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> thenByInsertUserDocIdDesc() {
    return addSortByInternal('insertUserDocId', Sort.desc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> thenByMessageDocId() {
    return addSortByInternal('messageDocId', Sort.asc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> thenByMessageDocIdDesc() {
    return addSortByInternal('messageDocId', Sort.desc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> thenByMessageType() {
    return addSortByInternal('messageType', Sort.asc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> thenByMessageTypeDesc() {
    return addSortByInternal('messageType', Sort.desc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> thenByReadableFlg() {
    return addSortByInternal('readableFlg', Sort.asc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> thenByReadableFlgDesc() {
    return addSortByInternal('readableFlg', Sort.desc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> thenByReceiveSendType() {
    return addSortByInternal('receiveSendType', Sort.asc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> thenByReceiveSendTypeDesc() {
    return addSortByInternal('receiveSendType', Sort.desc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> thenBySendTime() {
    return addSortByInternal('sendTime', Sort.asc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> thenBySendTimeDesc() {
    return addSortByInternal('sendTime', Sort.desc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> thenByUpdateProgramId() {
    return addSortByInternal('updateProgramId', Sort.asc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> thenByUpdateProgramIdDesc() {
    return addSortByInternal('updateProgramId', Sort.desc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> thenByUpdateTime() {
    return addSortByInternal('updateTime', Sort.asc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> thenByUpdateTimeDesc() {
    return addSortByInternal('updateTime', Sort.desc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> thenByUpdateUserDocId() {
    return addSortByInternal('updateUserDocId', Sort.asc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> thenByUpdateUserDocIdDesc() {
    return addSortByInternal('updateUserDocId', Sort.desc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> thenByUserDocId() {
    return addSortByInternal('userDocId', Sort.asc);
  }

  QueryBuilder<Message, Message, QAfterSortBy> thenByUserDocIdDesc() {
    return addSortByInternal('userDocId', Sort.desc);
  }
}

extension MessageQueryWhereDistinct
    on QueryBuilder<Message, Message, QDistinct> {
  QueryBuilder<Message, Message, QDistinct> distinctByCallChannelId(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('callChannelId', caseSensitive: caseSensitive);
  }

  QueryBuilder<Message, Message, QDistinct> distinctByContent(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('content', caseSensitive: caseSensitive);
  }

  QueryBuilder<Message, Message, QDistinct> distinctByDeleteFlg() {
    return addDistinctByInternal('deleteFlg');
  }

  QueryBuilder<Message, Message, QDistinct> distinctByFileNameSuffix(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('fileNameSuffix',
        caseSensitive: caseSensitive);
  }

  QueryBuilder<Message, Message, QDistinct> distinctByFriendUserDocId(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('friendUserDocId',
        caseSensitive: caseSensitive);
  }

  QueryBuilder<Message, Message, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<Message, Message, QDistinct> distinctByInsertProgramId(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('insertProgramId',
        caseSensitive: caseSensitive);
  }

  QueryBuilder<Message, Message, QDistinct> distinctByInsertTime() {
    return addDistinctByInternal('insertTime');
  }

  QueryBuilder<Message, Message, QDistinct> distinctByInsertUserDocId(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('insertUserDocId',
        caseSensitive: caseSensitive);
  }

  QueryBuilder<Message, Message, QDistinct> distinctByMessageDocId(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('messageDocId', caseSensitive: caseSensitive);
  }

  QueryBuilder<Message, Message, QDistinct> distinctByMessageType(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('messageType', caseSensitive: caseSensitive);
  }

  QueryBuilder<Message, Message, QDistinct> distinctByReadableFlg() {
    return addDistinctByInternal('readableFlg');
  }

  QueryBuilder<Message, Message, QDistinct> distinctByReceiveSendType(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('receiveSendType',
        caseSensitive: caseSensitive);
  }

  QueryBuilder<Message, Message, QDistinct> distinctBySendTime() {
    return addDistinctByInternal('sendTime');
  }

  QueryBuilder<Message, Message, QDistinct> distinctByUpdateProgramId(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('updateProgramId',
        caseSensitive: caseSensitive);
  }

  QueryBuilder<Message, Message, QDistinct> distinctByUpdateTime() {
    return addDistinctByInternal('updateTime');
  }

  QueryBuilder<Message, Message, QDistinct> distinctByUpdateUserDocId(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('updateUserDocId',
        caseSensitive: caseSensitive);
  }

  QueryBuilder<Message, Message, QDistinct> distinctByUserDocId(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('userDocId', caseSensitive: caseSensitive);
  }
}

extension MessageQueryProperty
    on QueryBuilder<Message, Message, QQueryProperty> {
  QueryBuilder<Message, String, QQueryOperations> callChannelIdProperty() {
    return addPropertyNameInternal('callChannelId');
  }

  QueryBuilder<Message, String, QQueryOperations> contentProperty() {
    return addPropertyNameInternal('content');
  }

  QueryBuilder<Message, bool, QQueryOperations> deleteFlgProperty() {
    return addPropertyNameInternal('deleteFlg');
  }

  QueryBuilder<Message, String, QQueryOperations> fileNameSuffixProperty() {
    return addPropertyNameInternal('fileNameSuffix');
  }

  QueryBuilder<Message, String, QQueryOperations> friendUserDocIdProperty() {
    return addPropertyNameInternal('friendUserDocId');
  }

  QueryBuilder<Message, int, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<Message, String, QQueryOperations> insertProgramIdProperty() {
    return addPropertyNameInternal('insertProgramId');
  }

  QueryBuilder<Message, DateTime, QQueryOperations> insertTimeProperty() {
    return addPropertyNameInternal('insertTime');
  }

  QueryBuilder<Message, String, QQueryOperations> insertUserDocIdProperty() {
    return addPropertyNameInternal('insertUserDocId');
  }

  QueryBuilder<Message, String, QQueryOperations> messageDocIdProperty() {
    return addPropertyNameInternal('messageDocId');
  }

  QueryBuilder<Message, String, QQueryOperations> messageTypeProperty() {
    return addPropertyNameInternal('messageType');
  }

  QueryBuilder<Message, bool, QQueryOperations> readableFlgProperty() {
    return addPropertyNameInternal('readableFlg');
  }

  QueryBuilder<Message, String, QQueryOperations> receiveSendTypeProperty() {
    return addPropertyNameInternal('receiveSendType');
  }

  QueryBuilder<Message, DateTime, QQueryOperations> sendTimeProperty() {
    return addPropertyNameInternal('sendTime');
  }

  QueryBuilder<Message, String, QQueryOperations> updateProgramIdProperty() {
    return addPropertyNameInternal('updateProgramId');
  }

  QueryBuilder<Message, DateTime, QQueryOperations> updateTimeProperty() {
    return addPropertyNameInternal('updateTime');
  }

  QueryBuilder<Message, String, QQueryOperations> updateUserDocIdProperty() {
    return addPropertyNameInternal('updateUserDocId');
  }

  QueryBuilder<Message, String, QQueryOperations> userDocIdProperty() {
    return addPropertyNameInternal('userDocId');
  }
}
