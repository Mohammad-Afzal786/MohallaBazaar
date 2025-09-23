// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_categorydetails_cache_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetParentCategoryDetailsCacheModelCollection on Isar {
  IsarCollection<ParentCategoryDetailsCacheModel>
      get parentCategoryDetailsCacheModels => this.collection();
}

const ParentCategoryDetailsCacheModelSchema = CollectionSchema(
  name: r'ParentCategoryDetailsCacheModel',
  id: -9125275557771083158,
  properties: {
    r'jsonData': PropertySchema(
      id: 0,
      name: r'jsonData',
      type: IsarType.string,
    ),
    r'lastUpdated': PropertySchema(
      id: 1,
      name: r'lastUpdated',
      type: IsarType.dateTime,
    ),
    r'parentCategoryId': PropertySchema(
      id: 2,
      name: r'parentCategoryId',
      type: IsarType.string,
    )
  },
  estimateSize: _parentCategoryDetailsCacheModelEstimateSize,
  serialize: _parentCategoryDetailsCacheModelSerialize,
  deserialize: _parentCategoryDetailsCacheModelDeserialize,
  deserializeProp: _parentCategoryDetailsCacheModelDeserializeProp,
  idName: r'id',
  indexes: {
    r'parentCategoryId': IndexSchema(
      id: 5864530915595842898,
      name: r'parentCategoryId',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'parentCategoryId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _parentCategoryDetailsCacheModelGetId,
  getLinks: _parentCategoryDetailsCacheModelGetLinks,
  attach: _parentCategoryDetailsCacheModelAttach,
  version: '3.1.0+1',
);

int _parentCategoryDetailsCacheModelEstimateSize(
  ParentCategoryDetailsCacheModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.jsonData.length * 3;
  bytesCount += 3 + object.parentCategoryId.length * 3;
  return bytesCount;
}

void _parentCategoryDetailsCacheModelSerialize(
  ParentCategoryDetailsCacheModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.jsonData);
  writer.writeDateTime(offsets[1], object.lastUpdated);
  writer.writeString(offsets[2], object.parentCategoryId);
}

ParentCategoryDetailsCacheModel _parentCategoryDetailsCacheModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ParentCategoryDetailsCacheModel();
  object.id = id;
  object.jsonData = reader.readString(offsets[0]);
  object.lastUpdated = reader.readDateTime(offsets[1]);
  object.parentCategoryId = reader.readString(offsets[2]);
  return object;
}

P _parentCategoryDetailsCacheModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _parentCategoryDetailsCacheModelGetId(
    ParentCategoryDetailsCacheModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _parentCategoryDetailsCacheModelGetLinks(
    ParentCategoryDetailsCacheModel object) {
  return [];
}

void _parentCategoryDetailsCacheModelAttach(IsarCollection<dynamic> col, Id id,
    ParentCategoryDetailsCacheModel object) {
  object.id = id;
}

extension ParentCategoryDetailsCacheModelByIndex
    on IsarCollection<ParentCategoryDetailsCacheModel> {
  Future<ParentCategoryDetailsCacheModel?> getByParentCategoryId(
      String parentCategoryId) {
    return getByIndex(r'parentCategoryId', [parentCategoryId]);
  }

  ParentCategoryDetailsCacheModel? getByParentCategoryIdSync(
      String parentCategoryId) {
    return getByIndexSync(r'parentCategoryId', [parentCategoryId]);
  }

  Future<bool> deleteByParentCategoryId(String parentCategoryId) {
    return deleteByIndex(r'parentCategoryId', [parentCategoryId]);
  }

  bool deleteByParentCategoryIdSync(String parentCategoryId) {
    return deleteByIndexSync(r'parentCategoryId', [parentCategoryId]);
  }

  Future<List<ParentCategoryDetailsCacheModel?>> getAllByParentCategoryId(
      List<String> parentCategoryIdValues) {
    final values = parentCategoryIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'parentCategoryId', values);
  }

  List<ParentCategoryDetailsCacheModel?> getAllByParentCategoryIdSync(
      List<String> parentCategoryIdValues) {
    final values = parentCategoryIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'parentCategoryId', values);
  }

  Future<int> deleteAllByParentCategoryId(List<String> parentCategoryIdValues) {
    final values = parentCategoryIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'parentCategoryId', values);
  }

  int deleteAllByParentCategoryIdSync(List<String> parentCategoryIdValues) {
    final values = parentCategoryIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'parentCategoryId', values);
  }

  Future<Id> putByParentCategoryId(ParentCategoryDetailsCacheModel object) {
    return putByIndex(r'parentCategoryId', object);
  }

  Id putByParentCategoryIdSync(ParentCategoryDetailsCacheModel object,
      {bool saveLinks = true}) {
    return putByIndexSync(r'parentCategoryId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByParentCategoryId(
      List<ParentCategoryDetailsCacheModel> objects) {
    return putAllByIndex(r'parentCategoryId', objects);
  }

  List<Id> putAllByParentCategoryIdSync(
      List<ParentCategoryDetailsCacheModel> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'parentCategoryId', objects,
        saveLinks: saveLinks);
  }
}

extension ParentCategoryDetailsCacheModelQueryWhereSort on QueryBuilder<
    ParentCategoryDetailsCacheModel, ParentCategoryDetailsCacheModel, QWhere> {
  QueryBuilder<ParentCategoryDetailsCacheModel, ParentCategoryDetailsCacheModel,
      QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ParentCategoryDetailsCacheModelQueryWhere on QueryBuilder<
    ParentCategoryDetailsCacheModel,
    ParentCategoryDetailsCacheModel,
    QWhereClause> {
  QueryBuilder<ParentCategoryDetailsCacheModel, ParentCategoryDetailsCacheModel,
      QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ParentCategoryDetailsCacheModel, ParentCategoryDetailsCacheModel,
      QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<ParentCategoryDetailsCacheModel, ParentCategoryDetailsCacheModel,
      QAfterWhereClause> idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ParentCategoryDetailsCacheModel, ParentCategoryDetailsCacheModel,
      QAfterWhereClause> idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ParentCategoryDetailsCacheModel, ParentCategoryDetailsCacheModel,
      QAfterWhereClause> idBetween(
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

  QueryBuilder<ParentCategoryDetailsCacheModel, ParentCategoryDetailsCacheModel,
      QAfterWhereClause> parentCategoryIdEqualTo(String parentCategoryId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'parentCategoryId',
        value: [parentCategoryId],
      ));
    });
  }

  QueryBuilder<ParentCategoryDetailsCacheModel, ParentCategoryDetailsCacheModel,
      QAfterWhereClause> parentCategoryIdNotEqualTo(String parentCategoryId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'parentCategoryId',
              lower: [],
              upper: [parentCategoryId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'parentCategoryId',
              lower: [parentCategoryId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'parentCategoryId',
              lower: [parentCategoryId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'parentCategoryId',
              lower: [],
              upper: [parentCategoryId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension ParentCategoryDetailsCacheModelQueryFilter on QueryBuilder<
    ParentCategoryDetailsCacheModel,
    ParentCategoryDetailsCacheModel,
    QFilterCondition> {
  QueryBuilder<ParentCategoryDetailsCacheModel, ParentCategoryDetailsCacheModel,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ParentCategoryDetailsCacheModel, ParentCategoryDetailsCacheModel,
      QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<ParentCategoryDetailsCacheModel, ParentCategoryDetailsCacheModel,
      QAfterFilterCondition> idLessThan(
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

  QueryBuilder<ParentCategoryDetailsCacheModel, ParentCategoryDetailsCacheModel,
      QAfterFilterCondition> idBetween(
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

  QueryBuilder<ParentCategoryDetailsCacheModel, ParentCategoryDetailsCacheModel,
      QAfterFilterCondition> jsonDataEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'jsonData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParentCategoryDetailsCacheModel, ParentCategoryDetailsCacheModel,
      QAfterFilterCondition> jsonDataGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'jsonData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParentCategoryDetailsCacheModel, ParentCategoryDetailsCacheModel,
      QAfterFilterCondition> jsonDataLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'jsonData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParentCategoryDetailsCacheModel, ParentCategoryDetailsCacheModel,
      QAfterFilterCondition> jsonDataBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'jsonData',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParentCategoryDetailsCacheModel, ParentCategoryDetailsCacheModel,
      QAfterFilterCondition> jsonDataStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'jsonData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParentCategoryDetailsCacheModel, ParentCategoryDetailsCacheModel,
      QAfterFilterCondition> jsonDataEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'jsonData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParentCategoryDetailsCacheModel, ParentCategoryDetailsCacheModel,
          QAfterFilterCondition>
      jsonDataContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'jsonData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParentCategoryDetailsCacheModel, ParentCategoryDetailsCacheModel,
          QAfterFilterCondition>
      jsonDataMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'jsonData',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParentCategoryDetailsCacheModel, ParentCategoryDetailsCacheModel,
      QAfterFilterCondition> jsonDataIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'jsonData',
        value: '',
      ));
    });
  }

  QueryBuilder<ParentCategoryDetailsCacheModel, ParentCategoryDetailsCacheModel,
      QAfterFilterCondition> jsonDataIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'jsonData',
        value: '',
      ));
    });
  }

  QueryBuilder<ParentCategoryDetailsCacheModel, ParentCategoryDetailsCacheModel,
      QAfterFilterCondition> lastUpdatedEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastUpdated',
        value: value,
      ));
    });
  }

  QueryBuilder<ParentCategoryDetailsCacheModel, ParentCategoryDetailsCacheModel,
      QAfterFilterCondition> lastUpdatedGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastUpdated',
        value: value,
      ));
    });
  }

  QueryBuilder<ParentCategoryDetailsCacheModel, ParentCategoryDetailsCacheModel,
      QAfterFilterCondition> lastUpdatedLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastUpdated',
        value: value,
      ));
    });
  }

  QueryBuilder<ParentCategoryDetailsCacheModel, ParentCategoryDetailsCacheModel,
      QAfterFilterCondition> lastUpdatedBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastUpdated',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ParentCategoryDetailsCacheModel, ParentCategoryDetailsCacheModel,
      QAfterFilterCondition> parentCategoryIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'parentCategoryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParentCategoryDetailsCacheModel, ParentCategoryDetailsCacheModel,
      QAfterFilterCondition> parentCategoryIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'parentCategoryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParentCategoryDetailsCacheModel, ParentCategoryDetailsCacheModel,
      QAfterFilterCondition> parentCategoryIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'parentCategoryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParentCategoryDetailsCacheModel, ParentCategoryDetailsCacheModel,
      QAfterFilterCondition> parentCategoryIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'parentCategoryId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParentCategoryDetailsCacheModel, ParentCategoryDetailsCacheModel,
      QAfterFilterCondition> parentCategoryIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'parentCategoryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParentCategoryDetailsCacheModel, ParentCategoryDetailsCacheModel,
      QAfterFilterCondition> parentCategoryIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'parentCategoryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParentCategoryDetailsCacheModel, ParentCategoryDetailsCacheModel,
          QAfterFilterCondition>
      parentCategoryIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'parentCategoryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParentCategoryDetailsCacheModel, ParentCategoryDetailsCacheModel,
          QAfterFilterCondition>
      parentCategoryIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'parentCategoryId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ParentCategoryDetailsCacheModel, ParentCategoryDetailsCacheModel,
      QAfterFilterCondition> parentCategoryIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'parentCategoryId',
        value: '',
      ));
    });
  }

  QueryBuilder<ParentCategoryDetailsCacheModel, ParentCategoryDetailsCacheModel,
      QAfterFilterCondition> parentCategoryIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'parentCategoryId',
        value: '',
      ));
    });
  }
}

extension ParentCategoryDetailsCacheModelQueryObject on QueryBuilder<
    ParentCategoryDetailsCacheModel,
    ParentCategoryDetailsCacheModel,
    QFilterCondition> {}

extension ParentCategoryDetailsCacheModelQueryLinks on QueryBuilder<
    ParentCategoryDetailsCacheModel,
    ParentCategoryDetailsCacheModel,
    QFilterCondition> {}

extension ParentCategoryDetailsCacheModelQuerySortBy on QueryBuilder<
    ParentCategoryDetailsCacheModel, ParentCategoryDetailsCacheModel, QSortBy> {
  QueryBuilder<ParentCategoryDetailsCacheModel, ParentCategoryDetailsCacheModel,
      QAfterSortBy> sortByJsonData() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'jsonData', Sort.asc);
    });
  }

  QueryBuilder<ParentCategoryDetailsCacheModel, ParentCategoryDetailsCacheModel,
      QAfterSortBy> sortByJsonDataDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'jsonData', Sort.desc);
    });
  }

  QueryBuilder<ParentCategoryDetailsCacheModel, ParentCategoryDetailsCacheModel,
      QAfterSortBy> sortByLastUpdated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdated', Sort.asc);
    });
  }

  QueryBuilder<ParentCategoryDetailsCacheModel, ParentCategoryDetailsCacheModel,
      QAfterSortBy> sortByLastUpdatedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdated', Sort.desc);
    });
  }

  QueryBuilder<ParentCategoryDetailsCacheModel, ParentCategoryDetailsCacheModel,
      QAfterSortBy> sortByParentCategoryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentCategoryId', Sort.asc);
    });
  }

  QueryBuilder<ParentCategoryDetailsCacheModel, ParentCategoryDetailsCacheModel,
      QAfterSortBy> sortByParentCategoryIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentCategoryId', Sort.desc);
    });
  }
}

extension ParentCategoryDetailsCacheModelQuerySortThenBy on QueryBuilder<
    ParentCategoryDetailsCacheModel,
    ParentCategoryDetailsCacheModel,
    QSortThenBy> {
  QueryBuilder<ParentCategoryDetailsCacheModel, ParentCategoryDetailsCacheModel,
      QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ParentCategoryDetailsCacheModel, ParentCategoryDetailsCacheModel,
      QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ParentCategoryDetailsCacheModel, ParentCategoryDetailsCacheModel,
      QAfterSortBy> thenByJsonData() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'jsonData', Sort.asc);
    });
  }

  QueryBuilder<ParentCategoryDetailsCacheModel, ParentCategoryDetailsCacheModel,
      QAfterSortBy> thenByJsonDataDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'jsonData', Sort.desc);
    });
  }

  QueryBuilder<ParentCategoryDetailsCacheModel, ParentCategoryDetailsCacheModel,
      QAfterSortBy> thenByLastUpdated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdated', Sort.asc);
    });
  }

  QueryBuilder<ParentCategoryDetailsCacheModel, ParentCategoryDetailsCacheModel,
      QAfterSortBy> thenByLastUpdatedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdated', Sort.desc);
    });
  }

  QueryBuilder<ParentCategoryDetailsCacheModel, ParentCategoryDetailsCacheModel,
      QAfterSortBy> thenByParentCategoryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentCategoryId', Sort.asc);
    });
  }

  QueryBuilder<ParentCategoryDetailsCacheModel, ParentCategoryDetailsCacheModel,
      QAfterSortBy> thenByParentCategoryIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentCategoryId', Sort.desc);
    });
  }
}

extension ParentCategoryDetailsCacheModelQueryWhereDistinct on QueryBuilder<
    ParentCategoryDetailsCacheModel,
    ParentCategoryDetailsCacheModel,
    QDistinct> {
  QueryBuilder<ParentCategoryDetailsCacheModel, ParentCategoryDetailsCacheModel,
      QDistinct> distinctByJsonData({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'jsonData', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ParentCategoryDetailsCacheModel, ParentCategoryDetailsCacheModel,
      QDistinct> distinctByLastUpdated() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastUpdated');
    });
  }

  QueryBuilder<ParentCategoryDetailsCacheModel, ParentCategoryDetailsCacheModel,
      QDistinct> distinctByParentCategoryId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'parentCategoryId',
          caseSensitive: caseSensitive);
    });
  }
}

extension ParentCategoryDetailsCacheModelQueryProperty on QueryBuilder<
    ParentCategoryDetailsCacheModel,
    ParentCategoryDetailsCacheModel,
    QQueryProperty> {
  QueryBuilder<ParentCategoryDetailsCacheModel, int, QQueryOperations>
      idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ParentCategoryDetailsCacheModel, String, QQueryOperations>
      jsonDataProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'jsonData');
    });
  }

  QueryBuilder<ParentCategoryDetailsCacheModel, DateTime, QQueryOperations>
      lastUpdatedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastUpdated');
    });
  }

  QueryBuilder<ParentCategoryDetailsCacheModel, String, QQueryOperations>
      parentCategoryIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'parentCategoryId');
    });
  }
}
