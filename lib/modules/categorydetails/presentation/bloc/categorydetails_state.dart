// Path: lib/features/categories/presentation/bloc/categorydetails_state.dart
import 'package:equatable/equatable.dart';
import 'package:mohalla_bazaar/modules/categorydetails/domain/entities/categorydetails_entity.dart';

enum CategoryDetailsStatus { initial, loading, success, failure }

class CategoryDetailsState extends Equatable {
  final CategoryDetailsStatus status;
  final CategoryDetailsEntity? details;
  final String? error;

  const CategoryDetailsState({required this.status, this.details, this.error});

  factory CategoryDetailsState.initial() => CategoryDetailsState(status: CategoryDetailsStatus.initial);

  CategoryDetailsState copyWith({
    CategoryDetailsStatus? status,
    CategoryDetailsEntity? details,
    String? error,
  }) {
    return CategoryDetailsState(
      status: status ?? this.status,
      details: details ?? this.details,
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, details, error];
}
