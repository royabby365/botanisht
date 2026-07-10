// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'isar_user_plant.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetUserPlantCollection on Isar {
  IsarCollection<UserPlant> get userPlants => this.collection();
}

const UserPlantSchema = CollectionSchema(
  name: r'UserPlant',
  id: 4940293299892499075,
  properties: {
    r'acquiredDate': PropertySchema(
      id: 0,
      name: r'acquiredDate',
      type: IsarType.dateTime,
    ),
    r'customName': PropertySchema(
      id: 1,
      name: r'customName',
      type: IsarType.string,
    ),
    r'fertilizingReminderEnabled': PropertySchema(
      id: 2,
      name: r'fertilizingReminderEnabled',
      type: IsarType.bool,
    ),
    r'fertilizingSchedule': PropertySchema(
      id: 3,
      name: r'fertilizingSchedule',
      type: IsarType.string,
    ),
    r'healthNotes': PropertySchema(
      id: 4,
      name: r'healthNotes',
      type: IsarType.stringList,
    ),
    r'healthStatus': PropertySchema(
      id: 5,
      name: r'healthStatus',
      type: IsarType.string,
    ),
    r'heightCm': PropertySchema(
      id: 6,
      name: r'heightCm',
      type: IsarType.double,
    ),
    r'humidityLevel': PropertySchema(
      id: 7,
      name: r'humidityLevel',
      type: IsarType.string,
    ),
    r'isPetSafe': PropertySchema(
      id: 8,
      name: r'isPetSafe',
      type: IsarType.bool,
    ),
    r'lastFertilized': PropertySchema(
      id: 9,
      name: r'lastFertilized',
      type: IsarType.dateTime,
    ),
    r'lastMeasured': PropertySchema(
      id: 10,
      name: r'lastMeasured',
      type: IsarType.dateTime,
    ),
    r'lastPruned': PropertySchema(
      id: 11,
      name: r'lastPruned',
      type: IsarType.dateTime,
    ),
    r'lastWatered': PropertySchema(
      id: 12,
      name: r'lastWatered',
      type: IsarType.dateTime,
    ),
    r'lightConditions': PropertySchema(
      id: 13,
      name: r'lightConditions',
      type: IsarType.string,
    ),
    r'lightExposure': PropertySchema(
      id: 14,
      name: r'lightExposure',
      type: IsarType.long,
    ),
    r'location': PropertySchema(
      id: 15,
      name: r'location',
      type: IsarType.string,
    ),
    r'photoPaths': PropertySchema(
      id: 16,
      name: r'photoPaths',
      type: IsarType.stringList,
    ),
    r'plantEntityId': PropertySchema(
      id: 17,
      name: r'plantEntityId',
      type: IsarType.long,
    ),
    r'potSize': PropertySchema(
      id: 18,
      name: r'potSize',
      type: IsarType.string,
    ),
    r'pruningReminderEnabled': PropertySchema(
      id: 19,
      name: r'pruningReminderEnabled',
      type: IsarType.bool,
    ),
    r'pruningSchedule': PropertySchema(
      id: 20,
      name: r'pruningSchedule',
      type: IsarType.string,
    ),
    r'quantity': PropertySchema(
      id: 21,
      name: r'quantity',
      type: IsarType.long,
    ),
    r'soilType': PropertySchema(
      id: 22,
      name: r'soilType',
      type: IsarType.string,
    ),
    r'source': PropertySchema(
      id: 23,
      name: r'source',
      type: IsarType.string,
    ),
    r'tags': PropertySchema(
      id: 24,
      name: r'tags',
      type: IsarType.stringList,
    ),
    r'temperatureRange': PropertySchema(
      id: 25,
      name: r'temperatureRange',
      type: IsarType.string,
    ),
    r'wateringReminderEnabled': PropertySchema(
      id: 26,
      name: r'wateringReminderEnabled',
      type: IsarType.bool,
    ),
    r'wateringSchedule': PropertySchema(
      id: 27,
      name: r'wateringSchedule',
      type: IsarType.string,
    ),
    r'widthCm': PropertySchema(
      id: 28,
      name: r'widthCm',
      type: IsarType.double,
    ),
    r'zone': PropertySchema(
      id: 29,
      name: r'zone',
      type: IsarType.string,
    )
  },
  estimateSize: _userPlantEstimateSize,
  serialize: _userPlantSerialize,
  deserialize: _userPlantDeserialize,
  deserializeProp: _userPlantDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _userPlantGetId,
  getLinks: _userPlantGetLinks,
  attach: _userPlantAttach,
  version: '3.1.0+1',
);

int _userPlantEstimateSize(
  UserPlant object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.customName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.fertilizingSchedule;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final list = object.healthNotes;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += value.length * 3;
        }
      }
    }
  }
  {
    final value = object.healthStatus;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.humidityLevel;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.lightConditions;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.location;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final list = object.photoPaths;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += value.length * 3;
        }
      }
    }
  }
  {
    final value = object.potSize;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.pruningSchedule;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.soilType;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.source;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final list = object.tags;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += value.length * 3;
        }
      }
    }
  }
  {
    final value = object.temperatureRange;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.wateringSchedule;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.zone;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _userPlantSerialize(
  UserPlant object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.acquiredDate);
  writer.writeString(offsets[1], object.customName);
  writer.writeBool(offsets[2], object.fertilizingReminderEnabled);
  writer.writeString(offsets[3], object.fertilizingSchedule);
  writer.writeStringList(offsets[4], object.healthNotes);
  writer.writeString(offsets[5], object.healthStatus);
  writer.writeDouble(offsets[6], object.heightCm);
  writer.writeString(offsets[7], object.humidityLevel);
  writer.writeBool(offsets[8], object.isPetSafe);
  writer.writeDateTime(offsets[9], object.lastFertilized);
  writer.writeDateTime(offsets[10], object.lastMeasured);
  writer.writeDateTime(offsets[11], object.lastPruned);
  writer.writeDateTime(offsets[12], object.lastWatered);
  writer.writeString(offsets[13], object.lightConditions);
  writer.writeLong(offsets[14], object.lightExposure);
  writer.writeString(offsets[15], object.location);
  writer.writeStringList(offsets[16], object.photoPaths);
  writer.writeLong(offsets[17], object.plantEntityId);
  writer.writeString(offsets[18], object.potSize);
  writer.writeBool(offsets[19], object.pruningReminderEnabled);
  writer.writeString(offsets[20], object.pruningSchedule);
  writer.writeLong(offsets[21], object.quantity);
  writer.writeString(offsets[22], object.soilType);
  writer.writeString(offsets[23], object.source);
  writer.writeStringList(offsets[24], object.tags);
  writer.writeString(offsets[25], object.temperatureRange);
  writer.writeBool(offsets[26], object.wateringReminderEnabled);
  writer.writeString(offsets[27], object.wateringSchedule);
  writer.writeDouble(offsets[28], object.widthCm);
  writer.writeString(offsets[29], object.zone);
}

UserPlant _userPlantDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = UserPlant();
  object.acquiredDate = reader.readDateTimeOrNull(offsets[0]);
  object.customName = reader.readStringOrNull(offsets[1]);
  object.fertilizingReminderEnabled = reader.readBool(offsets[2]);
  object.fertilizingSchedule = reader.readStringOrNull(offsets[3]);
  object.healthNotes = reader.readStringList(offsets[4]);
  object.healthStatus = reader.readStringOrNull(offsets[5]);
  object.heightCm = reader.readDoubleOrNull(offsets[6]);
  object.humidityLevel = reader.readStringOrNull(offsets[7]);
  object.id = id;
  object.isPetSafe = reader.readBoolOrNull(offsets[8]);
  object.lastFertilized = reader.readDateTimeOrNull(offsets[9]);
  object.lastMeasured = reader.readDateTimeOrNull(offsets[10]);
  object.lastPruned = reader.readDateTimeOrNull(offsets[11]);
  object.lastWatered = reader.readDateTimeOrNull(offsets[12]);
  object.lightConditions = reader.readStringOrNull(offsets[13]);
  object.lightExposure = reader.readLong(offsets[14]);
  object.location = reader.readStringOrNull(offsets[15]);
  object.photoPaths = reader.readStringList(offsets[16]);
  object.plantEntityId = reader.readLongOrNull(offsets[17]);
  object.potSize = reader.readStringOrNull(offsets[18]);
  object.pruningReminderEnabled = reader.readBool(offsets[19]);
  object.pruningSchedule = reader.readStringOrNull(offsets[20]);
  object.quantity = reader.readLong(offsets[21]);
  object.soilType = reader.readStringOrNull(offsets[22]);
  object.source = reader.readStringOrNull(offsets[23]);
  object.tags = reader.readStringList(offsets[24]);
  object.temperatureRange = reader.readStringOrNull(offsets[25]);
  object.wateringReminderEnabled = reader.readBool(offsets[26]);
  object.wateringSchedule = reader.readStringOrNull(offsets[27]);
  object.widthCm = reader.readDoubleOrNull(offsets[28]);
  object.zone = reader.readStringOrNull(offsets[29]);
  return object;
}

P _userPlantDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readStringList(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readDoubleOrNull(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readBoolOrNull(offset)) as P;
    case 9:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 10:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 11:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 12:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 13:
      return (reader.readStringOrNull(offset)) as P;
    case 14:
      return (reader.readLong(offset)) as P;
    case 15:
      return (reader.readStringOrNull(offset)) as P;
    case 16:
      return (reader.readStringList(offset)) as P;
    case 17:
      return (reader.readLongOrNull(offset)) as P;
    case 18:
      return (reader.readStringOrNull(offset)) as P;
    case 19:
      return (reader.readBool(offset)) as P;
    case 20:
      return (reader.readStringOrNull(offset)) as P;
    case 21:
      return (reader.readLong(offset)) as P;
    case 22:
      return (reader.readStringOrNull(offset)) as P;
    case 23:
      return (reader.readStringOrNull(offset)) as P;
    case 24:
      return (reader.readStringList(offset)) as P;
    case 25:
      return (reader.readStringOrNull(offset)) as P;
    case 26:
      return (reader.readBool(offset)) as P;
    case 27:
      return (reader.readStringOrNull(offset)) as P;
    case 28:
      return (reader.readDoubleOrNull(offset)) as P;
    case 29:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _userPlantGetId(UserPlant object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _userPlantGetLinks(UserPlant object) {
  return [];
}

void _userPlantAttach(IsarCollection<dynamic> col, Id id, UserPlant object) {
  object.id = id;
}

extension UserPlantQueryWhereSort
    on QueryBuilder<UserPlant, UserPlant, QWhere> {
  QueryBuilder<UserPlant, UserPlant, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension UserPlantQueryWhere
    on QueryBuilder<UserPlant, UserPlant, QWhereClause> {
  QueryBuilder<UserPlant, UserPlant, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension UserPlantQueryFilter
    on QueryBuilder<UserPlant, UserPlant, QFilterCondition> {
  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      acquiredDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'acquiredDate',
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      acquiredDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'acquiredDate',
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> acquiredDateEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'acquiredDate',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      acquiredDateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'acquiredDate',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      acquiredDateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'acquiredDate',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> acquiredDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'acquiredDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> customNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'customName',
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      customNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'customName',
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> customNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'customName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      customNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'customName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> customNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'customName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> customNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'customName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      customNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'customName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> customNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'customName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> customNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'customName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> customNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'customName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      customNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'customName',
        value: '',
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      customNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'customName',
        value: '',
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      fertilizingReminderEnabledEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fertilizingReminderEnabled',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      fertilizingScheduleIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fertilizingSchedule',
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      fertilizingScheduleIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fertilizingSchedule',
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      fertilizingScheduleEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fertilizingSchedule',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      fertilizingScheduleGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fertilizingSchedule',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      fertilizingScheduleLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fertilizingSchedule',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      fertilizingScheduleBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fertilizingSchedule',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      fertilizingScheduleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'fertilizingSchedule',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      fertilizingScheduleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'fertilizingSchedule',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      fertilizingScheduleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'fertilizingSchedule',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      fertilizingScheduleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'fertilizingSchedule',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      fertilizingScheduleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fertilizingSchedule',
        value: '',
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      fertilizingScheduleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'fertilizingSchedule',
        value: '',
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      healthNotesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'healthNotes',
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      healthNotesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'healthNotes',
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      healthNotesElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'healthNotes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      healthNotesElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'healthNotes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      healthNotesElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'healthNotes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      healthNotesElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'healthNotes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      healthNotesElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'healthNotes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      healthNotesElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'healthNotes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      healthNotesElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'healthNotes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      healthNotesElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'healthNotes',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      healthNotesElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'healthNotes',
        value: '',
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      healthNotesElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'healthNotes',
        value: '',
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      healthNotesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'healthNotes',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      healthNotesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'healthNotes',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      healthNotesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'healthNotes',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      healthNotesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'healthNotes',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      healthNotesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'healthNotes',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      healthNotesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'healthNotes',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      healthStatusIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'healthStatus',
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      healthStatusIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'healthStatus',
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> healthStatusEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'healthStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      healthStatusGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'healthStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      healthStatusLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'healthStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> healthStatusBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'healthStatus',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      healthStatusStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'healthStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      healthStatusEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'healthStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      healthStatusContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'healthStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> healthStatusMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'healthStatus',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      healthStatusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'healthStatus',
        value: '',
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      healthStatusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'healthStatus',
        value: '',
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> heightCmIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'heightCm',
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      heightCmIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'heightCm',
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> heightCmEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'heightCm',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> heightCmGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'heightCm',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> heightCmLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'heightCm',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> heightCmBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'heightCm',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      humidityLevelIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'humidityLevel',
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      humidityLevelIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'humidityLevel',
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      humidityLevelEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'humidityLevel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      humidityLevelGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'humidityLevel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      humidityLevelLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'humidityLevel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      humidityLevelBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'humidityLevel',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      humidityLevelStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'humidityLevel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      humidityLevelEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'humidityLevel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      humidityLevelContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'humidityLevel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      humidityLevelMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'humidityLevel',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      humidityLevelIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'humidityLevel',
        value: '',
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      humidityLevelIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'humidityLevel',
        value: '',
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> isPetSafeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isPetSafe',
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      isPetSafeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isPetSafe',
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> isPetSafeEqualTo(
      bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isPetSafe',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      lastFertilizedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastFertilized',
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      lastFertilizedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastFertilized',
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      lastFertilizedEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastFertilized',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      lastFertilizedGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastFertilized',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      lastFertilizedLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastFertilized',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      lastFertilizedBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastFertilized',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      lastMeasuredIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastMeasured',
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      lastMeasuredIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastMeasured',
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> lastMeasuredEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastMeasured',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      lastMeasuredGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastMeasured',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      lastMeasuredLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastMeasured',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> lastMeasuredBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastMeasured',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> lastPrunedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastPruned',
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      lastPrunedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastPruned',
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> lastPrunedEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastPruned',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      lastPrunedGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastPruned',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> lastPrunedLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastPruned',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> lastPrunedBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastPruned',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      lastWateredIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastWatered',
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      lastWateredIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastWatered',
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> lastWateredEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastWatered',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      lastWateredGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastWatered',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> lastWateredLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastWatered',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> lastWateredBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastWatered',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      lightConditionsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lightConditions',
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      lightConditionsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lightConditions',
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      lightConditionsEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lightConditions',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      lightConditionsGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lightConditions',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      lightConditionsLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lightConditions',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      lightConditionsBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lightConditions',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      lightConditionsStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'lightConditions',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      lightConditionsEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'lightConditions',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      lightConditionsContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'lightConditions',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      lightConditionsMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'lightConditions',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      lightConditionsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lightConditions',
        value: '',
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      lightConditionsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'lightConditions',
        value: '',
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      lightExposureEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lightExposure',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      lightExposureGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lightExposure',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      lightExposureLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lightExposure',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      lightExposureBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lightExposure',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> locationIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'location',
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      locationIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'location',
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> locationEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'location',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> locationGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'location',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> locationLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'location',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> locationBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'location',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> locationStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'location',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> locationEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'location',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> locationContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'location',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> locationMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'location',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> locationIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'location',
        value: '',
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      locationIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'location',
        value: '',
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> photoPathsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'photoPaths',
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      photoPathsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'photoPaths',
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      photoPathsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'photoPaths',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      photoPathsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'photoPaths',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      photoPathsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'photoPaths',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      photoPathsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'photoPaths',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      photoPathsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'photoPaths',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      photoPathsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'photoPaths',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      photoPathsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'photoPaths',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      photoPathsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'photoPaths',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      photoPathsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'photoPaths',
        value: '',
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      photoPathsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'photoPaths',
        value: '',
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      photoPathsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'photoPaths',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      photoPathsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'photoPaths',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      photoPathsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'photoPaths',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      photoPathsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'photoPaths',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      photoPathsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'photoPaths',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      photoPathsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'photoPaths',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      plantEntityIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'plantEntityId',
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      plantEntityIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'plantEntityId',
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      plantEntityIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'plantEntityId',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      plantEntityIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'plantEntityId',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      plantEntityIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'plantEntityId',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      plantEntityIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'plantEntityId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> potSizeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'potSize',
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> potSizeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'potSize',
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> potSizeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'potSize',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> potSizeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'potSize',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> potSizeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'potSize',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> potSizeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'potSize',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> potSizeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'potSize',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> potSizeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'potSize',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> potSizeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'potSize',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> potSizeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'potSize',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> potSizeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'potSize',
        value: '',
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      potSizeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'potSize',
        value: '',
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      pruningReminderEnabledEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pruningReminderEnabled',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      pruningScheduleIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'pruningSchedule',
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      pruningScheduleIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'pruningSchedule',
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      pruningScheduleEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pruningSchedule',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      pruningScheduleGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pruningSchedule',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      pruningScheduleLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pruningSchedule',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      pruningScheduleBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pruningSchedule',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      pruningScheduleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'pruningSchedule',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      pruningScheduleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'pruningSchedule',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      pruningScheduleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'pruningSchedule',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      pruningScheduleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'pruningSchedule',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      pruningScheduleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pruningSchedule',
        value: '',
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      pruningScheduleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'pruningSchedule',
        value: '',
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> quantityEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quantity',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> quantityGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'quantity',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> quantityLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'quantity',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> quantityBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'quantity',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> soilTypeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'soilType',
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      soilTypeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'soilType',
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> soilTypeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'soilType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> soilTypeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'soilType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> soilTypeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'soilType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> soilTypeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'soilType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> soilTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'soilType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> soilTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'soilType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> soilTypeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'soilType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> soilTypeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'soilType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> soilTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'soilType',
        value: '',
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      soilTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'soilType',
        value: '',
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> sourceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'source',
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> sourceIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'source',
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> sourceEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'source',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> sourceGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'source',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> sourceLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'source',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> sourceBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'source',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> sourceStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'source',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> sourceEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'source',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> sourceContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'source',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> sourceMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'source',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> sourceIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'source',
        value: '',
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> sourceIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'source',
        value: '',
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> tagsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tags',
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> tagsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tags',
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> tagsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      tagsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> tagsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> tagsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tags',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      tagsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> tagsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> tagsElementContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> tagsElementMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tags',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      tagsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tags',
        value: '',
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      tagsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tags',
        value: '',
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> tagsLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> tagsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> tagsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> tagsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      tagsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> tagsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      temperatureRangeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'temperatureRange',
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      temperatureRangeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'temperatureRange',
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      temperatureRangeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'temperatureRange',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      temperatureRangeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'temperatureRange',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      temperatureRangeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'temperatureRange',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      temperatureRangeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'temperatureRange',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      temperatureRangeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'temperatureRange',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      temperatureRangeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'temperatureRange',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      temperatureRangeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'temperatureRange',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      temperatureRangeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'temperatureRange',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      temperatureRangeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'temperatureRange',
        value: '',
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      temperatureRangeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'temperatureRange',
        value: '',
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      wateringReminderEnabledEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'wateringReminderEnabled',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      wateringScheduleIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'wateringSchedule',
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      wateringScheduleIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'wateringSchedule',
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      wateringScheduleEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'wateringSchedule',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      wateringScheduleGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'wateringSchedule',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      wateringScheduleLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'wateringSchedule',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      wateringScheduleBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'wateringSchedule',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      wateringScheduleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'wateringSchedule',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      wateringScheduleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'wateringSchedule',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      wateringScheduleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'wateringSchedule',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      wateringScheduleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'wateringSchedule',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      wateringScheduleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'wateringSchedule',
        value: '',
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition>
      wateringScheduleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'wateringSchedule',
        value: '',
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> widthCmIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'widthCm',
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> widthCmIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'widthCm',
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> widthCmEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'widthCm',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> widthCmGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'widthCm',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> widthCmLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'widthCm',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> widthCmBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'widthCm',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> zoneIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'zone',
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> zoneIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'zone',
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> zoneEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'zone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> zoneGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'zone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> zoneLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'zone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> zoneBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'zone',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> zoneStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'zone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> zoneEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'zone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> zoneContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'zone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> zoneMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'zone',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> zoneIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'zone',
        value: '',
      ));
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterFilterCondition> zoneIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'zone',
        value: '',
      ));
    });
  }
}

extension UserPlantQueryObject
    on QueryBuilder<UserPlant, UserPlant, QFilterCondition> {}

extension UserPlantQueryLinks
    on QueryBuilder<UserPlant, UserPlant, QFilterCondition> {}

extension UserPlantQuerySortBy on QueryBuilder<UserPlant, UserPlant, QSortBy> {
  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> sortByAcquiredDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'acquiredDate', Sort.asc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> sortByAcquiredDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'acquiredDate', Sort.desc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> sortByCustomName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customName', Sort.asc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> sortByCustomNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customName', Sort.desc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy>
      sortByFertilizingReminderEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fertilizingReminderEnabled', Sort.asc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy>
      sortByFertilizingReminderEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fertilizingReminderEnabled', Sort.desc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> sortByFertilizingSchedule() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fertilizingSchedule', Sort.asc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy>
      sortByFertilizingScheduleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fertilizingSchedule', Sort.desc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> sortByHealthStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'healthStatus', Sort.asc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> sortByHealthStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'healthStatus', Sort.desc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> sortByHeightCm() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'heightCm', Sort.asc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> sortByHeightCmDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'heightCm', Sort.desc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> sortByHumidityLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'humidityLevel', Sort.asc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> sortByHumidityLevelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'humidityLevel', Sort.desc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> sortByIsPetSafe() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPetSafe', Sort.asc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> sortByIsPetSafeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPetSafe', Sort.desc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> sortByLastFertilized() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastFertilized', Sort.asc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> sortByLastFertilizedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastFertilized', Sort.desc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> sortByLastMeasured() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastMeasured', Sort.asc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> sortByLastMeasuredDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastMeasured', Sort.desc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> sortByLastPruned() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastPruned', Sort.asc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> sortByLastPrunedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastPruned', Sort.desc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> sortByLastWatered() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastWatered', Sort.asc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> sortByLastWateredDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastWatered', Sort.desc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> sortByLightConditions() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lightConditions', Sort.asc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> sortByLightConditionsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lightConditions', Sort.desc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> sortByLightExposure() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lightExposure', Sort.asc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> sortByLightExposureDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lightExposure', Sort.desc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> sortByLocation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'location', Sort.asc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> sortByLocationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'location', Sort.desc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> sortByPlantEntityId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'plantEntityId', Sort.asc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> sortByPlantEntityIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'plantEntityId', Sort.desc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> sortByPotSize() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'potSize', Sort.asc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> sortByPotSizeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'potSize', Sort.desc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy>
      sortByPruningReminderEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pruningReminderEnabled', Sort.asc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy>
      sortByPruningReminderEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pruningReminderEnabled', Sort.desc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> sortByPruningSchedule() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pruningSchedule', Sort.asc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> sortByPruningScheduleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pruningSchedule', Sort.desc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> sortByQuantity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantity', Sort.asc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> sortByQuantityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantity', Sort.desc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> sortBySoilType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'soilType', Sort.asc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> sortBySoilTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'soilType', Sort.desc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> sortBySource() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'source', Sort.asc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> sortBySourceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'source', Sort.desc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> sortByTemperatureRange() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'temperatureRange', Sort.asc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy>
      sortByTemperatureRangeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'temperatureRange', Sort.desc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy>
      sortByWateringReminderEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'wateringReminderEnabled', Sort.asc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy>
      sortByWateringReminderEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'wateringReminderEnabled', Sort.desc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> sortByWateringSchedule() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'wateringSchedule', Sort.asc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy>
      sortByWateringScheduleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'wateringSchedule', Sort.desc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> sortByWidthCm() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'widthCm', Sort.asc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> sortByWidthCmDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'widthCm', Sort.desc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> sortByZone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'zone', Sort.asc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> sortByZoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'zone', Sort.desc);
    });
  }
}

extension UserPlantQuerySortThenBy
    on QueryBuilder<UserPlant, UserPlant, QSortThenBy> {
  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> thenByAcquiredDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'acquiredDate', Sort.asc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> thenByAcquiredDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'acquiredDate', Sort.desc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> thenByCustomName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customName', Sort.asc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> thenByCustomNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customName', Sort.desc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy>
      thenByFertilizingReminderEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fertilizingReminderEnabled', Sort.asc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy>
      thenByFertilizingReminderEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fertilizingReminderEnabled', Sort.desc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> thenByFertilizingSchedule() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fertilizingSchedule', Sort.asc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy>
      thenByFertilizingScheduleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fertilizingSchedule', Sort.desc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> thenByHealthStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'healthStatus', Sort.asc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> thenByHealthStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'healthStatus', Sort.desc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> thenByHeightCm() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'heightCm', Sort.asc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> thenByHeightCmDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'heightCm', Sort.desc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> thenByHumidityLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'humidityLevel', Sort.asc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> thenByHumidityLevelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'humidityLevel', Sort.desc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> thenByIsPetSafe() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPetSafe', Sort.asc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> thenByIsPetSafeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPetSafe', Sort.desc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> thenByLastFertilized() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastFertilized', Sort.asc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> thenByLastFertilizedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastFertilized', Sort.desc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> thenByLastMeasured() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastMeasured', Sort.asc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> thenByLastMeasuredDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastMeasured', Sort.desc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> thenByLastPruned() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastPruned', Sort.asc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> thenByLastPrunedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastPruned', Sort.desc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> thenByLastWatered() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastWatered', Sort.asc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> thenByLastWateredDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastWatered', Sort.desc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> thenByLightConditions() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lightConditions', Sort.asc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> thenByLightConditionsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lightConditions', Sort.desc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> thenByLightExposure() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lightExposure', Sort.asc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> thenByLightExposureDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lightExposure', Sort.desc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> thenByLocation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'location', Sort.asc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> thenByLocationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'location', Sort.desc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> thenByPlantEntityId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'plantEntityId', Sort.asc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> thenByPlantEntityIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'plantEntityId', Sort.desc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> thenByPotSize() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'potSize', Sort.asc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> thenByPotSizeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'potSize', Sort.desc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy>
      thenByPruningReminderEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pruningReminderEnabled', Sort.asc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy>
      thenByPruningReminderEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pruningReminderEnabled', Sort.desc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> thenByPruningSchedule() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pruningSchedule', Sort.asc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> thenByPruningScheduleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pruningSchedule', Sort.desc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> thenByQuantity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantity', Sort.asc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> thenByQuantityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantity', Sort.desc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> thenBySoilType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'soilType', Sort.asc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> thenBySoilTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'soilType', Sort.desc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> thenBySource() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'source', Sort.asc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> thenBySourceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'source', Sort.desc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> thenByTemperatureRange() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'temperatureRange', Sort.asc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy>
      thenByTemperatureRangeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'temperatureRange', Sort.desc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy>
      thenByWateringReminderEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'wateringReminderEnabled', Sort.asc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy>
      thenByWateringReminderEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'wateringReminderEnabled', Sort.desc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> thenByWateringSchedule() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'wateringSchedule', Sort.asc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy>
      thenByWateringScheduleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'wateringSchedule', Sort.desc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> thenByWidthCm() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'widthCm', Sort.asc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> thenByWidthCmDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'widthCm', Sort.desc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> thenByZone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'zone', Sort.asc);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QAfterSortBy> thenByZoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'zone', Sort.desc);
    });
  }
}

extension UserPlantQueryWhereDistinct
    on QueryBuilder<UserPlant, UserPlant, QDistinct> {
  QueryBuilder<UserPlant, UserPlant, QDistinct> distinctByAcquiredDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'acquiredDate');
    });
  }

  QueryBuilder<UserPlant, UserPlant, QDistinct> distinctByCustomName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'customName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QDistinct>
      distinctByFertilizingReminderEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fertilizingReminderEnabled');
    });
  }

  QueryBuilder<UserPlant, UserPlant, QDistinct> distinctByFertilizingSchedule(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fertilizingSchedule',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QDistinct> distinctByHealthNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'healthNotes');
    });
  }

  QueryBuilder<UserPlant, UserPlant, QDistinct> distinctByHealthStatus(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'healthStatus', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QDistinct> distinctByHeightCm() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'heightCm');
    });
  }

  QueryBuilder<UserPlant, UserPlant, QDistinct> distinctByHumidityLevel(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'humidityLevel',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QDistinct> distinctByIsPetSafe() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isPetSafe');
    });
  }

  QueryBuilder<UserPlant, UserPlant, QDistinct> distinctByLastFertilized() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastFertilized');
    });
  }

  QueryBuilder<UserPlant, UserPlant, QDistinct> distinctByLastMeasured() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastMeasured');
    });
  }

  QueryBuilder<UserPlant, UserPlant, QDistinct> distinctByLastPruned() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastPruned');
    });
  }

  QueryBuilder<UserPlant, UserPlant, QDistinct> distinctByLastWatered() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastWatered');
    });
  }

  QueryBuilder<UserPlant, UserPlant, QDistinct> distinctByLightConditions(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lightConditions',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QDistinct> distinctByLightExposure() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lightExposure');
    });
  }

  QueryBuilder<UserPlant, UserPlant, QDistinct> distinctByLocation(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'location', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QDistinct> distinctByPhotoPaths() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'photoPaths');
    });
  }

  QueryBuilder<UserPlant, UserPlant, QDistinct> distinctByPlantEntityId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'plantEntityId');
    });
  }

  QueryBuilder<UserPlant, UserPlant, QDistinct> distinctByPotSize(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'potSize', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QDistinct>
      distinctByPruningReminderEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pruningReminderEnabled');
    });
  }

  QueryBuilder<UserPlant, UserPlant, QDistinct> distinctByPruningSchedule(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pruningSchedule',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QDistinct> distinctByQuantity() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'quantity');
    });
  }

  QueryBuilder<UserPlant, UserPlant, QDistinct> distinctBySoilType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'soilType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QDistinct> distinctBySource(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'source', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QDistinct> distinctByTags() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tags');
    });
  }

  QueryBuilder<UserPlant, UserPlant, QDistinct> distinctByTemperatureRange(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'temperatureRange',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QDistinct>
      distinctByWateringReminderEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'wateringReminderEnabled');
    });
  }

  QueryBuilder<UserPlant, UserPlant, QDistinct> distinctByWateringSchedule(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'wateringSchedule',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserPlant, UserPlant, QDistinct> distinctByWidthCm() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'widthCm');
    });
  }

  QueryBuilder<UserPlant, UserPlant, QDistinct> distinctByZone(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'zone', caseSensitive: caseSensitive);
    });
  }
}

extension UserPlantQueryProperty
    on QueryBuilder<UserPlant, UserPlant, QQueryProperty> {
  QueryBuilder<UserPlant, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<UserPlant, DateTime?, QQueryOperations> acquiredDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'acquiredDate');
    });
  }

  QueryBuilder<UserPlant, String?, QQueryOperations> customNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'customName');
    });
  }

  QueryBuilder<UserPlant, bool, QQueryOperations>
      fertilizingReminderEnabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fertilizingReminderEnabled');
    });
  }

  QueryBuilder<UserPlant, String?, QQueryOperations>
      fertilizingScheduleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fertilizingSchedule');
    });
  }

  QueryBuilder<UserPlant, List<String>?, QQueryOperations>
      healthNotesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'healthNotes');
    });
  }

  QueryBuilder<UserPlant, String?, QQueryOperations> healthStatusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'healthStatus');
    });
  }

  QueryBuilder<UserPlant, double?, QQueryOperations> heightCmProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'heightCm');
    });
  }

  QueryBuilder<UserPlant, String?, QQueryOperations> humidityLevelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'humidityLevel');
    });
  }

  QueryBuilder<UserPlant, bool?, QQueryOperations> isPetSafeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isPetSafe');
    });
  }

  QueryBuilder<UserPlant, DateTime?, QQueryOperations>
      lastFertilizedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastFertilized');
    });
  }

  QueryBuilder<UserPlant, DateTime?, QQueryOperations> lastMeasuredProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastMeasured');
    });
  }

  QueryBuilder<UserPlant, DateTime?, QQueryOperations> lastPrunedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastPruned');
    });
  }

  QueryBuilder<UserPlant, DateTime?, QQueryOperations> lastWateredProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastWatered');
    });
  }

  QueryBuilder<UserPlant, String?, QQueryOperations> lightConditionsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lightConditions');
    });
  }

  QueryBuilder<UserPlant, int, QQueryOperations> lightExposureProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lightExposure');
    });
  }

  QueryBuilder<UserPlant, String?, QQueryOperations> locationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'location');
    });
  }

  QueryBuilder<UserPlant, List<String>?, QQueryOperations>
      photoPathsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'photoPaths');
    });
  }

  QueryBuilder<UserPlant, int?, QQueryOperations> plantEntityIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'plantEntityId');
    });
  }

  QueryBuilder<UserPlant, String?, QQueryOperations> potSizeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'potSize');
    });
  }

  QueryBuilder<UserPlant, bool, QQueryOperations>
      pruningReminderEnabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pruningReminderEnabled');
    });
  }

  QueryBuilder<UserPlant, String?, QQueryOperations> pruningScheduleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pruningSchedule');
    });
  }

  QueryBuilder<UserPlant, int, QQueryOperations> quantityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'quantity');
    });
  }

  QueryBuilder<UserPlant, String?, QQueryOperations> soilTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'soilType');
    });
  }

  QueryBuilder<UserPlant, String?, QQueryOperations> sourceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'source');
    });
  }

  QueryBuilder<UserPlant, List<String>?, QQueryOperations> tagsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tags');
    });
  }

  QueryBuilder<UserPlant, String?, QQueryOperations>
      temperatureRangeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'temperatureRange');
    });
  }

  QueryBuilder<UserPlant, bool, QQueryOperations>
      wateringReminderEnabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'wateringReminderEnabled');
    });
  }

  QueryBuilder<UserPlant, String?, QQueryOperations>
      wateringScheduleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'wateringSchedule');
    });
  }

  QueryBuilder<UserPlant, double?, QQueryOperations> widthCmProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'widthCm');
    });
  }

  QueryBuilder<UserPlant, String?, QQueryOperations> zoneProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'zone');
    });
  }
}
