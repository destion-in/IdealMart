import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:idealmart/src/data/store.dart';

class StoreService {
  final String baseUrl = 'https://idealmart.onrender.com/api/v1/idm';

  Future<List<Store>> getAllStores() async {
    final response = await _getRequest(endpoint: '/store');

    if (response != null && response.statusCode == 200) {
      Iterable jsonResponse = json.decode(response.body);
      return jsonResponse.map((store) => Store.fromJson(store)).toList();
    }
    throw Exception('Failed to load stores');
  }

  Future<Store?> getStoreById(String storeId) async {
    final response = await _getRequest(endpoint: '/store/$storeId');

    if (response != null && response.statusCode == 200) {
      return Store.fromJson(json.decode(response.body));
    }
    return null;
  }

  Future<bool> addStore(Store store) async {
    final response = await _postRequest(
      endpoint: '/store',
      body: store.toJson(),
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

  Future<http.Response?> _getRequest({required String endpoint}) async {
    try {
      final response = await http
          .get(
            Uri.parse('$baseUrl$endpoint'),
          )
          .timeout(const Duration(seconds: 10));

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
