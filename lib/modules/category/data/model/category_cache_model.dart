import 'package:isar/isar.dart';

part 'category_cache_model.g.dart';

@Collection()
class CategoryCacheModel {
  Id id = Isar.autoIncrement;

  late String parentName;
  late String parentId;
  late String parentImage;
 late String parentSubtitle;

  late String categoryId;
  late String categoryName;
  late String image;
 late String subtitle;
}
