// Path: lib/features/categories/data/datasources/parent_categorydetails_remote_data_source.dart
// Path: lib/features/parent_categorydetails/data/datasources/parent_categorydetails_remote_data_source.dart
import 'package:mohalla_bazaar/modules/parent_category_details/data/model/parent_categorydetails_response.dart';

import '../../../../core/network/api_client.dart';


abstract class ParentCategoryDetailsRemoteDataSource {
  Future<ParentCategoryDetailsResponse> fetchParentCategoryDetails(String parentCategoryId);
}

class ParentCategoryDetailsRemoteDataSourceImpl implements ParentCategoryDetailsRemoteDataSource {
  final ApiClient apiClient;

  ParentCategoryDetailsRemoteDataSourceImpl(this.apiClient);

  @override
  Future<ParentCategoryDetailsResponse> fetchParentCategoryDetails(String parentCategoryId) async {
    final resp = await apiClient.getParentCategoryDetails(parentCategoryId);
    return resp;
  }
}
