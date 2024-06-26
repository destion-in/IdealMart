import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchProducts extends ProductEvent {}

class FetchProductsByCategory extends ProductEvent {
  final String category;

  FetchProductsByCategory({required this.category});

  @override
  List<Object> get props => [category];
}
