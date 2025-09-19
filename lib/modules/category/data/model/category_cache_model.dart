// Path: lib/features/categories/data/models/category_cache_model.dart
import 'package:isar/isar.dart';

part 'category_cache_model.g.dart';

@Collection()
class CategoryCacheModel {
  Id id = Isar.autoIncrement;

  late String parentName;
  late String categoryId;
  late String categoryName;
  late String image;
}
