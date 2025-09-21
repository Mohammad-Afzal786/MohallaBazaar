// Path: lib/features/categories/data/models/categorydetails_cache_model.dart
import 'package:isar/isar.dart';

part 'categorydetails_cache_model.g.dart';

@Collection()
class CategoryDetailsCache {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String categoryId;

  late String json;

  late DateTime updatedAt;
}
