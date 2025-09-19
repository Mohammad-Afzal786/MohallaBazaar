// Path: lib/features/categories/presentation/bloc/categories_state.dart
import 'package:equatable/equatable.dart';
import '../../domain/entities/category_entity.dart';

enum CategoriesStatus { initial, loading, success, failure }

class CategoriesState extends Equatable {
  final CategoriesStatus status;
  final List<ParentCategoryEntity> categories;
  final String? error;

  const CategoriesState({required this.status, required this.categories, this.error});

  factory CategoriesState.initial() => CategoriesState(status: CategoriesStatus.initial, categories: []);

  CategoriesState copyWith({
    CategoriesStatus? status,
    List<ParentCategoryEntity>? categories,
    String? error,
  }) {
    return CategoriesState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, categories, error];
}
