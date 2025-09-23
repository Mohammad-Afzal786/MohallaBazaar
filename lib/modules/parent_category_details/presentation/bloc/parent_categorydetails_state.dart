// Path: lib/features/categories/presentation/bloc/parent_categorydetails_state.dart
import 'package:equatable/equatable.dart';
import 'package:mohalla_bazaar/modules/parent_category_details/domain/entities/parent_categorydetails_entity.dart';

enum ParentCategoryDetailsStatus { initial, loading, success, failure }

class ParentCategoryDetailsState extends Equatable {
  final ParentCategoryDetailsStatus status;
  final ParentCategoryDetailsEntity? details;
  final String? error;

  const ParentCategoryDetailsState({
    required this.status,
    this.details,
    this.error,
  });

  factory ParentCategoryDetailsState.initial() =>
      ParentCategoryDetailsState(status: ParentCategoryDetailsStatus.initial);

  ParentCategoryDetailsState copyWith({
    ParentCategoryDetailsStatus? status,
    ParentCategoryDetailsEntity? details,
    String? error,
  }) {
    return ParentCategoryDetailsState(
      status: status ?? this.status,
      details: details ?? this.details,
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, details, error];
}
