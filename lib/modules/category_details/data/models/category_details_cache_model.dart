import 'package:isar/isar.dart';

part 'category_details_cache_model.g.dart';

@Collection()
class CategoryDetailsCacheModel {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  String categoryId = "";

  /// पूरा response JSON string के रूप में store किया जाएगा
  String jsonData = "";

  DateTime lastUpdated = DateTime.now();
}
