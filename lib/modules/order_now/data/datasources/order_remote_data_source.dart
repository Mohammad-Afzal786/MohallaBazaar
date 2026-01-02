import 'package:mohalla_bazaar/modules/order_now/data/model/order_model.dart';
import 'package:mohalla_bazaar/modules/order_now/data/model/order_request.dart';

import '../../../../core/network/api_client.dart';

abstract class OrderRemoteDataSource {
  Future<OrderModel> placeOrder(OrderRequest request);
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final ApiClient api;

  OrderRemoteDataSourceImpl(this.api);

  @override
  Future<OrderModel> placeOrder(OrderRequest request) async {
    return await api.placeOrder(request);
  }
}
