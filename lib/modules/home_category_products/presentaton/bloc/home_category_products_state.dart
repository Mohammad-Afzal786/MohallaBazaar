import 'package:equatable/equatable.dart';
import '../../domain/entities/home_category_products_entity.dart';

enum HomeCategoryProductsStatus { initial, loading, success, failure }

class HomeCategoryProductsState extends Equatable {
  final HomeCategoryProductsStatus status;
  final List<HomeCategoryProductsEntity> categories;
  final String? error;

  const HomeCategoryProductsState({
    required this.status,
    required this.categories,
    this.error,
  });

  factory HomeCategoryProductsState.initial() =>
      HomeCategoryProductsState(status: HomeCategoryProductsStatus.initial, categories: []);

  HomeCategoryProductsState copyWith({
    HomeCategoryProductsStatus? status,
    List<HomeCategoryProductsEntity>? categories,
    String? error,
  }) {
    return HomeCategoryProductsState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, categories, error];
}
