import 'package:mohalla_bazaar/modules/parent_category/data/models/parent_category_model.dart';


import '../../../../core/network/api_client.dart';

abstract class ParentCategoryRemoteDataSource {
  Future<List<ParentCategoryModel>> fetchCategories();
}

class ParentCategoryRemoteDataSourceImpl implements ParentCategoryRemoteDataSource {
  final ApiClient apiClient;

  ParentCategoryRemoteDataSourceImpl(this.apiClient);

  @override
  Future<List<ParentCategoryModel>> fetchCategories() async {
    final response = await apiClient.getParentCategories();
    return response.data; // extract List from wrapper
  }
}
