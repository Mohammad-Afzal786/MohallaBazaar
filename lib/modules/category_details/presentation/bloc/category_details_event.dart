import 'package:equatable/equatable.dart';

/// 🔹 Events for CategoryDetails Bloc
abstract class CategoryDetailsEvent extends Equatable {
  const CategoryDetailsEvent();

  @override
  List<Object?> get props => [];
}

/// 🔹 Triggered to fetch products for a category
class CategoryProductsRequested extends CategoryDetailsEvent {
  final String categoryId;

  const CategoryProductsRequested(this.categoryId);

  @override
  List<Object?> get props => [categoryId];
}
