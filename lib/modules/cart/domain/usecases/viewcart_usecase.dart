// Path: lib/features/viewcart/domain/usecases/viewcart_usecase.dart
import '../entities/viewcart_entity.dart';
import '../repositories/viewcart_repository.dart';

class ViewCartUseCase {
  final ViewCartRepository repository;

  ViewCartUseCase(this.repository);

  Future<ViewCartEntity?> getCachedViewCart(String userId) {
    return repository.getCachedViewCart(userId);
  }

  Future<ViewCartEntity> fetchViewCart(String userId) {
    return repository.fetchViewCartFromApi(userId);
  }
}
