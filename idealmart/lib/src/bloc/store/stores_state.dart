// Store States
import 'package:idealmart/src/model/store_model.dart';

abstract class StoreState {}

class StoreInitial extends StoreState {}

class StoreLoading extends StoreState {}

class StoreLoaded extends StoreState {
  final List<Store> stores;

  StoreLoaded(this.stores);
}

class StoreError extends StoreState {
  final String message;

  StoreError(this.message);
}
