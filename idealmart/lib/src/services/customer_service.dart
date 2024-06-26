import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:idealmart/src/data/customer.dart';

class CustomerService {
  final String baseUrl = 'https://idealmart.onrender.com/api/v1/idm';

  Future<Customer?> verifyCustomer(String email, String password) async {
    final response = await _postRequest(
      endpoint: '/customer/verify',
      body: {'email': email, 'password': password},
    );

    if (response != null && response.statusCode == 200) {
      return Customer.fromJson(json.decode(response.body));
    }
    return null;
  }

  Future<bool> addCustomer(Customer customer) async {
    final response = await _postRequest(
      endpoint: '/customer',
      body: customer.toJson(),
    );

    return response != null && response.statusCode == 200;
  }

  Future<http.Response?> _postRequest({
    required String endpoint,
    required Map<String, dynamic> body,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl$endpoint'),
        body: json.encode(body),
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 10));

      _logResponse(response);
      return response;
    } catch (error) {
      _handleError(error);
      return null;
    }
  }

  void _logResponse(http.Response response) {
    print(
        'Request to ${response.request!.url} responded with ${response.statusCode}');
  }

  void _handleError(dynamic error) {
    print('Request failed with error: $error');
  }
}
