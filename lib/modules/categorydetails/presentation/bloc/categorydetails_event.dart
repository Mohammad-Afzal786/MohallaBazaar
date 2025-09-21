// Path: lib/features/categories/presentation/bloc/categorydetails_event.dart
import 'package:equatable/equatable.dart';

abstract class CategoryDetailsEvent extends Equatable {
  const CategoryDetailsEvent();

  @override
  List<Object?> get props => [];
}

class CategoryDetailsRequested extends CategoryDetailsEvent {
  final String categoryId;

  const CategoryDetailsRequested(this.categoryId);

  @override
  List<Object?> get props => [categoryId];
}
