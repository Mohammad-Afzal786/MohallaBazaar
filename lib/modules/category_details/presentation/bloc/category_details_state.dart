import 'package:equatable/equatable.dart';
import '../../domain/entities/category_details_entity.dart';

enum CategoryDetailsStatus { initial, loading, success, failure }

class CategoryDetailsState extends Equatable {
  final CategoryDetailsStatus status;
  final List<ProductEntity> products;
  final String? error;

  const CategoryDetailsState({
    required this.status,
    required this.products,
    this.error,
  });

  factory CategoryDetailsState.initial() => CategoryDetailsState(
        status: CategoryDetailsStatus.initial,
        products: [],
      );

  CategoryDetailsState copyWith({
    CategoryDetailsStatus? status,
    List<ProductEntity>? products,
    String? error,
  }) {
    return CategoryDetailsState(
      status: status ?? this.status,
      products: products ?? this.products,
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, products, error];
}
