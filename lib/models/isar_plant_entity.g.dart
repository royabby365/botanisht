// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'isar_plant_entity.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPlantEntityCollection on Isar {
  IsarCollection<PlantEntity> get plantEntitys => this.collection();
}

const PlantEntitySchema = CollectionSchema(
  name: r'PlantEntity',
  id: -8929794816181339717,
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
    r'isPetSafe': PropertySchema(
      id: 7,
      name: r'isPetSafe',
      type: IsarType.bool,
    ),
    r'name': PropertySchema(
      id: 8,
      name: r'name',
      type: IsarType.string,
    ),
    r'propagationMethod': PropertySchema(
      id: 9,
      name: r'propagationMethod',
      type: IsarType.string,
    ),
    r'rowSpacing': PropertySchema(
      id: 10,
      name: r'rowSpacing',
      type: IsarType.string,
    ),
    r'scientificName': PropertySchema(
      id: 11,
      name: r'scientificName',
      type: IsarType.string,
    ),
    r'seedDepth': PropertySchema(
      id: 12,
      name: r'seedDepth',
      type: IsarType.string,
    ),
    r'sowFirstAfterLastFrostDate': PropertySchema(
      id: 13,
      name: r'sowFirstAfterLastFrostDate',
      type: IsarType.string,
    ),
    r'sowLastAfterLastFrostDate': PropertySchema(
      id: 14,
      name: r'sowLastAfterLastFrostDate',
      type: IsarType.string,
    ),
    r'sowLastBeforeLastFrostDate': PropertySchema(
      id: 15,
      name: r'sowLastBeforeLastFrostDate',
      type: IsarType.string,
    ),
    r'sowMethod': PropertySchema(
      id: 16,
      name: r'sowMethod',
      type: IsarType.string,
    ),
    r'sowRightBeforeLastFrostDate': PropertySchema(
      id: 17,
      name: r'sowRightBeforeLastFrostDate',
      type: IsarType.string,
    ),
    r'spacing': PropertySchema(
      id: 18,
      name: r'spacing',
      type: IsarType.string,
    ),
    r'sunRequirements': PropertySchema(
      id: 19,
      name: r'sunRequirements',
      type: IsarType.stringList,
    ),
    r'waterRequirements': PropertySchema(
      id: 20,
      name: r'waterRequirements',
      type: IsarType.stringList,
    )
  },
  estimateSize: _plantEntityEstimateSize,
  serialize: _plantEntitySerialize,
  deserialize: _plantEntityDeserialize,
  deserializeProp: _plantEntityDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _plantEntityGetId,
  getLinks: _plantEntityGetLinks,
  attach: _plantEntityAttach,
  version: '3.1.0+1',
);

int _plantEntityEstimateSize(
  PlantEntity object,
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

void _plantEntitySerialize(
  PlantEntity object,
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
  writer.writeBool(offsets[7], object.isPetSafe);
  writer.writeString(offsets[8], object.name);
  writer.writeString(offsets[9], object.propagationMethod);
  writer.writeString(offsets[10], object.rowSpacing);
  writer.writeString(offsets[11], object.scientificName);
  writer.writeString(offsets[12], object.seedDepth);
  writer.writeString(offsets[13], object.sowFirstAfterLastFrostDate);
  writer.writeString(offsets[14], object.sowLastAfterLastFrostDate);
  writer.writeString(offsets[15], object.sowLastBeforeLastFrostDate);
  writer.writeString(offsets[16], object.sowMethod);
  writer.writeString(offsets[17], object.sowRightBeforeLastFrostDate);
  writer.writeString(offsets[18], object.spacing);
  writer.writeStringList(offsets[19], object.sunRequirements);
  writer.writeStringList(offsets[20], object.waterRequirements);
}

PlantEntity _plantEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PlantEntity();
  object.antagonists = reader.readStringList(offsets[0]);
  object.category = reader.readStringOrNull(offsets[1]);
  object.companions = reader.readStringList(offsets[2]);
  object.customName = reader.readStringOrNull(offsets[3]);
  object.daysToHarvest = reader.readLongOrNull(offsets[4]);
  object.description = reader.readStringOrNull(offsets[5]);
  object.id = id;
  object.imageUrl = reader.readStringOrNull(offsets[6]);
  object.isPetSafe = reader.readBoolOrNull(offsets[7]);
  object.name = reader.readStringOrNull(offsets[8]);
  object.propagationMethod = reader.readStringOrNull(offsets[9]);
  object.rowSpacing = reader.readStringOrNull(offsets[10]);
  object.scientificName = reader.readStringOrNull(offsets[11]);
  object.seedDepth = reader.readStringOrNull(offsets[12]);
  object.sowFirstAfterLastFrostDate = reader.readStringOrNull(offsets[13]);
  object.sowLastAfterLastFrostDate = reader.readStringOrNull(offsets[14]);
  object.sowLastBeforeLastFrostDate = reader.readStringOrNull(offsets[15]);
  object.sowMethod = reader.readStringOrNull(offsets[16]);
  object.sowRightBeforeLastFrostDate = reader.readStringOrNull(offsets[17]);
  object.spacing = reader.readStringOrNull(offsets[18]);
  object.sunRequirements = reader.readStringList(offsets[19]);
  object.waterRequirements = reader.readStringList(offsets[20]);
  return object;
}

P _plantEntityDeserializeProp<P>(
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
      return (reader.readBoolOrNull(offset)) as P;
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
      return (reader.readStringOrNull(offset)) as P;
    case 19:
      return (reader.readStringList(offset)) as P;
    case 20:
      return (reader.readStringList(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _plantEntityGetId(PlantEntity object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _plantEntityGetLinks(PlantEntity object) {
  return [];
}

void _plantEntityAttach(
    IsarCollection<dynamic> col, Id id, PlantEntity object) {
  object.id = id;
}

extension PlantEntityQueryWhereSort
    on QueryBuilder<PlantEntity, PlantEntity, QWhere> {
  QueryBuilder<PlantEntity, PlantEntity, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension PlantEntityQueryWhere
    on QueryBuilder<PlantEntity, PlantEntity, QWhereClause> {
  QueryBuilder<PlantEntity, PlantEntity, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterWhereClause> idBetween(
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

extension PlantEntityQueryFilter
    on QueryBuilder<PlantEntity, PlantEntity, QFilterCondition> {
  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      antagonistsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'antagonists',
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      antagonistsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'antagonists',
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      antagonistsElementEqualTo(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      antagonistsElementLessThan(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      antagonistsElementBetween(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      antagonistsElementEndsWith(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      antagonistsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'antagonists',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      antagonistsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'antagonists',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      antagonistsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'antagonists',
        value: '',
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      antagonistsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'antagonists',
        value: '',
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      antagonistsLengthEqualTo(int length) {
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      antagonistsIsEmpty() {
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      antagonistsIsNotEmpty() {
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      antagonistsLengthLessThan(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      antagonistsLengthBetween(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      categoryIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'category',
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      categoryIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'category',
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition> categoryEqualTo(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      categoryGreaterThan(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      categoryLessThan(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition> categoryBetween(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      categoryStartsWith(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      categoryEndsWith(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      categoryContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition> categoryMatches(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      categoryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category',
        value: '',
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      categoryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'category',
        value: '',
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      companionsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'companions',
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      companionsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'companions',
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      companionsElementEqualTo(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      companionsElementLessThan(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      companionsElementBetween(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      companionsElementStartsWith(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      companionsElementEndsWith(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      companionsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'companions',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      companionsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'companions',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      companionsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'companions',
        value: '',
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      companionsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'companions',
        value: '',
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      companionsLengthEqualTo(int length) {
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      companionsIsEmpty() {
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      companionsIsNotEmpty() {
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      companionsLengthLessThan(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      companionsLengthGreaterThan(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      companionsLengthBetween(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      customNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'customName',
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      customNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'customName',
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      customNameEqualTo(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      customNameLessThan(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      customNameBetween(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      customNameEndsWith(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      customNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'customName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      customNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'customName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      customNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'customName',
        value: '',
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      customNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'customName',
        value: '',
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      daysToHarvestIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'daysToHarvest',
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      daysToHarvestIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'daysToHarvest',
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      daysToHarvestEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'daysToHarvest',
        value: value,
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      daysToHarvestGreaterThan(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      daysToHarvestLessThan(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      daysToHarvestBetween(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      descriptionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      descriptionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      descriptionEqualTo(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      descriptionGreaterThan(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      descriptionLessThan(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      descriptionBetween(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      descriptionStartsWith(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      descriptionEndsWith(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      descriptionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      descriptionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'description',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition> idBetween(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      imageUrlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'imageUrl',
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      imageUrlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'imageUrl',
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition> imageUrlEqualTo(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      imageUrlGreaterThan(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      imageUrlLessThan(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition> imageUrlBetween(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      imageUrlStartsWith(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      imageUrlEndsWith(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      imageUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'imageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition> imageUrlMatches(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      imageUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imageUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      imageUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'imageUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      isPetSafeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isPetSafe',
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      isPetSafeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isPetSafe',
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      isPetSafeEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isPetSafe',
        value: value,
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition> nameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      nameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition> nameEqualTo(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition> nameGreaterThan(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition> nameLessThan(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition> nameBetween(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition> nameStartsWith(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition> nameEndsWith(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      propagationMethodIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'propagationMethod',
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      propagationMethodIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'propagationMethod',
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      propagationMethodEqualTo(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      propagationMethodLessThan(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      propagationMethodBetween(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      propagationMethodStartsWith(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      propagationMethodEndsWith(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      propagationMethodContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'propagationMethod',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      propagationMethodMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'propagationMethod',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      propagationMethodIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'propagationMethod',
        value: '',
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      propagationMethodIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'propagationMethod',
        value: '',
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      rowSpacingIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'rowSpacing',
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      rowSpacingIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'rowSpacing',
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      rowSpacingEqualTo(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      rowSpacingGreaterThan(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      rowSpacingLessThan(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      rowSpacingBetween(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      rowSpacingStartsWith(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      rowSpacingEndsWith(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      rowSpacingContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'rowSpacing',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      rowSpacingMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'rowSpacing',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      rowSpacingIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rowSpacing',
        value: '',
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      rowSpacingIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'rowSpacing',
        value: '',
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      scientificNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'scientificName',
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      scientificNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'scientificName',
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      scientificNameEqualTo(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      scientificNameGreaterThan(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      scientificNameLessThan(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      scientificNameBetween(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      scientificNameStartsWith(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      scientificNameEndsWith(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      scientificNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'scientificName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      scientificNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'scientificName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      scientificNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'scientificName',
        value: '',
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      scientificNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'scientificName',
        value: '',
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      seedDepthIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'seedDepth',
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      seedDepthIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'seedDepth',
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      seedDepthEqualTo(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      seedDepthGreaterThan(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      seedDepthLessThan(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      seedDepthBetween(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      seedDepthStartsWith(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      seedDepthEndsWith(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      seedDepthContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'seedDepth',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      seedDepthMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'seedDepth',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      seedDepthIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'seedDepth',
        value: '',
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      seedDepthIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'seedDepth',
        value: '',
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      sowFirstAfterLastFrostDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'sowFirstAfterLastFrostDate',
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      sowFirstAfterLastFrostDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'sowFirstAfterLastFrostDate',
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      sowFirstAfterLastFrostDateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sowFirstAfterLastFrostDate',
        value: '',
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      sowFirstAfterLastFrostDateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sowFirstAfterLastFrostDate',
        value: '',
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      sowLastAfterLastFrostDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'sowLastAfterLastFrostDate',
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      sowLastAfterLastFrostDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'sowLastAfterLastFrostDate',
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      sowLastAfterLastFrostDateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sowLastAfterLastFrostDate',
        value: '',
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      sowLastAfterLastFrostDateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sowLastAfterLastFrostDate',
        value: '',
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      sowLastBeforeLastFrostDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'sowLastBeforeLastFrostDate',
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      sowLastBeforeLastFrostDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'sowLastBeforeLastFrostDate',
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      sowLastBeforeLastFrostDateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sowLastBeforeLastFrostDate',
        value: '',
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      sowLastBeforeLastFrostDateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sowLastBeforeLastFrostDate',
        value: '',
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      sowMethodIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'sowMethod',
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      sowMethodIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'sowMethod',
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      sowMethodEqualTo(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      sowMethodGreaterThan(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      sowMethodLessThan(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      sowMethodBetween(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      sowMethodStartsWith(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      sowMethodEndsWith(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      sowMethodContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'sowMethod',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      sowMethodMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'sowMethod',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      sowMethodIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sowMethod',
        value: '',
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      sowMethodIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sowMethod',
        value: '',
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      sowRightBeforeLastFrostDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'sowRightBeforeLastFrostDate',
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      sowRightBeforeLastFrostDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'sowRightBeforeLastFrostDate',
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      sowRightBeforeLastFrostDateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sowRightBeforeLastFrostDate',
        value: '',
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      sowRightBeforeLastFrostDateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sowRightBeforeLastFrostDate',
        value: '',
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      spacingIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'spacing',
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      spacingIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'spacing',
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition> spacingEqualTo(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      spacingGreaterThan(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition> spacingLessThan(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition> spacingBetween(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      spacingStartsWith(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition> spacingEndsWith(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition> spacingContains(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition> spacingMatches(
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      spacingIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'spacing',
        value: '',
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      spacingIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'spacing',
        value: '',
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      sunRequirementsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'sunRequirements',
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      sunRequirementsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'sunRequirements',
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      sunRequirementsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sunRequirements',
        value: '',
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      sunRequirementsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sunRequirements',
        value: '',
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      sunRequirementsIsEmpty() {
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      waterRequirementsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'waterRequirements',
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      waterRequirementsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'waterRequirements',
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      waterRequirementsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'waterRequirements',
        value: '',
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      waterRequirementsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'waterRequirements',
        value: '',
      ));
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
      waterRequirementsIsEmpty() {
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
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

  QueryBuilder<PlantEntity, PlantEntity, QAfterFilterCondition>
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

extension PlantEntityQueryObject
    on QueryBuilder<PlantEntity, PlantEntity, QFilterCondition> {}

extension PlantEntityQueryLinks
    on QueryBuilder<PlantEntity, PlantEntity, QFilterCondition> {}

extension PlantEntityQuerySortBy
    on QueryBuilder<PlantEntity, PlantEntity, QSortBy> {
  QueryBuilder<PlantEntity, PlantEntity, QAfterSortBy> sortByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterSortBy> sortByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterSortBy> sortByCustomName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customName', Sort.asc);
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterSortBy> sortByCustomNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customName', Sort.desc);
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterSortBy> sortByDaysToHarvest() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'daysToHarvest', Sort.asc);
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterSortBy>
      sortByDaysToHarvestDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'daysToHarvest', Sort.desc);
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterSortBy> sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterSortBy> sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterSortBy> sortByImageUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imageUrl', Sort.asc);
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterSortBy> sortByImageUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imageUrl', Sort.desc);
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterSortBy> sortByIsPetSafe() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPetSafe', Sort.asc);
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterSortBy> sortByIsPetSafeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPetSafe', Sort.desc);
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterSortBy>
      sortByPropagationMethod() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'propagationMethod', Sort.asc);
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterSortBy>
      sortByPropagationMethodDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'propagationMethod', Sort.desc);
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterSortBy> sortByRowSpacing() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rowSpacing', Sort.asc);
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterSortBy> sortByRowSpacingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rowSpacing', Sort.desc);
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterSortBy> sortByScientificName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scientificName', Sort.asc);
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterSortBy>
      sortByScientificNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scientificName', Sort.desc);
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterSortBy> sortBySeedDepth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'seedDepth', Sort.asc);
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterSortBy> sortBySeedDepthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'seedDepth', Sort.desc);
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterSortBy>
      sortBySowFirstAfterLastFrostDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sowFirstAfterLastFrostDate', Sort.asc);
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterSortBy>
      sortBySowFirstAfterLastFrostDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sowFirstAfterLastFrostDate', Sort.desc);
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterSortBy>
      sortBySowLastAfterLastFrostDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sowLastAfterLastFrostDate', Sort.asc);
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterSortBy>
      sortBySowLastAfterLastFrostDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sowLastAfterLastFrostDate', Sort.desc);
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterSortBy>
      sortBySowLastBeforeLastFrostDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sowLastBeforeLastFrostDate', Sort.asc);
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterSortBy>
      sortBySowLastBeforeLastFrostDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sowLastBeforeLastFrostDate', Sort.desc);
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterSortBy> sortBySowMethod() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sowMethod', Sort.asc);
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterSortBy> sortBySowMethodDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sowMethod', Sort.desc);
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterSortBy>
      sortBySowRightBeforeLastFrostDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sowRightBeforeLastFrostDate', Sort.asc);
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterSortBy>
      sortBySowRightBeforeLastFrostDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sowRightBeforeLastFrostDate', Sort.desc);
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterSortBy> sortBySpacing() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'spacing', Sort.asc);
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterSortBy> sortBySpacingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'spacing', Sort.desc);
    });
  }
}

extension PlantEntityQuerySortThenBy
    on QueryBuilder<PlantEntity, PlantEntity, QSortThenBy> {
  QueryBuilder<PlantEntity, PlantEntity, QAfterSortBy> thenByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterSortBy> thenByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterSortBy> thenByCustomName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customName', Sort.asc);
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterSortBy> thenByCustomNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customName', Sort.desc);
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterSortBy> thenByDaysToHarvest() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'daysToHarvest', Sort.asc);
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterSortBy>
      thenByDaysToHarvestDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'daysToHarvest', Sort.desc);
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterSortBy> thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterSortBy> thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterSortBy> thenByImageUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imageUrl', Sort.asc);
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterSortBy> thenByImageUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imageUrl', Sort.desc);
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterSortBy> thenByIsPetSafe() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPetSafe', Sort.asc);
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterSortBy> thenByIsPetSafeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPetSafe', Sort.desc);
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterSortBy>
      thenByPropagationMethod() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'propagationMethod', Sort.asc);
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterSortBy>
      thenByPropagationMethodDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'propagationMethod', Sort.desc);
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterSortBy> thenByRowSpacing() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rowSpacing', Sort.asc);
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterSortBy> thenByRowSpacingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rowSpacing', Sort.desc);
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterSortBy> thenByScientificName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scientificName', Sort.asc);
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterSortBy>
      thenByScientificNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scientificName', Sort.desc);
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterSortBy> thenBySeedDepth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'seedDepth', Sort.asc);
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterSortBy> thenBySeedDepthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'seedDepth', Sort.desc);
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterSortBy>
      thenBySowFirstAfterLastFrostDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sowFirstAfterLastFrostDate', Sort.asc);
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterSortBy>
      thenBySowFirstAfterLastFrostDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sowFirstAfterLastFrostDate', Sort.desc);
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterSortBy>
      thenBySowLastAfterLastFrostDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sowLastAfterLastFrostDate', Sort.asc);
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterSortBy>
      thenBySowLastAfterLastFrostDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sowLastAfterLastFrostDate', Sort.desc);
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterSortBy>
      thenBySowLastBeforeLastFrostDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sowLastBeforeLastFrostDate', Sort.asc);
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterSortBy>
      thenBySowLastBeforeLastFrostDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sowLastBeforeLastFrostDate', Sort.desc);
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterSortBy> thenBySowMethod() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sowMethod', Sort.asc);
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterSortBy> thenBySowMethodDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sowMethod', Sort.desc);
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterSortBy>
      thenBySowRightBeforeLastFrostDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sowRightBeforeLastFrostDate', Sort.asc);
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterSortBy>
      thenBySowRightBeforeLastFrostDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sowRightBeforeLastFrostDate', Sort.desc);
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterSortBy> thenBySpacing() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'spacing', Sort.asc);
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QAfterSortBy> thenBySpacingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'spacing', Sort.desc);
    });
  }
}

extension PlantEntityQueryWhereDistinct
    on QueryBuilder<PlantEntity, PlantEntity, QDistinct> {
  QueryBuilder<PlantEntity, PlantEntity, QDistinct> distinctByAntagonists() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'antagonists');
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QDistinct> distinctByCategory(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'category', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QDistinct> distinctByCompanions() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'companions');
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QDistinct> distinctByCustomName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'customName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QDistinct> distinctByDaysToHarvest() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'daysToHarvest');
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QDistinct> distinctByDescription(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QDistinct> distinctByImageUrl(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'imageUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QDistinct> distinctByIsPetSafe() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isPetSafe');
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QDistinct> distinctByPropagationMethod(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'propagationMethod',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QDistinct> distinctByRowSpacing(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rowSpacing', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QDistinct> distinctByScientificName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'scientificName',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QDistinct> distinctBySeedDepth(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'seedDepth', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QDistinct>
      distinctBySowFirstAfterLastFrostDate({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sowFirstAfterLastFrostDate',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QDistinct>
      distinctBySowLastAfterLastFrostDate({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sowLastAfterLastFrostDate',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QDistinct>
      distinctBySowLastBeforeLastFrostDate({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sowLastBeforeLastFrostDate',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QDistinct> distinctBySowMethod(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sowMethod', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QDistinct>
      distinctBySowRightBeforeLastFrostDate({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sowRightBeforeLastFrostDate',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QDistinct> distinctBySpacing(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'spacing', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QDistinct>
      distinctBySunRequirements() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sunRequirements');
    });
  }

  QueryBuilder<PlantEntity, PlantEntity, QDistinct>
      distinctByWaterRequirements() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'waterRequirements');
    });
  }
}

extension PlantEntityQueryProperty
    on QueryBuilder<PlantEntity, PlantEntity, QQueryProperty> {
  QueryBuilder<PlantEntity, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<PlantEntity, List<String>?, QQueryOperations>
      antagonistsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'antagonists');
    });
  }

  QueryBuilder<PlantEntity, String?, QQueryOperations> categoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'category');
    });
  }

  QueryBuilder<PlantEntity, List<String>?, QQueryOperations>
      companionsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'companions');
    });
  }

  QueryBuilder<PlantEntity, String?, QQueryOperations> customNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'customName');
    });
  }

  QueryBuilder<PlantEntity, int?, QQueryOperations> daysToHarvestProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'daysToHarvest');
    });
  }

  QueryBuilder<PlantEntity, String?, QQueryOperations> descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<PlantEntity, String?, QQueryOperations> imageUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'imageUrl');
    });
  }

  QueryBuilder<PlantEntity, bool?, QQueryOperations> isPetSafeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isPetSafe');
    });
  }

  QueryBuilder<PlantEntity, String?, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<PlantEntity, String?, QQueryOperations>
      propagationMethodProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'propagationMethod');
    });
  }

  QueryBuilder<PlantEntity, String?, QQueryOperations> rowSpacingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rowSpacing');
    });
  }

  QueryBuilder<PlantEntity, String?, QQueryOperations>
      scientificNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'scientificName');
    });
  }

  QueryBuilder<PlantEntity, String?, QQueryOperations> seedDepthProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'seedDepth');
    });
  }

  QueryBuilder<PlantEntity, String?, QQueryOperations>
      sowFirstAfterLastFrostDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sowFirstAfterLastFrostDate');
    });
  }

  QueryBuilder<PlantEntity, String?, QQueryOperations>
      sowLastAfterLastFrostDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sowLastAfterLastFrostDate');
    });
  }

  QueryBuilder<PlantEntity, String?, QQueryOperations>
      sowLastBeforeLastFrostDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sowLastBeforeLastFrostDate');
    });
  }

  QueryBuilder<PlantEntity, String?, QQueryOperations> sowMethodProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sowMethod');
    });
  }

  QueryBuilder<PlantEntity, String?, QQueryOperations>
      sowRightBeforeLastFrostDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sowRightBeforeLastFrostDate');
    });
  }

  QueryBuilder<PlantEntity, String?, QQueryOperations> spacingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'spacing');
    });
  }

  QueryBuilder<PlantEntity, List<String>?, QQueryOperations>
      sunRequirementsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sunRequirements');
    });
  }

  QueryBuilder<PlantEntity, List<String>?, QQueryOperations>
      waterRequirementsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'waterRequirements');
    });
  }
}
