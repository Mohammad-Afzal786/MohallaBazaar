// Path: lib/features/categories/presentation/bloc/parent_categorydetails_event.dart
import 'package:equatable/equatable.dart';

abstract class ParentCategoryDetailsEvent extends Equatable {
  const ParentCategoryDetailsEvent();

  @override
  List<Object?> get props => [];
}

class ParentCategoryDetailsRequested extends ParentCategoryDetailsEvent {
  final String parentCategoryId;

  const ParentCategoryDetailsRequested(this.parentCategoryId);

  @override
  List<Object?> get props => [parentCategoryId];
}
