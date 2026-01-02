import 'package:dartz/dartz.dart';
import 'package:mohalla_bazaar/core/errors/failures.dart';
import 'package:mohalla_bazaar/modules/order_now/data/model/order_request.dart';
import 'package:mohalla_bazaar/modules/order_now/domain/repositories/order_repository.dart';

import '../datasources/order_remote_data_source.dart';
import '../../domain/entities/order_entity.dart';


class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource remote;

  OrderRepositoryImpl(this.remote);

  @override
  Future<Either<Failure, OrderEntity>> placeOrder(String userId,String useraddress) async {
    try {
      final remoteOrder = await remote.placeOrder(OrderRequest(userId: userId,useraddress:useraddress));

      print("Remote response: $remoteOrder");

      try {
        final orderEntity = remoteOrder.toEntity();
        return Right(orderEntity);
      } catch (e) {
        return Left(ServerFailure("Failed to parse order response: ${e.toString()}"));
      }

    } catch (e, s) {
      print("Repository exception: $e \n$s");
      return Left(ServerFailure("Repository exception: ${e.toString()}"));
    }
  }
}
