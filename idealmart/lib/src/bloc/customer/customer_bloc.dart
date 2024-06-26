import 'package:idealmart/src/bloc/customer/customer_event.dart';
import 'package:idealmart/src/bloc/customer/customer_state.dart';
import 'package:idealmart/src/repository/customer_repository.dart';
import 'package:bloc/bloc.dart';

class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  final CustomerRepository customerRepository;

  CustomerBloc({required this.customerRepository}) : super(CustomerInitial());

  @override
  Stream<CustomerState> mapEventToState(CustomerEvent event) async* {
    if (event is VerifyCustomer) {
      yield CustomerLoading();
      try {
        final customer = await customerRepository.verifyCustomer(
            event.email, event.password);
        if (customer != null) {
          yield CustomerLoaded(customer);
        } else {
          yield CustomerError("Customer not found");
        }
      } catch (e) {
        yield CustomerError("Failed to fetch customer");
      }
    }

    if (event is AddCustomer) {
      yield CustomerLoading();
      try {
        final success = await customerRepository.addCustomer(event.customer);
        if (success) {
          yield CustomerAdded();
        } else {
          yield CustomerError("Failed to add customer");
        }
      } catch (e) {
        yield CustomerError("Failed to add customer");
      }
    }
  }
}
