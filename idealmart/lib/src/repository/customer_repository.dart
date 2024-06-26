import 'package:idealmart/src/data/customer.dart';

import '../services/customer_service.dart';

class CustomerRepository {
  final CustomerService customerService;

  CustomerRepository({required this.customerService});

  Future<Customer?> verifyCustomer(String email, String password) {
    return customerService.verifyCustomer(email, password);
  }

  Future<bool> addCustomer(Customer customer) {
    return customerService.addCustomer(customer);
  }
}
