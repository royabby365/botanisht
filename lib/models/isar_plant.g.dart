// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'isar_plant.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPlantCollection on Isar {
  IsarCollection<Plant> get plants => this.collection();
}

const PlantSchema = CollectionSchema(
  name: r'Plant',
  id: 3202799289401311532,
  properties: {
    r'antagonists': PropertySchema(
      id: 0,
      name: r'antagonists',
      type: IsarType.stringList,
    ),
    r'category': PropertySchema(
      id: 1,
      name: r'category',
      type: IsarType.string,
    ),
    r'companions': PropertySchema(
      id: 2,
      name: r'companions',
      type: IsarType.stringList,
    ),
    r'customName': PropertySchema(
      id: 3,
      name: r'customName',
      type: IsarType.string,
    ),
    r'daysToHarvest': PropertySchema(
      id: 4,
      name: r'daysToHarvest',
      type: IsarType.long,
    ),
    r'description': PropertySchema(
      id: 5,
      name: r'description',
      type: IsarType.string,
    ),
    r'imageUrl': PropertySchema(
      id: 6,
      name: r'imageUrl',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 7,
      name: r'name',
      type: IsarType.string,
    ),
    r'propagationMethod': PropertySchema(
      id: 8,
      name: r'propagationMethod',
      type: IsarType.string,
    ),
    r'rowSpacing': PropertySchema(
      id: 9,
      name: r'rowSpacing',
      type: IsarType.string,
    ),
    r'scientificName': PropertySchema(
      id: 10,
      name: r'scientificName',
      type: IsarType.string,
    ),
    r'seedDepth': PropertySchema(
      id: 11,
      name: r'seedDepth',
      type: IsarType.string,
    ),
    r'sowFirstAfterLastFrostDate': PropertySchema(
      id: 12,
      name: r'sowFirstAfterLastFrostDate',
      type: IsarType.string,
    ),
    r'sowLastAfterLastFrostDate': PropertySchema(
      id: 13,
      name: r'sowLastAfterLastFrostDate',
      type: IsarType.string,
    ),
    r'sowLastBeforeLastFrostDate': PropertySchema(
      id: 14,
      name: r'sowLastBeforeLastFrostDate',
      type: IsarType.string,
    ),
    r'sowMethod': PropertySchema(
      id: 15,
      name: r'sowMethod',
      type: IsarType.string,
    ),
    r'sowRightBeforeLastFrostDate': PropertySchema(
      id: 16,
      name: r'sowRightBeforeLastFrostDate',
      type: IsarType.string,
    ),
    r'spacing': PropertySchema(
      id: 17,
      name: r'spacing',
      type: IsarType.string,
    ),
    r'sunRequirements': PropertySchema(
      id: 18,
      name: r'sunRequirements',
      type: IsarType.stringList,
    ),
    r'waterRequirements': PropertySchema(
      id: 19,
      name: r'waterRequirements',
      type: IsarType.stringList,
    )
  },
  estimateSize: _plantEstimateSize,
  serialize: _plantSerialize,
  deserialize: _plantDeserialize,
  deserializeProp: _plantDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _plantGetId,
  getLinks: _plantGetLinks,
  attach: _plantAttach,
  version: '3.1.0+1',
);

int _plantEstimateSize(
  Plant object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final list = object.antagonists;
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
    final value = object.category;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final list = object.companions;
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
    final value = object.customName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.description;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.imageUrl;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.name;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.propagationMethod;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.rowSpacing;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.scientificName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.seedDepth;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.sowFirstAfterLastFrostDate;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.sowLastAfterLastFrostDate;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.sowLastBeforeLastFrostDate;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.sowMethod;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.sowRightBeforeLastFrostDate;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.spacing;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final list = object.sunRequirements;
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
    final list = object.waterRequirements;
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
  return bytesCount;
}

void _plantSerialize(
  Plant object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeStringList(offsets[0], object.antagonists);
  writer.writeString(offsets[1], object.category);
  writer.writeStringList(offsets[2], object.companions);
  writer.writeString(offsets[3], object.customName);
  writer.writeLong(offsets[4], object.daysToHarvest);
  writer.writeString(offsets[5], object.description);
  writer.writeString(offsets[6], object.imageUrl);
  writer.writeString(offsets[7], object.name);
  writer.writeString(offsets[8], object.propagationMethod);
  writer.writeString(offsets[9], object.rowSpacing);
  writer.writeString(offsets[10], object.scientificName);
  writer.writeString(offsets[11], object.seedDepth);
  writer.writeString(offsets[12], object.sowFirstAfterLastFrostDate);
  writer.writeString(offsets[13], object.sowLastAfterLastFrostDate);
  writer.writeString(offsets[14], object.sowLastBeforeLastFrostDate);
  writer.writeString(offsets[15], object.sowMethod);
  writer.writeString(offsets[16], object.sowRightBeforeLastFrostDate);
  writer.writeString(offsets[17], object.spacing);
  writer.writeStringList(offsets[18], object.sunRequirements);
  writer.writeStringList(offsets[19], object.waterRequirements);
}

Plant _plantDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Plant();
  object.antagonists = reader.readStringList(offsets[0]);
  object.category = reader.readStringOrNull(offsets[1]);
  object.companions = reader.readStringList(offsets[2]);
  object.customName = reader.readStringOrNull(offsets[3]);
  object.daysToHarvest = reader.readLongOrNull(offsets[4]);
  object.description = reader.readStringOrNull(offsets[5]);
  object.id = id;
  object.imageUrl = reader.readStringOrNull(offsets[6]);
  object.name = reader.readStringOrNull(offsets[7]);
  object.propagationMethod = reader.readStringOrNull(offsets[8]);
  object.rowSpacing = reader.readStringOrNull(offsets[9]);
  object.scientificName = reader.readStringOrNull(offsets[10]);
  object.seedDepth = reader.readStringOrNull(offsets[11]);
  object.sowFirstAfterLastFrostDate = reader.readStringOrNull(offsets[12]);
  object.sowLastAfterLastFrostDate = reader.readStringOrNull(offsets[13]);
  object.sowLastBeforeLastFrostDate = reader.readStringOrNull(offsets[14]);
  object.sowMethod = reader.readStringOrNull(offsets[15]);
  object.sowRightBeforeLastFrostDate = reader.readStringOrNull(offsets[16]);
  object.spacing = reader.readStringOrNull(offsets[17]);
  object.sunRequirements = reader.readStringList(offsets[18]);
  object.waterRequirements = reader.readStringList(offsets[19]);
  return object;
}

P _plantDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringList(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringList(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readLongOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readStringOrNull(offset)) as P;
    case 11:
      return (reader.readStringOrNull(offset)) as P;
    case 12:
      return (reader.readStringOrNull(offset)) as P;
    case 13:
      return (reader.readStringOrNull(offset)) as P;
    case 14:
      return (reader.readStringOrNull(offset)) as P;
    case 15:
      return (reader.readStringOrNull(offset)) as P;
    case 16:
      return (reader.readStringOrNull(offset)) as P;
    case 17:
      return (reader.readStringOrNull(offset)) as P;
    case 18:
      return (reader.readStringList(offset)) as P;
    case 19:
      return (reader.readStringList(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _plantGetId(Plant object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _plantGetLinks(Plant object) {
  return [];
}

void _plantAttach(IsarCollection<dynamic> col, Id id, Plant object) {
  object.id = id;
}

extension PlantQueryWhereSort on QueryBuilder<Plant, Plant, QWhere> {
  QueryBuilder<Plant, Plant, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension PlantQueryWhere on QueryBuilder<Plant, Plant, QWhereClause> {
  QueryBuilder<Plant, Plant, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Plant, Plant, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Plant, Plant, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Plant, Plant, QAfterWhereClause> idBetween(
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

extension PlantQueryFilter on QueryBuilder<Plant, Plant, QFilterCondition> {
  QueryBuilder<Plant, Plant, QAfterFilterCondition> antagonistsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'antagonists',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> antagonistsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'antagonists',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> antagonistsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'antagonists',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      antagonistsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'antagonists',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> antagonistsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'antagonists',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> antagonistsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'antagonists',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      antagonistsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'antagonists',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> antagonistsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'antagonists',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> antagonistsElementContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'antagonists',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> antagonistsElementMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'antagonists',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      antagonistsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'antagonists',
        value: '',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      antagonistsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'antagonists',
        value: '',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> antagonistsLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'antagonists',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> antagonistsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'antagonists',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> antagonistsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'antagonists',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> antagonistsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'antagonists',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      antagonistsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'antagonists',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> antagonistsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'antagonists',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> categoryIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'category',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> categoryIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'category',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> categoryEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> categoryGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> categoryLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> categoryBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'category',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> categoryStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> categoryEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> categoryContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> categoryMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'category',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> categoryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category',
        value: '',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> categoryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'category',
        value: '',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> companionsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'companions',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> companionsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'companions',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> companionsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'companions',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      companionsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'companions',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> companionsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'companions',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> companionsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'companions',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> companionsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'companions',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> companionsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'companions',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> companionsElementContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'companions',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> companionsElementMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'companions',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> companionsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'companions',
        value: '',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      companionsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'companions',
        value: '',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> companionsLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'companions',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> companionsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'companions',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> companionsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'companions',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> companionsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'companions',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> companionsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'companions',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> companionsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'companions',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> customNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'customName',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> customNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'customName',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> customNameEqualTo(
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

  QueryBuilder<Plant, Plant, QAfterFilterCondition> customNameGreaterThan(
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

  QueryBuilder<Plant, Plant, QAfterFilterCondition> customNameLessThan(
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

  QueryBuilder<Plant, Plant, QAfterFilterCondition> customNameBetween(
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

  QueryBuilder<Plant, Plant, QAfterFilterCondition> customNameStartsWith(
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

  QueryBuilder<Plant, Plant, QAfterFilterCondition> customNameEndsWith(
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

  QueryBuilder<Plant, Plant, QAfterFilterCondition> customNameContains(
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

  QueryBuilder<Plant, Plant, QAfterFilterCondition> customNameMatches(
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

  QueryBuilder<Plant, Plant, QAfterFilterCondition> customNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'customName',
        value: '',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> customNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'customName',
        value: '',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> daysToHarvestIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'daysToHarvest',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> daysToHarvestIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'daysToHarvest',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> daysToHarvestEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'daysToHarvest',
        value: value,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> daysToHarvestGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'daysToHarvest',
        value: value,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> daysToHarvestLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'daysToHarvest',
        value: value,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> daysToHarvestBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'daysToHarvest',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> descriptionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> descriptionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> descriptionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> descriptionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> descriptionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> descriptionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'description',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> descriptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> descriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> descriptionContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> descriptionMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'description',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Plant, Plant, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Plant, Plant, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Plant, Plant, QAfterFilterCondition> imageUrlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'imageUrl',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> imageUrlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'imageUrl',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> imageUrlEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> imageUrlGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'imageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> imageUrlLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'imageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> imageUrlBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'imageUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> imageUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'imageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> imageUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'imageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> imageUrlContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'imageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> imageUrlMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'imageUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> imageUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imageUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> imageUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'imageUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> nameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> nameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> nameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> nameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> nameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> nameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> nameContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> nameMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> propagationMethodIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'propagationMethod',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      propagationMethodIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'propagationMethod',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> propagationMethodEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'propagationMethod',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      propagationMethodGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'propagationMethod',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> propagationMethodLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'propagationMethod',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> propagationMethodBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'propagationMethod',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> propagationMethodStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'propagationMethod',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> propagationMethodEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'propagationMethod',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> propagationMethodContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'propagationMethod',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> propagationMethodMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'propagationMethod',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> propagationMethodIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'propagationMethod',
        value: '',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      propagationMethodIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'propagationMethod',
        value: '',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> rowSpacingIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'rowSpacing',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> rowSpacingIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'rowSpacing',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> rowSpacingEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rowSpacing',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> rowSpacingGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'rowSpacing',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> rowSpacingLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'rowSpacing',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> rowSpacingBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'rowSpacing',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> rowSpacingStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'rowSpacing',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> rowSpacingEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'rowSpacing',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> rowSpacingContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'rowSpacing',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> rowSpacingMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'rowSpacing',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> rowSpacingIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rowSpacing',
        value: '',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> rowSpacingIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'rowSpacing',
        value: '',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> scientificNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'scientificName',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> scientificNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'scientificName',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> scientificNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'scientificName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> scientificNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'scientificName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> scientificNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'scientificName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> scientificNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'scientificName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> scientificNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'scientificName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> scientificNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'scientificName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> scientificNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'scientificName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> scientificNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'scientificName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> scientificNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'scientificName',
        value: '',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> scientificNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'scientificName',
        value: '',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> seedDepthIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'seedDepth',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> seedDepthIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'seedDepth',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> seedDepthEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'seedDepth',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> seedDepthGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'seedDepth',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> seedDepthLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'seedDepth',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> seedDepthBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'seedDepth',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> seedDepthStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'seedDepth',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> seedDepthEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'seedDepth',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> seedDepthContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'seedDepth',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> seedDepthMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'seedDepth',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> seedDepthIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'seedDepth',
        value: '',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> seedDepthIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'seedDepth',
        value: '',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      sowFirstAfterLastFrostDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'sowFirstAfterLastFrostDate',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      sowFirstAfterLastFrostDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'sowFirstAfterLastFrostDate',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      sowFirstAfterLastFrostDateEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sowFirstAfterLastFrostDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      sowFirstAfterLastFrostDateGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sowFirstAfterLastFrostDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      sowFirstAfterLastFrostDateLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sowFirstAfterLastFrostDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      sowFirstAfterLastFrostDateBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sowFirstAfterLastFrostDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      sowFirstAfterLastFrostDateStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'sowFirstAfterLastFrostDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      sowFirstAfterLastFrostDateEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'sowFirstAfterLastFrostDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      sowFirstAfterLastFrostDateContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'sowFirstAfterLastFrostDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      sowFirstAfterLastFrostDateMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'sowFirstAfterLastFrostDate',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      sowFirstAfterLastFrostDateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sowFirstAfterLastFrostDate',
        value: '',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      sowFirstAfterLastFrostDateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sowFirstAfterLastFrostDate',
        value: '',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      sowLastAfterLastFrostDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'sowLastAfterLastFrostDate',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      sowLastAfterLastFrostDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'sowLastAfterLastFrostDate',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      sowLastAfterLastFrostDateEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sowLastAfterLastFrostDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      sowLastAfterLastFrostDateGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sowLastAfterLastFrostDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      sowLastAfterLastFrostDateLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sowLastAfterLastFrostDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      sowLastAfterLastFrostDateBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sowLastAfterLastFrostDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      sowLastAfterLastFrostDateStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'sowLastAfterLastFrostDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      sowLastAfterLastFrostDateEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'sowLastAfterLastFrostDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      sowLastAfterLastFrostDateContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'sowLastAfterLastFrostDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      sowLastAfterLastFrostDateMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'sowLastAfterLastFrostDate',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      sowLastAfterLastFrostDateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sowLastAfterLastFrostDate',
        value: '',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      sowLastAfterLastFrostDateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sowLastAfterLastFrostDate',
        value: '',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      sowLastBeforeLastFrostDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'sowLastBeforeLastFrostDate',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      sowLastBeforeLastFrostDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'sowLastBeforeLastFrostDate',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      sowLastBeforeLastFrostDateEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sowLastBeforeLastFrostDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      sowLastBeforeLastFrostDateGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sowLastBeforeLastFrostDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      sowLastBeforeLastFrostDateLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sowLastBeforeLastFrostDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      sowLastBeforeLastFrostDateBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sowLastBeforeLastFrostDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      sowLastBeforeLastFrostDateStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'sowLastBeforeLastFrostDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      sowLastBeforeLastFrostDateEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'sowLastBeforeLastFrostDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      sowLastBeforeLastFrostDateContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'sowLastBeforeLastFrostDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      sowLastBeforeLastFrostDateMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'sowLastBeforeLastFrostDate',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      sowLastBeforeLastFrostDateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sowLastBeforeLastFrostDate',
        value: '',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      sowLastBeforeLastFrostDateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sowLastBeforeLastFrostDate',
        value: '',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> sowMethodIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'sowMethod',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> sowMethodIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'sowMethod',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> sowMethodEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sowMethod',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> sowMethodGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sowMethod',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> sowMethodLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sowMethod',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> sowMethodBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sowMethod',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> sowMethodStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'sowMethod',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> sowMethodEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'sowMethod',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> sowMethodContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'sowMethod',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> sowMethodMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'sowMethod',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> sowMethodIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sowMethod',
        value: '',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> sowMethodIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sowMethod',
        value: '',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      sowRightBeforeLastFrostDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'sowRightBeforeLastFrostDate',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      sowRightBeforeLastFrostDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'sowRightBeforeLastFrostDate',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      sowRightBeforeLastFrostDateEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sowRightBeforeLastFrostDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      sowRightBeforeLastFrostDateGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sowRightBeforeLastFrostDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      sowRightBeforeLastFrostDateLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sowRightBeforeLastFrostDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      sowRightBeforeLastFrostDateBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sowRightBeforeLastFrostDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      sowRightBeforeLastFrostDateStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'sowRightBeforeLastFrostDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      sowRightBeforeLastFrostDateEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'sowRightBeforeLastFrostDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      sowRightBeforeLastFrostDateContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'sowRightBeforeLastFrostDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      sowRightBeforeLastFrostDateMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'sowRightBeforeLastFrostDate',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      sowRightBeforeLastFrostDateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sowRightBeforeLastFrostDate',
        value: '',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      sowRightBeforeLastFrostDateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sowRightBeforeLastFrostDate',
        value: '',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> spacingIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'spacing',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> spacingIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'spacing',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> spacingEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'spacing',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> spacingGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'spacing',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> spacingLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'spacing',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> spacingBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'spacing',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> spacingStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'spacing',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> spacingEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'spacing',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> spacingContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'spacing',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> spacingMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'spacing',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> spacingIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'spacing',
        value: '',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> spacingIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'spacing',
        value: '',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> sunRequirementsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'sunRequirements',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> sunRequirementsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'sunRequirements',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      sunRequirementsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sunRequirements',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      sunRequirementsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sunRequirements',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      sunRequirementsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sunRequirements',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      sunRequirementsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sunRequirements',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      sunRequirementsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'sunRequirements',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      sunRequirementsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'sunRequirements',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      sunRequirementsElementContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'sunRequirements',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      sunRequirementsElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'sunRequirements',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      sunRequirementsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sunRequirements',
        value: '',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      sunRequirementsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sunRequirements',
        value: '',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      sunRequirementsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'sunRequirements',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> sunRequirementsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'sunRequirements',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      sunRequirementsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'sunRequirements',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      sunRequirementsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'sunRequirements',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      sunRequirementsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'sunRequirements',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      sunRequirementsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'sunRequirements',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> waterRequirementsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'waterRequirements',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      waterRequirementsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'waterRequirements',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      waterRequirementsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'waterRequirements',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      waterRequirementsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'waterRequirements',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      waterRequirementsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'waterRequirements',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      waterRequirementsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'waterRequirements',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      waterRequirementsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'waterRequirements',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      waterRequirementsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'waterRequirements',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      waterRequirementsElementContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'waterRequirements',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      waterRequirementsElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'waterRequirements',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      waterRequirementsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'waterRequirements',
        value: '',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      waterRequirementsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'waterRequirements',
        value: '',
      ));
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      waterRequirementsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'waterRequirements',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition> waterRequirementsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'waterRequirements',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      waterRequirementsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'waterRequirements',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      waterRequirementsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'waterRequirements',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      waterRequirementsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'waterRequirements',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Plant, Plant, QAfterFilterCondition>
      waterRequirementsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'waterRequirements',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension PlantQueryObject on QueryBuilder<Plant, Plant, QFilterCondition> {}

extension PlantQueryLinks on QueryBuilder<Plant, Plant, QFilterCondition> {}

extension PlantQuerySortBy on QueryBuilder<Plant, Plant, QSortBy> {
  QueryBuilder<Plant, Plant, QAfterSortBy> sortByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> sortByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> sortByCustomName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customName', Sort.asc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> sortByCustomNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customName', Sort.desc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> sortByDaysToHarvest() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'daysToHarvest', Sort.asc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> sortByDaysToHarvestDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'daysToHarvest', Sort.desc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> sortByImageUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imageUrl', Sort.asc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> sortByImageUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imageUrl', Sort.desc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> sortByPropagationMethod() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'propagationMethod', Sort.asc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> sortByPropagationMethodDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'propagationMethod', Sort.desc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> sortByRowSpacing() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rowSpacing', Sort.asc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> sortByRowSpacingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rowSpacing', Sort.desc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> sortByScientificName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scientificName', Sort.asc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> sortByScientificNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scientificName', Sort.desc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> sortBySeedDepth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'seedDepth', Sort.asc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> sortBySeedDepthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'seedDepth', Sort.desc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> sortBySowFirstAfterLastFrostDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sowFirstAfterLastFrostDate', Sort.asc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy>
      sortBySowFirstAfterLastFrostDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sowFirstAfterLastFrostDate', Sort.desc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> sortBySowLastAfterLastFrostDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sowLastAfterLastFrostDate', Sort.asc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy>
      sortBySowLastAfterLastFrostDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sowLastAfterLastFrostDate', Sort.desc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> sortBySowLastBeforeLastFrostDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sowLastBeforeLastFrostDate', Sort.asc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy>
      sortBySowLastBeforeLastFrostDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sowLastBeforeLastFrostDate', Sort.desc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> sortBySowMethod() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sowMethod', Sort.asc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> sortBySowMethodDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sowMethod', Sort.desc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> sortBySowRightBeforeLastFrostDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sowRightBeforeLastFrostDate', Sort.asc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy>
      sortBySowRightBeforeLastFrostDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sowRightBeforeLastFrostDate', Sort.desc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> sortBySpacing() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'spacing', Sort.asc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> sortBySpacingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'spacing', Sort.desc);
    });
  }
}

extension PlantQuerySortThenBy on QueryBuilder<Plant, Plant, QSortThenBy> {
  QueryBuilder<Plant, Plant, QAfterSortBy> thenByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> thenByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> thenByCustomName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customName', Sort.asc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> thenByCustomNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customName', Sort.desc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> thenByDaysToHarvest() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'daysToHarvest', Sort.asc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> thenByDaysToHarvestDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'daysToHarvest', Sort.desc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> thenByImageUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imageUrl', Sort.asc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> thenByImageUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imageUrl', Sort.desc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> thenByPropagationMethod() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'propagationMethod', Sort.asc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> thenByPropagationMethodDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'propagationMethod', Sort.desc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> thenByRowSpacing() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rowSpacing', Sort.asc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> thenByRowSpacingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rowSpacing', Sort.desc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> thenByScientificName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scientificName', Sort.asc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> thenByScientificNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scientificName', Sort.desc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> thenBySeedDepth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'seedDepth', Sort.asc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> thenBySeedDepthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'seedDepth', Sort.desc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> thenBySowFirstAfterLastFrostDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sowFirstAfterLastFrostDate', Sort.asc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy>
      thenBySowFirstAfterLastFrostDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sowFirstAfterLastFrostDate', Sort.desc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> thenBySowLastAfterLastFrostDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sowLastAfterLastFrostDate', Sort.asc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy>
      thenBySowLastAfterLastFrostDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sowLastAfterLastFrostDate', Sort.desc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> thenBySowLastBeforeLastFrostDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sowLastBeforeLastFrostDate', Sort.asc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy>
      thenBySowLastBeforeLastFrostDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sowLastBeforeLastFrostDate', Sort.desc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> thenBySowMethod() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sowMethod', Sort.asc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> thenBySowMethodDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sowMethod', Sort.desc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> thenBySowRightBeforeLastFrostDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sowRightBeforeLastFrostDate', Sort.asc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy>
      thenBySowRightBeforeLastFrostDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sowRightBeforeLastFrostDate', Sort.desc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> thenBySpacing() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'spacing', Sort.asc);
    });
  }

  QueryBuilder<Plant, Plant, QAfterSortBy> thenBySpacingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'spacing', Sort.desc);
    });
  }
}

extension PlantQueryWhereDistinct on QueryBuilder<Plant, Plant, QDistinct> {
  QueryBuilder<Plant, Plant, QDistinct> distinctByAntagonists() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'antagonists');
    });
  }

  QueryBuilder<Plant, Plant, QDistinct> distinctByCategory(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'category', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Plant, Plant, QDistinct> distinctByCompanions() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'companions');
    });
  }

  QueryBuilder<Plant, Plant, QDistinct> distinctByCustomName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'customName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Plant, Plant, QDistinct> distinctByDaysToHarvest() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'daysToHarvest');
    });
  }

  QueryBuilder<Plant, Plant, QDistinct> distinctByDescription(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Plant, Plant, QDistinct> distinctByImageUrl(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'imageUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Plant, Plant, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Plant, Plant, QDistinct> distinctByPropagationMethod(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'propagationMethod',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Plant, Plant, QDistinct> distinctByRowSpacing(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rowSpacing', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Plant, Plant, QDistinct> distinctByScientificName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'scientificName',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Plant, Plant, QDistinct> distinctBySeedDepth(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'seedDepth', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Plant, Plant, QDistinct> distinctBySowFirstAfterLastFrostDate(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sowFirstAfterLastFrostDate',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Plant, Plant, QDistinct> distinctBySowLastAfterLastFrostDate(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sowLastAfterLastFrostDate',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Plant, Plant, QDistinct> distinctBySowLastBeforeLastFrostDate(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sowLastBeforeLastFrostDate',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Plant, Plant, QDistinct> distinctBySowMethod(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sowMethod', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Plant, Plant, QDistinct> distinctBySowRightBeforeLastFrostDate(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sowRightBeforeLastFrostDate',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Plant, Plant, QDistinct> distinctBySpacing(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'spacing', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Plant, Plant, QDistinct> distinctBySunRequirements() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sunRequirements');
    });
  }

  QueryBuilder<Plant, Plant, QDistinct> distinctByWaterRequirements() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'waterRequirements');
    });
  }
}

extension PlantQueryProperty on QueryBuilder<Plant, Plant, QQueryProperty> {
  QueryBuilder<Plant, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Plant, List<String>?, QQueryOperations> antagonistsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'antagonists');
    });
  }

  QueryBuilder<Plant, String?, QQueryOperations> categoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'category');
    });
  }

  QueryBuilder<Plant, List<String>?, QQueryOperations> companionsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'companions');
    });
  }

  QueryBuilder<Plant, String?, QQueryOperations> customNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'customName');
    });
  }

  QueryBuilder<Plant, int?, QQueryOperations> daysToHarvestProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'daysToHarvest');
    });
  }

  QueryBuilder<Plant, String?, QQueryOperations> descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<Plant, String?, QQueryOperations> imageUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'imageUrl');
    });
  }

  QueryBuilder<Plant, String?, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<Plant, String?, QQueryOperations> propagationMethodProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'propagationMethod');
    });
  }

  QueryBuilder<Plant, String?, QQueryOperations> rowSpacingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rowSpacing');
    });
  }

  QueryBuilder<Plant, String?, QQueryOperations> scientificNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'scientificName');
    });
  }

  QueryBuilder<Plant, String?, QQueryOperations> seedDepthProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'seedDepth');
    });
  }

  QueryBuilder<Plant, String?, QQueryOperations>
      sowFirstAfterLastFrostDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sowFirstAfterLastFrostDate');
    });
  }

  QueryBuilder<Plant, String?, QQueryOperations>
      sowLastAfterLastFrostDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sowLastAfterLastFrostDate');
    });
  }

  QueryBuilder<Plant, String?, QQueryOperations>
      sowLastBeforeLastFrostDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sowLastBeforeLastFrostDate');
    });
  }

  QueryBuilder<Plant, String?, QQueryOperations> sowMethodProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sowMethod');
    });
  }

  QueryBuilder<Plant, String?, QQueryOperations>
      sowRightBeforeLastFrostDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sowRightBeforeLastFrostDate');
    });
  }

  QueryBuilder<Plant, String?, QQueryOperations> spacingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'spacing');
    });
  }

  QueryBuilder<Plant, List<String>?, QQueryOperations>
      sunRequirementsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sunRequirements');
    });
  }

  QueryBuilder<Plant, List<String>?, QQueryOperations>
      waterRequirementsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'waterRequirements');
    });
  }
}
