import 'package:dartz/dartz.dart';
import 'package:mohalla_bazaar/core/errors/failures.dart';
import '../entities/order_entity.dart';

abstract class OrderRepository {
  Future<Either<Failure, OrderEntity>> placeOrder(String userId,String useraddress);
}
