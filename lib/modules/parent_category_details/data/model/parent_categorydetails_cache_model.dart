// Path: lib/features/categories/data/models/parent_categorydetails_cache_model.dart

import 'package:isar/isar.dart';

part 'parent_categorydetails_cache_model.g.dart';

@Collection()
class ParentCategoryDetailsCacheModel {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  String parentCategoryId = "";

  /// पूरा response JSON string के रूप में store किया गया है
  String jsonData = "";

  DateTime lastUpdated = DateTime.now();
}
