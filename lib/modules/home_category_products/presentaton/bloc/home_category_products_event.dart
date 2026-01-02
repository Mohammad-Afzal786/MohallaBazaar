import 'package:equatable/equatable.dart';

abstract class HomeCategoryProductsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeCategoryProductsRequested extends HomeCategoryProductsEvent {}
