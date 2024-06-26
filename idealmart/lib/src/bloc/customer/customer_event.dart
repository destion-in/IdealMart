import 'package:equatable/equatable.dart';
import 'package:idealmart/src/data/customer.dart';

abstract class CustomerEvent extends Equatable {
  const CustomerEvent();

  @override
  List<Object> get props => [];
}

class VerifyCustomer extends CustomerEvent {
  final String email;
  final String password;

  const VerifyCustomer({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class AddCustomer extends CustomerEvent {
  final Customer customer;

  const AddCustomer({required this.customer});

  @override
  List<Object> get props => [customer];
}
