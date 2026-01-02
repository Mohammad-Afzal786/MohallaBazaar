import 'package:dartz/dartz.dart';
import 'package:mohalla_bazaar/core/errors/failures.dart';
import '../entities/order_entity.dart';
import '../repositories/order_repository.dart';


class PlaceOrderUseCase {
  final OrderRepository repository;

  PlaceOrderUseCase(this.repository);

  Future<Either<Failure, OrderEntity>> call(String userId,String useraddress) {
    return repository.placeOrder(userId,useraddress);
  }
}
