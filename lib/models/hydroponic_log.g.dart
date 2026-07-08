// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hydroponic_log.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetHydroponicLogCollection on Isar {
  IsarCollection<HydroponicLog> get hydroponicLogs => this.collection();
}

const HydroponicLogSchema = CollectionSchema(
  name: r'HydroponicLog',
  id: 3170886616306439373,
  properties: {
    r'notes': PropertySchema(
      id: 0,
      name: r'notes',
      type: IsarType.string,
    ),
    r'nutrientTds': PropertySchema(
      id: 1,
      name: r'nutrientTds',
      type: IsarType.double,
    ),
    r'plantId': PropertySchema(
      id: 2,
      name: r'plantId',
      type: IsarType.long,
    ),
    r'pumpCycleMinutes': PropertySchema(
      id: 3,
      name: r'pumpCycleMinutes',
      type: IsarType.long,
    ),
    r'timestamp': PropertySchema(
      id: 4,
      name: r'timestamp',
      type: IsarType.dateTime,
    ),
    r'waterPH': PropertySchema(
      id: 5,
      name: r'waterPH',
      type: IsarType.double,
    ),
    r'zone': PropertySchema(
      id: 6,
      name: r'zone',
      type: IsarType.string,
    )
  },
  estimateSize: _hydroponicLogEstimateSize,
  serialize: _hydroponicLogSerialize,
  deserialize: _hydroponicLogDeserialize,
  deserializeProp: _hydroponicLogDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _hydroponicLogGetId,
  getLinks: _hydroponicLogGetLinks,
  attach: _hydroponicLogAttach,
  version: '3.1.0+1',
);

int _hydroponicLogEstimateSize(
  HydroponicLog object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.notes;
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

void _hydroponicLogSerialize(
  HydroponicLog object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.notes);
  writer.writeDouble(offsets[1], object.nutrientTds);
  writer.writeLong(offsets[2], object.plantId);
  writer.writeLong(offsets[3], object.pumpCycleMinutes);
  writer.writeDateTime(offsets[4], object.timestamp);
  writer.writeDouble(offsets[5], object.waterPH);
  writer.writeString(offsets[6], object.zone);
}

HydroponicLog _hydroponicLogDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = HydroponicLog();
  object.id = id;
  object.notes = reader.readStringOrNull(offsets[0]);
  object.nutrientTds = reader.readDoubleOrNull(offsets[1]);
  object.plantId = reader.readLong(offsets[2]);
  object.pumpCycleMinutes = reader.readLongOrNull(offsets[3]);
  object.timestamp = reader.readDateTime(offsets[4]);
  object.waterPH = reader.readDoubleOrNull(offsets[5]);
  object.zone = reader.readStringOrNull(offsets[6]);
  return object;
}

P _hydroponicLogDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readDoubleOrNull(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readLongOrNull(offset)) as P;
    case 4:
      return (reader.readDateTime(offset)) as P;
    case 5:
      return (reader.readDoubleOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _hydroponicLogGetId(HydroponicLog object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _hydroponicLogGetLinks(HydroponicLog object) {
  return [];
}

void _hydroponicLogAttach(
    IsarCollection<dynamic> col, Id id, HydroponicLog object) {
  object.id = id;
}

extension HydroponicLogQueryWhereSort
    on QueryBuilder<HydroponicLog, HydroponicLog, QWhere> {
  QueryBuilder<HydroponicLog, HydroponicLog, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension HydroponicLogQueryWhere
    on QueryBuilder<HydroponicLog, HydroponicLog, QWhereClause> {
  QueryBuilder<HydroponicLog, HydroponicLog, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterWhereClause> idBetween(
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

extension HydroponicLogQueryFilter
    on QueryBuilder<HydroponicLog, HydroponicLog, QFilterCondition> {
  QueryBuilder<HydroponicLog, HydroponicLog, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterFilterCondition>
      idGreaterThan(
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

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterFilterCondition> idBetween(
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

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterFilterCondition>
      notesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'notes',
      ));
    });
  }

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterFilterCondition>
      notesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'notes',
      ));
    });
  }

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterFilterCondition>
      notesEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterFilterCondition>
      notesGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterFilterCondition>
      notesLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterFilterCondition>
      notesBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'notes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterFilterCondition>
      notesStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterFilterCondition>
      notesEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterFilterCondition>
      notesContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterFilterCondition>
      notesMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'notes',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterFilterCondition>
      notesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterFilterCondition>
      notesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterFilterCondition>
      nutrientTdsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'nutrientTds',
      ));
    });
  }

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterFilterCondition>
      nutrientTdsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'nutrientTds',
      ));
    });
  }

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterFilterCondition>
      nutrientTdsEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nutrientTds',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterFilterCondition>
      nutrientTdsGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nutrientTds',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterFilterCondition>
      nutrientTdsLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nutrientTds',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterFilterCondition>
      nutrientTdsBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nutrientTds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterFilterCondition>
      plantIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'plantId',
        value: value,
      ));
    });
  }

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterFilterCondition>
      plantIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'plantId',
        value: value,
      ));
    });
  }

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterFilterCondition>
      plantIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'plantId',
        value: value,
      ));
    });
  }

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterFilterCondition>
      plantIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'plantId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterFilterCondition>
      pumpCycleMinutesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'pumpCycleMinutes',
      ));
    });
  }

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterFilterCondition>
      pumpCycleMinutesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'pumpCycleMinutes',
      ));
    });
  }

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterFilterCondition>
      pumpCycleMinutesEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pumpCycleMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterFilterCondition>
      pumpCycleMinutesGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pumpCycleMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterFilterCondition>
      pumpCycleMinutesLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pumpCycleMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterFilterCondition>
      pumpCycleMinutesBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pumpCycleMinutes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterFilterCondition>
      timestampEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterFilterCondition>
      timestampGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterFilterCondition>
      timestampLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterFilterCondition>
      timestampBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'timestamp',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterFilterCondition>
      waterPHIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'waterPH',
      ));
    });
  }

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterFilterCondition>
      waterPHIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'waterPH',
      ));
    });
  }

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterFilterCondition>
      waterPHEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'waterPH',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterFilterCondition>
      waterPHGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'waterPH',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterFilterCondition>
      waterPHLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'waterPH',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterFilterCondition>
      waterPHBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'waterPH',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterFilterCondition>
      zoneIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'zone',
      ));
    });
  }

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterFilterCondition>
      zoneIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'zone',
      ));
    });
  }

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterFilterCondition> zoneEqualTo(
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

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterFilterCondition>
      zoneGreaterThan(
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

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterFilterCondition>
      zoneLessThan(
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

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterFilterCondition> zoneBetween(
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

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterFilterCondition>
      zoneStartsWith(
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

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterFilterCondition>
      zoneEndsWith(
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

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterFilterCondition>
      zoneContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'zone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterFilterCondition> zoneMatches(
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

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterFilterCondition>
      zoneIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'zone',
        value: '',
      ));
    });
  }

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterFilterCondition>
      zoneIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'zone',
        value: '',
      ));
    });
  }
}

extension HydroponicLogQueryObject
    on QueryBuilder<HydroponicLog, HydroponicLog, QFilterCondition> {}

extension HydroponicLogQueryLinks
    on QueryBuilder<HydroponicLog, HydroponicLog, QFilterCondition> {}

extension HydroponicLogQuerySortBy
    on QueryBuilder<HydroponicLog, HydroponicLog, QSortBy> {
  QueryBuilder<HydroponicLog, HydroponicLog, QAfterSortBy> sortByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterSortBy> sortByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterSortBy> sortByNutrientTds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nutrientTds', Sort.asc);
    });
  }

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterSortBy>
      sortByNutrientTdsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nutrientTds', Sort.desc);
    });
  }

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterSortBy> sortByPlantId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'plantId', Sort.asc);
    });
  }

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterSortBy> sortByPlantIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'plantId', Sort.desc);
    });
  }

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterSortBy>
      sortByPumpCycleMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pumpCycleMinutes', Sort.asc);
    });
  }

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterSortBy>
      sortByPumpCycleMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pumpCycleMinutes', Sort.desc);
    });
  }

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterSortBy> sortByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.asc);
    });
  }

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterSortBy>
      sortByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.desc);
    });
  }

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterSortBy> sortByWaterPH() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'waterPH', Sort.asc);
    });
  }

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterSortBy> sortByWaterPHDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'waterPH', Sort.desc);
    });
  }

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterSortBy> sortByZone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'zone', Sort.asc);
    });
  }

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterSortBy> sortByZoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'zone', Sort.desc);
    });
  }
}

extension HydroponicLogQuerySortThenBy
    on QueryBuilder<HydroponicLog, HydroponicLog, QSortThenBy> {
  QueryBuilder<HydroponicLog, HydroponicLog, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterSortBy> thenByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterSortBy> thenByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterSortBy> thenByNutrientTds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nutrientTds', Sort.asc);
    });
  }

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterSortBy>
      thenByNutrientTdsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nutrientTds', Sort.desc);
    });
  }

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterSortBy> thenByPlantId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'plantId', Sort.asc);
    });
  }

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterSortBy> thenByPlantIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'plantId', Sort.desc);
    });
  }

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterSortBy>
      thenByPumpCycleMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pumpCycleMinutes', Sort.asc);
    });
  }

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterSortBy>
      thenByPumpCycleMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pumpCycleMinutes', Sort.desc);
    });
  }

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterSortBy> thenByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.asc);
    });
  }

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterSortBy>
      thenByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.desc);
    });
  }

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterSortBy> thenByWaterPH() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'waterPH', Sort.asc);
    });
  }

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterSortBy> thenByWaterPHDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'waterPH', Sort.desc);
    });
  }

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterSortBy> thenByZone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'zone', Sort.asc);
    });
  }

  QueryBuilder<HydroponicLog, HydroponicLog, QAfterSortBy> thenByZoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'zone', Sort.desc);
    });
  }
}

extension HydroponicLogQueryWhereDistinct
    on QueryBuilder<HydroponicLog, HydroponicLog, QDistinct> {
  QueryBuilder<HydroponicLog, HydroponicLog, QDistinct> distinctByNotes(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notes', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HydroponicLog, HydroponicLog, QDistinct>
      distinctByNutrientTds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nutrientTds');
    });
  }

  QueryBuilder<HydroponicLog, HydroponicLog, QDistinct> distinctByPlantId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'plantId');
    });
  }

  QueryBuilder<HydroponicLog, HydroponicLog, QDistinct>
      distinctByPumpCycleMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pumpCycleMinutes');
    });
  }

  QueryBuilder<HydroponicLog, HydroponicLog, QDistinct> distinctByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timestamp');
    });
  }

  QueryBuilder<HydroponicLog, HydroponicLog, QDistinct> distinctByWaterPH() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'waterPH');
    });
  }

  QueryBuilder<HydroponicLog, HydroponicLog, QDistinct> distinctByZone(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'zone', caseSensitive: caseSensitive);
    });
  }
}

extension HydroponicLogQueryProperty
    on QueryBuilder<HydroponicLog, HydroponicLog, QQueryProperty> {
  QueryBuilder<HydroponicLog, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<HydroponicLog, String?, QQueryOperations> notesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notes');
    });
  }

  QueryBuilder<HydroponicLog, double?, QQueryOperations> nutrientTdsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nutrientTds');
    });
  }

  QueryBuilder<HydroponicLog, int, QQueryOperations> plantIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'plantId');
    });
  }

  QueryBuilder<HydroponicLog, int?, QQueryOperations>
      pumpCycleMinutesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pumpCycleMinutes');
    });
  }

  QueryBuilder<HydroponicLog, DateTime, QQueryOperations> timestampProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timestamp');
    });
  }

  QueryBuilder<HydroponicLog, double?, QQueryOperations> waterPHProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'waterPH');
    });
  }

  QueryBuilder<HydroponicLog, String?, QQueryOperations> zoneProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'zone');
    });
  }
}
