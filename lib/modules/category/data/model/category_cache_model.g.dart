// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_cache_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCategoryCacheModelCollection on Isar {
  IsarCollection<CategoryCacheModel> get categoryCacheModels =>
      this.collection();
}

const CategoryCacheModelSchema = CollectionSchema(
  name: r'CategoryCacheModel',
  id: -3387739556062636734,
  properties: {
    r'categoryId': PropertySchema(
      id: 0,
      name: r'categoryId',
      type: IsarType.string,
    ),
    r'categoryName': PropertySchema(
      id: 1,
      name: r'categoryName',
      type: IsarType.string,
    ),
    r'image': PropertySchema(
      id: 2,
      name: r'image',
      type: IsarType.string,
    ),
    r'parentId': PropertySchema(
      id: 3,
      name: r'parentId',
      type: IsarType.string,
    ),
    r'parentImage': PropertySchema(
      id: 4,
      name: r'parentImage',
      type: IsarType.string,
    ),
    r'parentName': PropertySchema(
      id: 5,
      name: r'parentName',
      type: IsarType.string,
    ),
    r'parentSubtitle': PropertySchema(
      id: 6,
      name: r'parentSubtitle',
      type: IsarType.string,
    ),
    r'subtitle': PropertySchema(
      id: 7,
      name: r'subtitle',
      type: IsarType.string,
    )
  },
  estimateSize: _categoryCacheModelEstimateSize,
  serialize: _categoryCacheModelSerialize,
  deserialize: _categoryCacheModelDeserialize,
  deserializeProp: _categoryCacheModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _categoryCacheModelGetId,
  getLinks: _categoryCacheModelGetLinks,
  attach: _categoryCacheModelAttach,
  version: '3.1.0+1',
);

int _categoryCacheModelEstimateSize(
  CategoryCacheModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.categoryId.length * 3;
  bytesCount += 3 + object.categoryName.length * 3;
  bytesCount += 3 + object.image.length * 3;
  bytesCount += 3 + object.parentId.length * 3;
  bytesCount += 3 + object.parentImage.length * 3;
  bytesCount += 3 + object.parentName.length * 3;
  bytesCount += 3 + object.parentSubtitle.length * 3;
  bytesCount += 3 + object.subtitle.length * 3;
  return bytesCount;
}

void _categoryCacheModelSerialize(
  CategoryCacheModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.categoryId);
  writer.writeString(offsets[1], object.categoryName);
  writer.writeString(offsets[2], object.image);
  writer.writeString(offsets[3], object.parentId);
  writer.writeString(offsets[4], object.parentImage);
  writer.writeString(offsets[5], object.parentName);
  writer.writeString(offsets[6], object.parentSubtitle);
  writer.writeString(offsets[7], object.subtitle);
}

CategoryCacheModel _categoryCacheModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CategoryCacheModel();
  object.categoryId = reader.readString(offsets[0]);
  object.categoryName = reader.readString(offsets[1]);
  object.id = id;
  object.image = reader.readString(offsets[2]);
  object.parentId = reader.readString(offsets[3]);
  object.parentImage = reader.readString(offsets[4]);
  object.parentName = reader.readString(offsets[5]);
  object.parentSubtitle = reader.readString(offsets[6]);
  object.subtitle = reader.readString(offsets[7]);
  return object;
}

P _categoryCacheModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _categoryCacheModelGetId(CategoryCacheModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _categoryCacheModelGetLinks(
    CategoryCacheModel object) {
  return [];
}

void _categoryCacheModelAttach(
    IsarCollection<dynamic> col, Id id, CategoryCacheModel object) {
  object.id = id;
}

extension CategoryCacheModelQueryWhereSort
    on QueryBuilder<CategoryCacheModel, CategoryCacheModel, QWhere> {
  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CategoryCacheModelQueryWhere
    on QueryBuilder<CategoryCacheModel, CategoryCacheModel, QWhereClause> {
  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterWhereClause>
      idNotEqualTo(Id id) {
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

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterWhereClause>
      idBetween(
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

extension CategoryCacheModelQueryFilter
    on QueryBuilder<CategoryCacheModel, CategoryCacheModel, QFilterCondition> {
  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterFilterCondition>
      categoryIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'categoryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterFilterCondition>
      categoryIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'categoryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterFilterCondition>
      categoryIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'categoryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterFilterCondition>
      categoryIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'categoryId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterFilterCondition>
      categoryIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'categoryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterFilterCondition>
      categoryIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'categoryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterFilterCondition>
      categoryIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'categoryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterFilterCondition>
      categoryIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'categoryId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterFilterCondition>
      categoryIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'categoryId',
        value: '',
      ));
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterFilterCondition>
      categoryIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'categoryId',
        value: '',
      ));
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterFilterCondition>
      categoryNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'categoryName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterFilterCondition>
      categoryNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'categoryName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterFilterCondition>
      categoryNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'categoryName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterFilterCondition>
      categoryNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'categoryName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterFilterCondition>
      categoryNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'categoryName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterFilterCondition>
      categoryNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'categoryName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterFilterCondition>
      categoryNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'categoryName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterFilterCondition>
      categoryNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'categoryName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterFilterCondition>
      categoryNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'categoryName',
        value: '',
      ));
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterFilterCondition>
      categoryNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'categoryName',
        value: '',
      ));
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterFilterCondition>
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

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterFilterCondition>
      idLessThan(
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

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterFilterCondition>
      idBetween(
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

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterFilterCondition>
      imageEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'image',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterFilterCondition>
      imageGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'image',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterFilterCondition>
      imageLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'image',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterFilterCondition>
      imageBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'image',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterFilterCondition>
      imageStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'image',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterFilterCondition>
      imageEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'image',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterFilterCondition>
      imageContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'image',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterFilterCondition>
      imageMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'image',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterFilterCondition>
      imageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'image',
        value: '',
      ));
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterFilterCondition>
      imageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'image',
        value: '',
      ));
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterFilterCondition>
      parentIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'parentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterFilterCondition>
      parentIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'parentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterFilterCondition>
      parentIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'parentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterFilterCondition>
      parentIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'parentId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterFilterCondition>
      parentIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'parentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterFilterCondition>
      parentIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'parentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterFilterCondition>
      parentIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'parentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterFilterCondition>
      parentIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'parentId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterFilterCondition>
      parentIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'parentId',
        value: '',
      ));
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterFilterCondition>
      parentIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'parentId',
        value: '',
      ));
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterFilterCondition>
      parentImageEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'parentImage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterFilterCondition>
      parentImageGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'parentImage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterFilterCondition>
      parentImageLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'parentImage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterFilterCondition>
      parentImageBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'parentImage',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterFilterCondition>
      parentImageStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'parentImage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterFilterCondition>
      parentImageEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'parentImage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterFilterCondition>
      parentImageContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'parentImage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterFilterCondition>
      parentImageMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'parentImage',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterFilterCondition>
      parentImageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'parentImage',
        value: '',
      ));
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterFilterCondition>
      parentImageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'parentImage',
        value: '',
      ));
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterFilterCondition>
      parentNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'parentName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterFilterCondition>
      parentNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'parentName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterFilterCondition>
      parentNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'parentName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterFilterCondition>
      parentNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'parentName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterFilterCondition>
      parentNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'parentName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterFilterCondition>
      parentNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'parentName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterFilterCondition>
      parentNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'parentName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterFilterCondition>
      parentNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'parentName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterFilterCondition>
      parentNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'parentName',
        value: '',
      ));
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterFilterCondition>
      parentNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'parentName',
        value: '',
      ));
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterFilterCondition>
      parentSubtitleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'parentSubtitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterFilterCondition>
      parentSubtitleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'parentSubtitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterFilterCondition>
      parentSubtitleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'parentSubtitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterFilterCondition>
      parentSubtitleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'parentSubtitle',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterFilterCondition>
      parentSubtitleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'parentSubtitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterFilterCondition>
      parentSubtitleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'parentSubtitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterFilterCondition>
      parentSubtitleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'parentSubtitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterFilterCondition>
      parentSubtitleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'parentSubtitle',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterFilterCondition>
      parentSubtitleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'parentSubtitle',
        value: '',
      ));
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterFilterCondition>
      parentSubtitleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'parentSubtitle',
        value: '',
      ));
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterFilterCondition>
      subtitleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'subtitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterFilterCondition>
      subtitleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'subtitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterFilterCondition>
      subtitleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'subtitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterFilterCondition>
      subtitleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'subtitle',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterFilterCondition>
      subtitleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'subtitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterFilterCondition>
      subtitleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'subtitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterFilterCondition>
      subtitleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'subtitle',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterFilterCondition>
      subtitleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'subtitle',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterFilterCondition>
      subtitleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'subtitle',
        value: '',
      ));
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterFilterCondition>
      subtitleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'subtitle',
        value: '',
      ));
    });
  }
}

extension CategoryCacheModelQueryObject
    on QueryBuilder<CategoryCacheModel, CategoryCacheModel, QFilterCondition> {}

extension CategoryCacheModelQueryLinks
    on QueryBuilder<CategoryCacheModel, CategoryCacheModel, QFilterCondition> {}

extension CategoryCacheModelQuerySortBy
    on QueryBuilder<CategoryCacheModel, CategoryCacheModel, QSortBy> {
  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterSortBy>
      sortByCategoryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryId', Sort.asc);
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterSortBy>
      sortByCategoryIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryId', Sort.desc);
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterSortBy>
      sortByCategoryName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryName', Sort.asc);
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterSortBy>
      sortByCategoryNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryName', Sort.desc);
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterSortBy>
      sortByImage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'image', Sort.asc);
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterSortBy>
      sortByImageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'image', Sort.desc);
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterSortBy>
      sortByParentId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentId', Sort.asc);
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterSortBy>
      sortByParentIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentId', Sort.desc);
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterSortBy>
      sortByParentImage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentImage', Sort.asc);
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterSortBy>
      sortByParentImageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentImage', Sort.desc);
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterSortBy>
      sortByParentName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentName', Sort.asc);
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterSortBy>
      sortByParentNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentName', Sort.desc);
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterSortBy>
      sortByParentSubtitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentSubtitle', Sort.asc);
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterSortBy>
      sortByParentSubtitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentSubtitle', Sort.desc);
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterSortBy>
      sortBySubtitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subtitle', Sort.asc);
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterSortBy>
      sortBySubtitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subtitle', Sort.desc);
    });
  }
}

extension CategoryCacheModelQuerySortThenBy
    on QueryBuilder<CategoryCacheModel, CategoryCacheModel, QSortThenBy> {
  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterSortBy>
      thenByCategoryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryId', Sort.asc);
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterSortBy>
      thenByCategoryIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryId', Sort.desc);
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterSortBy>
      thenByCategoryName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryName', Sort.asc);
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterSortBy>
      thenByCategoryNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryName', Sort.desc);
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterSortBy>
      thenByImage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'image', Sort.asc);
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterSortBy>
      thenByImageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'image', Sort.desc);
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterSortBy>
      thenByParentId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentId', Sort.asc);
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterSortBy>
      thenByParentIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentId', Sort.desc);
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterSortBy>
      thenByParentImage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentImage', Sort.asc);
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterSortBy>
      thenByParentImageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentImage', Sort.desc);
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterSortBy>
      thenByParentName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentName', Sort.asc);
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterSortBy>
      thenByParentNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentName', Sort.desc);
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterSortBy>
      thenByParentSubtitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentSubtitle', Sort.asc);
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterSortBy>
      thenByParentSubtitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'parentSubtitle', Sort.desc);
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterSortBy>
      thenBySubtitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subtitle', Sort.asc);
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QAfterSortBy>
      thenBySubtitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subtitle', Sort.desc);
    });
  }
}

extension CategoryCacheModelQueryWhereDistinct
    on QueryBuilder<CategoryCacheModel, CategoryCacheModel, QDistinct> {
  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QDistinct>
      distinctByCategoryId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'categoryId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QDistinct>
      distinctByCategoryName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'categoryName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QDistinct>
      distinctByImage({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'image', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QDistinct>
      distinctByParentId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'parentId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QDistinct>
      distinctByParentImage({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'parentImage', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QDistinct>
      distinctByParentName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'parentName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QDistinct>
      distinctByParentSubtitle({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'parentSubtitle',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CategoryCacheModel, CategoryCacheModel, QDistinct>
      distinctBySubtitle({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'subtitle', caseSensitive: caseSensitive);
    });
  }
}

extension CategoryCacheModelQueryProperty
    on QueryBuilder<CategoryCacheModel, CategoryCacheModel, QQueryProperty> {
  QueryBuilder<CategoryCacheModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CategoryCacheModel, String, QQueryOperations>
      categoryIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'categoryId');
    });
  }

  QueryBuilder<CategoryCacheModel, String, QQueryOperations>
      categoryNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'categoryName');
    });
  }

  QueryBuilder<CategoryCacheModel, String, QQueryOperations> imageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'image');
    });
  }

  QueryBuilder<CategoryCacheModel, String, QQueryOperations>
      parentIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'parentId');
    });
  }

  QueryBuilder<CategoryCacheModel, String, QQueryOperations>
      parentImageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'parentImage');
    });
  }

  QueryBuilder<CategoryCacheModel, String, QQueryOperations>
      parentNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'parentName');
    });
  }

  QueryBuilder<CategoryCacheModel, String, QQueryOperations>
      parentSubtitleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'parentSubtitle');
    });
  }

  QueryBuilder<CategoryCacheModel, String, QQueryOperations>
      subtitleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'subtitle');
    });
  }
}
