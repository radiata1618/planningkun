// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messagesDatabase.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast

extension GetMessagesCollection on Isar {
  IsarCollection<Messages> get messagess {
    return getCollection('Messages');
  }
}

final MessagesSchema = CollectionSchema(
  name: 'Messages',
  schema:
      '{"name":"Messages","idName":"id","properties":[{"name":"callChannelId","type":"String"},{"name":"content","type":"String"},{"name":"deleteFlg","type":"Bool"},{"name":"fileNameSuffix","type":"String"},{"name":"friendUserDoc","type":"String"},{"name":"insertProgramId","type":"String"},{"name":"insertTime","type":"Long"},{"name":"insertUserDocId","type":"String"},{"name":"messageDocId","type":"String"},{"name":"messageType","type":"String"},{"name":"readableFlg","type":"Bool"},{"name":"receiveSendTy","type":"String"},{"name":"sendTime","type":"String"},{"name":"updateProgramId","type":"String"},{"name":"updateTime","type":"Long"},{"name":"updateUserDocId","type":"String"},{"name":"userDocId","type":"String"}],"indexes":[],"links":[]}',
  nativeAdapter: const _MessagesNativeAdapter(),
  webAdapter: const _MessagesWebAdapter(),
  idName: 'id',
  propertyIds: {
    'callChannelId': 0,
    'content': 1,
    'deleteFlg': 2,
    'fileNameSuffix': 3,
    'friendUserDoc': 4,
    'insertProgramId': 5,
    'insertTime': 6,
    'insertUserDocId': 7,
    'messageDocId': 8,
    'messageType': 9,
    'readableFlg': 10,
    'receiveSendTy': 11,
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

class _MessagesWebAdapter extends IsarWebTypeAdapter<Messages> {
  const _MessagesWebAdapter();

  @override
  Object serialize(IsarCollection<Messages> collection, Messages object) {
    final jsObj = IsarNative.newJsObject();
    IsarNative.jsObjectSet(jsObj, 'callChannelId', object.callChannelId);
    IsarNative.jsObjectSet(jsObj, 'content', object.content);
    IsarNative.jsObjectSet(jsObj, 'deleteFlg', object.deleteFlg);
    IsarNative.jsObjectSet(jsObj, 'fileNameSuffix', object.fileNameSuffix);
    IsarNative.jsObjectSet(jsObj, 'friendUserDoc', object.friendUserDoc);
    IsarNative.jsObjectSet(jsObj, 'id', object.id);
    IsarNative.jsObjectSet(jsObj, 'insertProgramId', object.insertProgramId);
    IsarNative.jsObjectSet(
        jsObj, 'insertTime', object.insertTime.toUtc().millisecondsSinceEpoch);
    IsarNative.jsObjectSet(jsObj, 'insertUserDocId', object.insertUserDocId);
    IsarNative.jsObjectSet(jsObj, 'messageDocId', object.messageDocId);
    IsarNative.jsObjectSet(jsObj, 'messageType', object.messageType);
    IsarNative.jsObjectSet(jsObj, 'readableFlg', object.readableFlg);
    IsarNative.jsObjectSet(jsObj, 'receiveSendTy', object.receiveSendTy);
    IsarNative.jsObjectSet(jsObj, 'sendTime', object.sendTime);
    IsarNative.jsObjectSet(jsObj, 'updateProgramId', object.updateProgramId);
    IsarNative.jsObjectSet(
        jsObj, 'updateTime', object.updateTime.toUtc().millisecondsSinceEpoch);
    IsarNative.jsObjectSet(jsObj, 'updateUserDocId', object.updateUserDocId);
    IsarNative.jsObjectSet(jsObj, 'userDocId', object.userDocId);
    return jsObj;
  }

  @override
  Messages deserialize(IsarCollection<Messages> collection, dynamic jsObj) {
    final object = Messages();
    object.callChannelId = IsarNative.jsObjectGet(jsObj, 'callChannelId') ?? '';
    object.content = IsarNative.jsObjectGet(jsObj, 'content') ?? '';
    object.deleteFlg = IsarNative.jsObjectGet(jsObj, 'deleteFlg') ?? false;
    object.fileNameSuffix =
        IsarNative.jsObjectGet(jsObj, 'fileNameSuffix') ?? '';
    object.friendUserDoc = IsarNative.jsObjectGet(jsObj, 'friendUserDoc') ?? '';
    object.id = IsarNative.jsObjectGet(jsObj, 'id');
    object.insertProgramId =
        IsarNative.jsObjectGet(jsObj, 'insertProgramId') ?? '';
    object.insertTime = IsarNative.jsObjectGet(jsObj, 'insertTime') != null
        ? DateTime.fromMillisecondsSinceEpoch(
                IsarNative.jsObjectGet(jsObj, 'insertTime'),
                isUtc: true)
            .toLocal()
        : DateTime.fromMillisecondsSinceEpoch(0);
    object.insertUserDocId =
        IsarNative.jsObjectGet(jsObj, 'insertUserDocId') ?? '';
    object.messageDocId = IsarNative.jsObjectGet(jsObj, 'messageDocId') ?? '';
    object.messageType = IsarNative.jsObjectGet(jsObj, 'messageType') ?? '';
    object.readableFlg = IsarNative.jsObjectGet(jsObj, 'readableFlg') ?? false;
    object.receiveSendTy = IsarNative.jsObjectGet(jsObj, 'receiveSendTy') ?? '';
    object.sendTime = IsarNative.jsObjectGet(jsObj, 'sendTime') ?? '';
    object.updateProgramId =
        IsarNative.jsObjectGet(jsObj, 'updateProgramId') ?? '';
    object.updateTime = IsarNative.jsObjectGet(jsObj, 'updateTime') != null
        ? DateTime.fromMillisecondsSinceEpoch(
                IsarNative.jsObjectGet(jsObj, 'updateTime'),
                isUtc: true)
            .toLocal()
        : DateTime.fromMillisecondsSinceEpoch(0);
    object.updateUserDocId =
        IsarNative.jsObjectGet(jsObj, 'updateUserDocId') ?? '';
    object.userDocId = IsarNative.jsObjectGet(jsObj, 'userDocId') ?? '';
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
      case 'friendUserDoc':
        return (IsarNative.jsObjectGet(jsObj, 'friendUserDoc') ?? '') as P;
      case 'id':
        return (IsarNative.jsObjectGet(jsObj, 'id')) as P;
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
      case 'receiveSendTy':
        return (IsarNative.jsObjectGet(jsObj, 'receiveSendTy') ?? '') as P;
      case 'sendTime':
        return (IsarNative.jsObjectGet(jsObj, 'sendTime') ?? '') as P;
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
  void attachLinks(Isar isar, int id, Messages object) {}
}

class _MessagesNativeAdapter extends IsarNativeTypeAdapter<Messages> {
  const _MessagesNativeAdapter();

  @override
  void serialize(IsarCollection<Messages> collection, IsarRawObject rawObj,
      Messages object, int staticSize, List<int> offsets, AdapterAlloc alloc) {
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
    final value4 = object.friendUserDoc;
    final _friendUserDoc = IsarBinaryWriter.utf8Encoder.convert(value4);
    dynamicSize += (_friendUserDoc.length) as int;
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
    final value11 = object.receiveSendTy;
    final _receiveSendTy = IsarBinaryWriter.utf8Encoder.convert(value11);
    dynamicSize += (_receiveSendTy.length) as int;
    final value12 = object.sendTime;
    final _sendTime = IsarBinaryWriter.utf8Encoder.convert(value12);
    dynamicSize += (_sendTime.length) as int;
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
    writer.writeBytes(offsets[4], _friendUserDoc);
    writer.writeBytes(offsets[5], _insertProgramId);
    writer.writeDateTime(offsets[6], _insertTime);
    writer.writeBytes(offsets[7], _insertUserDocId);
    writer.writeBytes(offsets[8], _messageDocId);
    writer.writeBytes(offsets[9], _messageType);
    writer.writeBool(offsets[10], _readableFlg);
    writer.writeBytes(offsets[11], _receiveSendTy);
    writer.writeBytes(offsets[12], _sendTime);
    writer.writeBytes(offsets[13], _updateProgramId);
    writer.writeDateTime(offsets[14], _updateTime);
    writer.writeBytes(offsets[15], _updateUserDocId);
    writer.writeBytes(offsets[16], _userDocId);
  }

  @override
  Messages deserialize(IsarCollection<Messages> collection, int id,
      IsarBinaryReader reader, List<int> offsets) {
    final object = Messages();
    object.callChannelId = reader.readString(offsets[0]);
    object.content = reader.readString(offsets[1]);
    object.deleteFlg = reader.readBool(offsets[2]);
    object.fileNameSuffix = reader.readString(offsets[3]);
    object.friendUserDoc = reader.readString(offsets[4]);
    object.id = id;
    object.insertProgramId = reader.readString(offsets[5]);
    object.insertTime = reader.readDateTime(offsets[6]);
    object.insertUserDocId = reader.readString(offsets[7]);
    object.messageDocId = reader.readString(offsets[8]);
    object.messageType = reader.readString(offsets[9]);
    object.readableFlg = reader.readBool(offsets[10]);
    object.receiveSendTy = reader.readString(offsets[11]);
    object.sendTime = reader.readString(offsets[12]);
    object.updateProgramId = reader.readString(offsets[13]);
    object.updateTime = reader.readDateTime(offsets[14]);
    object.updateUserDocId = reader.readString(offsets[15]);
    object.userDocId = reader.readString(offsets[16]);
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
        return (reader.readString(offset)) as P;
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
  void attachLinks(Isar isar, int id, Messages object) {}
}

extension MessagesQueryWhereSort on QueryBuilder<Messages, Messages, QWhere> {
  QueryBuilder<Messages, Messages, QAfterWhere> anyId() {
    return addWhereClauseInternal(const WhereClause(indexName: null));
  }
}

extension MessagesQueryWhere on QueryBuilder<Messages, Messages, QWhereClause> {
  QueryBuilder<Messages, Messages, QAfterWhereClause> idEqualTo(int? id) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [id],
      includeLower: true,
      upper: [id],
      includeUpper: true,
    ));
  }

  QueryBuilder<Messages, Messages, QAfterWhereClause> idNotEqualTo(int? id) {
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

  QueryBuilder<Messages, Messages, QAfterWhereClause> idGreaterThan(
    int? id, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      lower: [id],
      includeLower: include,
    ));
  }

  QueryBuilder<Messages, Messages, QAfterWhereClause> idLessThan(
    int? id, {
    bool include = false,
  }) {
    return addWhereClauseInternal(WhereClause(
      indexName: null,
      upper: [id],
      includeUpper: include,
    ));
  }

  QueryBuilder<Messages, Messages, QAfterWhereClause> idBetween(
    int? lowerId,
    int? upperId, {
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

extension MessagesQueryFilter
    on QueryBuilder<Messages, Messages, QFilterCondition> {
  QueryBuilder<Messages, Messages, QAfterFilterCondition> callChannelIdEqualTo(
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

  QueryBuilder<Messages, Messages, QAfterFilterCondition>
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

  QueryBuilder<Messages, Messages, QAfterFilterCondition> callChannelIdLessThan(
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

  QueryBuilder<Messages, Messages, QAfterFilterCondition> callChannelIdBetween(
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

  QueryBuilder<Messages, Messages, QAfterFilterCondition>
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

  QueryBuilder<Messages, Messages, QAfterFilterCondition> callChannelIdEndsWith(
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

  QueryBuilder<Messages, Messages, QAfterFilterCondition> callChannelIdContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'callChannelId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Messages, Messages, QAfterFilterCondition> callChannelIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'callChannelId',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Messages, Messages, QAfterFilterCondition> contentEqualTo(
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

  QueryBuilder<Messages, Messages, QAfterFilterCondition> contentGreaterThan(
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

  QueryBuilder<Messages, Messages, QAfterFilterCondition> contentLessThan(
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

  QueryBuilder<Messages, Messages, QAfterFilterCondition> contentBetween(
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

  QueryBuilder<Messages, Messages, QAfterFilterCondition> contentStartsWith(
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

  QueryBuilder<Messages, Messages, QAfterFilterCondition> contentEndsWith(
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

  QueryBuilder<Messages, Messages, QAfterFilterCondition> contentContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'content',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Messages, Messages, QAfterFilterCondition> contentMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'content',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Messages, Messages, QAfterFilterCondition> deleteFlgEqualTo(
      bool value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'deleteFlg',
      value: value,
    ));
  }

  QueryBuilder<Messages, Messages, QAfterFilterCondition> fileNameSuffixEqualTo(
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

  QueryBuilder<Messages, Messages, QAfterFilterCondition>
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

  QueryBuilder<Messages, Messages, QAfterFilterCondition>
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

  QueryBuilder<Messages, Messages, QAfterFilterCondition> fileNameSuffixBetween(
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

  QueryBuilder<Messages, Messages, QAfterFilterCondition>
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

  QueryBuilder<Messages, Messages, QAfterFilterCondition>
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

  QueryBuilder<Messages, Messages, QAfterFilterCondition>
      fileNameSuffixContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'fileNameSuffix',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Messages, Messages, QAfterFilterCondition> fileNameSuffixMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'fileNameSuffix',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Messages, Messages, QAfterFilterCondition> friendUserDocEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'friendUserDoc',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Messages, Messages, QAfterFilterCondition>
      friendUserDocGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'friendUserDoc',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Messages, Messages, QAfterFilterCondition> friendUserDocLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'friendUserDoc',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Messages, Messages, QAfterFilterCondition> friendUserDocBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'friendUserDoc',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Messages, Messages, QAfterFilterCondition>
      friendUserDocStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'friendUserDoc',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Messages, Messages, QAfterFilterCondition> friendUserDocEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'friendUserDoc',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Messages, Messages, QAfterFilterCondition> friendUserDocContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'friendUserDoc',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Messages, Messages, QAfterFilterCondition> friendUserDocMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'friendUserDoc',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Messages, Messages, QAfterFilterCondition> idIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'id',
      value: null,
    ));
  }

  QueryBuilder<Messages, Messages, QAfterFilterCondition> idEqualTo(
      int? value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<Messages, Messages, QAfterFilterCondition> idGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<Messages, Messages, QAfterFilterCondition> idLessThan(
    int? value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<Messages, Messages, QAfterFilterCondition> idBetween(
    int? lower,
    int? upper, {
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

  QueryBuilder<Messages, Messages, QAfterFilterCondition>
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

  QueryBuilder<Messages, Messages, QAfterFilterCondition>
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

  QueryBuilder<Messages, Messages, QAfterFilterCondition>
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

  QueryBuilder<Messages, Messages, QAfterFilterCondition>
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

  QueryBuilder<Messages, Messages, QAfterFilterCondition>
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

  QueryBuilder<Messages, Messages, QAfterFilterCondition>
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

  QueryBuilder<Messages, Messages, QAfterFilterCondition>
      insertProgramIdContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'insertProgramId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Messages, Messages, QAfterFilterCondition>
      insertProgramIdMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'insertProgramId',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Messages, Messages, QAfterFilterCondition> insertTimeEqualTo(
      DateTime value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'insertTime',
      value: value,
    ));
  }

  QueryBuilder<Messages, Messages, QAfterFilterCondition> insertTimeGreaterThan(
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

  QueryBuilder<Messages, Messages, QAfterFilterCondition> insertTimeLessThan(
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

  QueryBuilder<Messages, Messages, QAfterFilterCondition> insertTimeBetween(
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

  QueryBuilder<Messages, Messages, QAfterFilterCondition>
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

  QueryBuilder<Messages, Messages, QAfterFilterCondition>
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

  QueryBuilder<Messages, Messages, QAfterFilterCondition>
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

  QueryBuilder<Messages, Messages, QAfterFilterCondition>
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

  QueryBuilder<Messages, Messages, QAfterFilterCondition>
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

  QueryBuilder<Messages, Messages, QAfterFilterCondition>
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

  QueryBuilder<Messages, Messages, QAfterFilterCondition>
      insertUserDocIdContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'insertUserDocId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Messages, Messages, QAfterFilterCondition>
      insertUserDocIdMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'insertUserDocId',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Messages, Messages, QAfterFilterCondition> messageDocIdEqualTo(
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

  QueryBuilder<Messages, Messages, QAfterFilterCondition>
      messageDocIdGreaterThan(
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

  QueryBuilder<Messages, Messages, QAfterFilterCondition> messageDocIdLessThan(
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

  QueryBuilder<Messages, Messages, QAfterFilterCondition> messageDocIdBetween(
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

  QueryBuilder<Messages, Messages, QAfterFilterCondition>
      messageDocIdStartsWith(
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

  QueryBuilder<Messages, Messages, QAfterFilterCondition> messageDocIdEndsWith(
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

  QueryBuilder<Messages, Messages, QAfterFilterCondition> messageDocIdContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'messageDocId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Messages, Messages, QAfterFilterCondition> messageDocIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'messageDocId',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Messages, Messages, QAfterFilterCondition> messageTypeEqualTo(
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

  QueryBuilder<Messages, Messages, QAfterFilterCondition>
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

  QueryBuilder<Messages, Messages, QAfterFilterCondition> messageTypeLessThan(
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

  QueryBuilder<Messages, Messages, QAfterFilterCondition> messageTypeBetween(
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

  QueryBuilder<Messages, Messages, QAfterFilterCondition> messageTypeStartsWith(
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

  QueryBuilder<Messages, Messages, QAfterFilterCondition> messageTypeEndsWith(
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

  QueryBuilder<Messages, Messages, QAfterFilterCondition> messageTypeContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'messageType',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Messages, Messages, QAfterFilterCondition> messageTypeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'messageType',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Messages, Messages, QAfterFilterCondition> readableFlgEqualTo(
      bool value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'readableFlg',
      value: value,
    ));
  }

  QueryBuilder<Messages, Messages, QAfterFilterCondition> receiveSendTyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'receiveSendTy',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Messages, Messages, QAfterFilterCondition>
      receiveSendTyGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'receiveSendTy',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Messages, Messages, QAfterFilterCondition> receiveSendTyLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'receiveSendTy',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Messages, Messages, QAfterFilterCondition> receiveSendTyBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'receiveSendTy',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Messages, Messages, QAfterFilterCondition>
      receiveSendTyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'receiveSendTy',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Messages, Messages, QAfterFilterCondition> receiveSendTyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'receiveSendTy',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Messages, Messages, QAfterFilterCondition> receiveSendTyContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'receiveSendTy',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Messages, Messages, QAfterFilterCondition> receiveSendTyMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'receiveSendTy',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Messages, Messages, QAfterFilterCondition> sendTimeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'sendTime',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Messages, Messages, QAfterFilterCondition> sendTimeGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'sendTime',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Messages, Messages, QAfterFilterCondition> sendTimeLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'sendTime',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Messages, Messages, QAfterFilterCondition> sendTimeBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'sendTime',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Messages, Messages, QAfterFilterCondition> sendTimeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'sendTime',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Messages, Messages, QAfterFilterCondition> sendTimeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'sendTime',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Messages, Messages, QAfterFilterCondition> sendTimeContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'sendTime',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Messages, Messages, QAfterFilterCondition> sendTimeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'sendTime',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Messages, Messages, QAfterFilterCondition>
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

  QueryBuilder<Messages, Messages, QAfterFilterCondition>
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

  QueryBuilder<Messages, Messages, QAfterFilterCondition>
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

  QueryBuilder<Messages, Messages, QAfterFilterCondition>
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

  QueryBuilder<Messages, Messages, QAfterFilterCondition>
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

  QueryBuilder<Messages, Messages, QAfterFilterCondition>
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

  QueryBuilder<Messages, Messages, QAfterFilterCondition>
      updateProgramIdContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'updateProgramId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Messages, Messages, QAfterFilterCondition>
      updateProgramIdMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'updateProgramId',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Messages, Messages, QAfterFilterCondition> updateTimeEqualTo(
      DateTime value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'updateTime',
      value: value,
    ));
  }

  QueryBuilder<Messages, Messages, QAfterFilterCondition> updateTimeGreaterThan(
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

  QueryBuilder<Messages, Messages, QAfterFilterCondition> updateTimeLessThan(
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

  QueryBuilder<Messages, Messages, QAfterFilterCondition> updateTimeBetween(
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

  QueryBuilder<Messages, Messages, QAfterFilterCondition>
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

  QueryBuilder<Messages, Messages, QAfterFilterCondition>
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

  QueryBuilder<Messages, Messages, QAfterFilterCondition>
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

  QueryBuilder<Messages, Messages, QAfterFilterCondition>
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

  QueryBuilder<Messages, Messages, QAfterFilterCondition>
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

  QueryBuilder<Messages, Messages, QAfterFilterCondition>
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

  QueryBuilder<Messages, Messages, QAfterFilterCondition>
      updateUserDocIdContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'updateUserDocId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Messages, Messages, QAfterFilterCondition>
      updateUserDocIdMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'updateUserDocId',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Messages, Messages, QAfterFilterCondition> userDocIdEqualTo(
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

  QueryBuilder<Messages, Messages, QAfterFilterCondition> userDocIdGreaterThan(
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

  QueryBuilder<Messages, Messages, QAfterFilterCondition> userDocIdLessThan(
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

  QueryBuilder<Messages, Messages, QAfterFilterCondition> userDocIdBetween(
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

  QueryBuilder<Messages, Messages, QAfterFilterCondition> userDocIdStartsWith(
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

  QueryBuilder<Messages, Messages, QAfterFilterCondition> userDocIdEndsWith(
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

  QueryBuilder<Messages, Messages, QAfterFilterCondition> userDocIdContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'userDocId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Messages, Messages, QAfterFilterCondition> userDocIdMatches(
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

extension MessagesQueryLinks
    on QueryBuilder<Messages, Messages, QFilterCondition> {}

extension MessagesQueryWhereSortBy
    on QueryBuilder<Messages, Messages, QSortBy> {
  QueryBuilder<Messages, Messages, QAfterSortBy> sortByCallChannelId() {
    return addSortByInternal('callChannelId', Sort.asc);
  }

  QueryBuilder<Messages, Messages, QAfterSortBy> sortByCallChannelIdDesc() {
    return addSortByInternal('callChannelId', Sort.desc);
  }

  QueryBuilder<Messages, Messages, QAfterSortBy> sortByContent() {
    return addSortByInternal('content', Sort.asc);
  }

  QueryBuilder<Messages, Messages, QAfterSortBy> sortByContentDesc() {
    return addSortByInternal('content', Sort.desc);
  }

  QueryBuilder<Messages, Messages, QAfterSortBy> sortByDeleteFlg() {
    return addSortByInternal('deleteFlg', Sort.asc);
  }

  QueryBuilder<Messages, Messages, QAfterSortBy> sortByDeleteFlgDesc() {
    return addSortByInternal('deleteFlg', Sort.desc);
  }

  QueryBuilder<Messages, Messages, QAfterSortBy> sortByFileNameSuffix() {
    return addSortByInternal('fileNameSuffix', Sort.asc);
  }

  QueryBuilder<Messages, Messages, QAfterSortBy> sortByFileNameSuffixDesc() {
    return addSortByInternal('fileNameSuffix', Sort.desc);
  }

  QueryBuilder<Messages, Messages, QAfterSortBy> sortByFriendUserDoc() {
    return addSortByInternal('friendUserDoc', Sort.asc);
  }

  QueryBuilder<Messages, Messages, QAfterSortBy> sortByFriendUserDocDesc() {
    return addSortByInternal('friendUserDoc', Sort.desc);
  }

  QueryBuilder<Messages, Messages, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<Messages, Messages, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<Messages, Messages, QAfterSortBy> sortByInsertProgramId() {
    return addSortByInternal('insertProgramId', Sort.asc);
  }

  QueryBuilder<Messages, Messages, QAfterSortBy> sortByInsertProgramIdDesc() {
    return addSortByInternal('insertProgramId', Sort.desc);
  }

  QueryBuilder<Messages, Messages, QAfterSortBy> sortByInsertTime() {
    return addSortByInternal('insertTime', Sort.asc);
  }

  QueryBuilder<Messages, Messages, QAfterSortBy> sortByInsertTimeDesc() {
    return addSortByInternal('insertTime', Sort.desc);
  }

  QueryBuilder<Messages, Messages, QAfterSortBy> sortByInsertUserDocId() {
    return addSortByInternal('insertUserDocId', Sort.asc);
  }

  QueryBuilder<Messages, Messages, QAfterSortBy> sortByInsertUserDocIdDesc() {
    return addSortByInternal('insertUserDocId', Sort.desc);
  }

  QueryBuilder<Messages, Messages, QAfterSortBy> sortByMessageDocId() {
    return addSortByInternal('messageDocId', Sort.asc);
  }

  QueryBuilder<Messages, Messages, QAfterSortBy> sortByMessageDocIdDesc() {
    return addSortByInternal('messageDocId', Sort.desc);
  }

  QueryBuilder<Messages, Messages, QAfterSortBy> sortByMessageType() {
    return addSortByInternal('messageType', Sort.asc);
  }

  QueryBuilder<Messages, Messages, QAfterSortBy> sortByMessageTypeDesc() {
    return addSortByInternal('messageType', Sort.desc);
  }

  QueryBuilder<Messages, Messages, QAfterSortBy> sortByReadableFlg() {
    return addSortByInternal('readableFlg', Sort.asc);
  }

  QueryBuilder<Messages, Messages, QAfterSortBy> sortByReadableFlgDesc() {
    return addSortByInternal('readableFlg', Sort.desc);
  }

  QueryBuilder<Messages, Messages, QAfterSortBy> sortByReceiveSendTy() {
    return addSortByInternal('receiveSendTy', Sort.asc);
  }

  QueryBuilder<Messages, Messages, QAfterSortBy> sortByReceiveSendTyDesc() {
    return addSortByInternal('receiveSendTy', Sort.desc);
  }

  QueryBuilder<Messages, Messages, QAfterSortBy> sortBySendTime() {
    return addSortByInternal('sendTime', Sort.asc);
  }

  QueryBuilder<Messages, Messages, QAfterSortBy> sortBySendTimeDesc() {
    return addSortByInternal('sendTime', Sort.desc);
  }

  QueryBuilder<Messages, Messages, QAfterSortBy> sortByUpdateProgramId() {
    return addSortByInternal('updateProgramId', Sort.asc);
  }

  QueryBuilder<Messages, Messages, QAfterSortBy> sortByUpdateProgramIdDesc() {
    return addSortByInternal('updateProgramId', Sort.desc);
  }

  QueryBuilder<Messages, Messages, QAfterSortBy> sortByUpdateTime() {
    return addSortByInternal('updateTime', Sort.asc);
  }

  QueryBuilder<Messages, Messages, QAfterSortBy> sortByUpdateTimeDesc() {
    return addSortByInternal('updateTime', Sort.desc);
  }

  QueryBuilder<Messages, Messages, QAfterSortBy> sortByUpdateUserDocId() {
    return addSortByInternal('updateUserDocId', Sort.asc);
  }

  QueryBuilder<Messages, Messages, QAfterSortBy> sortByUpdateUserDocIdDesc() {
    return addSortByInternal('updateUserDocId', Sort.desc);
  }

  QueryBuilder<Messages, Messages, QAfterSortBy> sortByUserDocId() {
    return addSortByInternal('userDocId', Sort.asc);
  }

  QueryBuilder<Messages, Messages, QAfterSortBy> sortByUserDocIdDesc() {
    return addSortByInternal('userDocId', Sort.desc);
  }
}

extension MessagesQueryWhereSortThenBy
    on QueryBuilder<Messages, Messages, QSortThenBy> {
  QueryBuilder<Messages, Messages, QAfterSortBy> thenByCallChannelId() {
    return addSortByInternal('callChannelId', Sort.asc);
  }

  QueryBuilder<Messages, Messages, QAfterSortBy> thenByCallChannelIdDesc() {
    return addSortByInternal('callChannelId', Sort.desc);
  }

  QueryBuilder<Messages, Messages, QAfterSortBy> thenByContent() {
    return addSortByInternal('content', Sort.asc);
  }

  QueryBuilder<Messages, Messages, QAfterSortBy> thenByContentDesc() {
    return addSortByInternal('content', Sort.desc);
  }

  QueryBuilder<Messages, Messages, QAfterSortBy> thenByDeleteFlg() {
    return addSortByInternal('deleteFlg', Sort.asc);
  }

  QueryBuilder<Messages, Messages, QAfterSortBy> thenByDeleteFlgDesc() {
    return addSortByInternal('deleteFlg', Sort.desc);
  }

  QueryBuilder<Messages, Messages, QAfterSortBy> thenByFileNameSuffix() {
    return addSortByInternal('fileNameSuffix', Sort.asc);
  }

  QueryBuilder<Messages, Messages, QAfterSortBy> thenByFileNameSuffixDesc() {
    return addSortByInternal('fileNameSuffix', Sort.desc);
  }

  QueryBuilder<Messages, Messages, QAfterSortBy> thenByFriendUserDoc() {
    return addSortByInternal('friendUserDoc', Sort.asc);
  }

  QueryBuilder<Messages, Messages, QAfterSortBy> thenByFriendUserDocDesc() {
    return addSortByInternal('friendUserDoc', Sort.desc);
  }

  QueryBuilder<Messages, Messages, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<Messages, Messages, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<Messages, Messages, QAfterSortBy> thenByInsertProgramId() {
    return addSortByInternal('insertProgramId', Sort.asc);
  }

  QueryBuilder<Messages, Messages, QAfterSortBy> thenByInsertProgramIdDesc() {
    return addSortByInternal('insertProgramId', Sort.desc);
  }

  QueryBuilder<Messages, Messages, QAfterSortBy> thenByInsertTime() {
    return addSortByInternal('insertTime', Sort.asc);
  }

  QueryBuilder<Messages, Messages, QAfterSortBy> thenByInsertTimeDesc() {
    return addSortByInternal('insertTime', Sort.desc);
  }

  QueryBuilder<Messages, Messages, QAfterSortBy> thenByInsertUserDocId() {
    return addSortByInternal('insertUserDocId', Sort.asc);
  }

  QueryBuilder<Messages, Messages, QAfterSortBy> thenByInsertUserDocIdDesc() {
    return addSortByInternal('insertUserDocId', Sort.desc);
  }

  QueryBuilder<Messages, Messages, QAfterSortBy> thenByMessageDocId() {
    return addSortByInternal('messageDocId', Sort.asc);
  }

  QueryBuilder<Messages, Messages, QAfterSortBy> thenByMessageDocIdDesc() {
    return addSortByInternal('messageDocId', Sort.desc);
  }

  QueryBuilder<Messages, Messages, QAfterSortBy> thenByMessageType() {
    return addSortByInternal('messageType', Sort.asc);
  }

  QueryBuilder<Messages, Messages, QAfterSortBy> thenByMessageTypeDesc() {
    return addSortByInternal('messageType', Sort.desc);
  }

  QueryBuilder<Messages, Messages, QAfterSortBy> thenByReadableFlg() {
    return addSortByInternal('readableFlg', Sort.asc);
  }

  QueryBuilder<Messages, Messages, QAfterSortBy> thenByReadableFlgDesc() {
    return addSortByInternal('readableFlg', Sort.desc);
  }

  QueryBuilder<Messages, Messages, QAfterSortBy> thenByReceiveSendTy() {
    return addSortByInternal('receiveSendTy', Sort.asc);
  }

  QueryBuilder<Messages, Messages, QAfterSortBy> thenByReceiveSendTyDesc() {
    return addSortByInternal('receiveSendTy', Sort.desc);
  }

  QueryBuilder<Messages, Messages, QAfterSortBy> thenBySendTime() {
    return addSortByInternal('sendTime', Sort.asc);
  }

  QueryBuilder<Messages, Messages, QAfterSortBy> thenBySendTimeDesc() {
    return addSortByInternal('sendTime', Sort.desc);
  }

  QueryBuilder<Messages, Messages, QAfterSortBy> thenByUpdateProgramId() {
    return addSortByInternal('updateProgramId', Sort.asc);
  }

  QueryBuilder<Messages, Messages, QAfterSortBy> thenByUpdateProgramIdDesc() {
    return addSortByInternal('updateProgramId', Sort.desc);
  }

  QueryBuilder<Messages, Messages, QAfterSortBy> thenByUpdateTime() {
    return addSortByInternal('updateTime', Sort.asc);
  }

  QueryBuilder<Messages, Messages, QAfterSortBy> thenByUpdateTimeDesc() {
    return addSortByInternal('updateTime', Sort.desc);
  }

  QueryBuilder<Messages, Messages, QAfterSortBy> thenByUpdateUserDocId() {
    return addSortByInternal('updateUserDocId', Sort.asc);
  }

  QueryBuilder<Messages, Messages, QAfterSortBy> thenByUpdateUserDocIdDesc() {
    return addSortByInternal('updateUserDocId', Sort.desc);
  }

  QueryBuilder<Messages, Messages, QAfterSortBy> thenByUserDocId() {
    return addSortByInternal('userDocId', Sort.asc);
  }

  QueryBuilder<Messages, Messages, QAfterSortBy> thenByUserDocIdDesc() {
    return addSortByInternal('userDocId', Sort.desc);
  }
}

extension MessagesQueryWhereDistinct
    on QueryBuilder<Messages, Messages, QDistinct> {
  QueryBuilder<Messages, Messages, QDistinct> distinctByCallChannelId(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('callChannelId', caseSensitive: caseSensitive);
  }

  QueryBuilder<Messages, Messages, QDistinct> distinctByContent(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('content', caseSensitive: caseSensitive);
  }

  QueryBuilder<Messages, Messages, QDistinct> distinctByDeleteFlg() {
    return addDistinctByInternal('deleteFlg');
  }

  QueryBuilder<Messages, Messages, QDistinct> distinctByFileNameSuffix(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('fileNameSuffix',
        caseSensitive: caseSensitive);
  }

  QueryBuilder<Messages, Messages, QDistinct> distinctByFriendUserDoc(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('friendUserDoc', caseSensitive: caseSensitive);
  }

  QueryBuilder<Messages, Messages, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<Messages, Messages, QDistinct> distinctByInsertProgramId(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('insertProgramId',
        caseSensitive: caseSensitive);
  }

  QueryBuilder<Messages, Messages, QDistinct> distinctByInsertTime() {
    return addDistinctByInternal('insertTime');
  }

  QueryBuilder<Messages, Messages, QDistinct> distinctByInsertUserDocId(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('insertUserDocId',
        caseSensitive: caseSensitive);
  }

  QueryBuilder<Messages, Messages, QDistinct> distinctByMessageDocId(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('messageDocId', caseSensitive: caseSensitive);
  }

  QueryBuilder<Messages, Messages, QDistinct> distinctByMessageType(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('messageType', caseSensitive: caseSensitive);
  }

  QueryBuilder<Messages, Messages, QDistinct> distinctByReadableFlg() {
    return addDistinctByInternal('readableFlg');
  }

  QueryBuilder<Messages, Messages, QDistinct> distinctByReceiveSendTy(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('receiveSendTy', caseSensitive: caseSensitive);
  }

  QueryBuilder<Messages, Messages, QDistinct> distinctBySendTime(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('sendTime', caseSensitive: caseSensitive);
  }

  QueryBuilder<Messages, Messages, QDistinct> distinctByUpdateProgramId(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('updateProgramId',
        caseSensitive: caseSensitive);
  }

  QueryBuilder<Messages, Messages, QDistinct> distinctByUpdateTime() {
    return addDistinctByInternal('updateTime');
  }

  QueryBuilder<Messages, Messages, QDistinct> distinctByUpdateUserDocId(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('updateUserDocId',
        caseSensitive: caseSensitive);
  }

  QueryBuilder<Messages, Messages, QDistinct> distinctByUserDocId(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('userDocId', caseSensitive: caseSensitive);
  }
}

extension MessagesQueryProperty
    on QueryBuilder<Messages, Messages, QQueryProperty> {
  QueryBuilder<Messages, String, QQueryOperations> callChannelIdProperty() {
    return addPropertyNameInternal('callChannelId');
  }

  QueryBuilder<Messages, String, QQueryOperations> contentProperty() {
    return addPropertyNameInternal('content');
  }

  QueryBuilder<Messages, bool, QQueryOperations> deleteFlgProperty() {
    return addPropertyNameInternal('deleteFlg');
  }

  QueryBuilder<Messages, String, QQueryOperations> fileNameSuffixProperty() {
    return addPropertyNameInternal('fileNameSuffix');
  }

  QueryBuilder<Messages, String, QQueryOperations> friendUserDocProperty() {
    return addPropertyNameInternal('friendUserDoc');
  }

  QueryBuilder<Messages, int?, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<Messages, String, QQueryOperations> insertProgramIdProperty() {
    return addPropertyNameInternal('insertProgramId');
  }

  QueryBuilder<Messages, DateTime, QQueryOperations> insertTimeProperty() {
    return addPropertyNameInternal('insertTime');
  }

  QueryBuilder<Messages, String, QQueryOperations> insertUserDocIdProperty() {
    return addPropertyNameInternal('insertUserDocId');
  }

  QueryBuilder<Messages, String, QQueryOperations> messageDocIdProperty() {
    return addPropertyNameInternal('messageDocId');
  }

  QueryBuilder<Messages, String, QQueryOperations> messageTypeProperty() {
    return addPropertyNameInternal('messageType');
  }

  QueryBuilder<Messages, bool, QQueryOperations> readableFlgProperty() {
    return addPropertyNameInternal('readableFlg');
  }

  QueryBuilder<Messages, String, QQueryOperations> receiveSendTyProperty() {
    return addPropertyNameInternal('receiveSendTy');
  }

  QueryBuilder<Messages, String, QQueryOperations> sendTimeProperty() {
    return addPropertyNameInternal('sendTime');
  }

  QueryBuilder<Messages, String, QQueryOperations> updateProgramIdProperty() {
    return addPropertyNameInternal('updateProgramId');
  }

  QueryBuilder<Messages, DateTime, QQueryOperations> updateTimeProperty() {
    return addPropertyNameInternal('updateTime');
  }

  QueryBuilder<Messages, String, QQueryOperations> updateUserDocIdProperty() {
    return addPropertyNameInternal('updateUserDocId');
  }

  QueryBuilder<Messages, String, QQueryOperations> userDocIdProperty() {
    return addPropertyNameInternal('userDocId');
  }
}
