import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:idealmart/src/model/productmodel.dart';

class ProductService {
  final String baseUrl = 'https://idealmart.onrender.com/api/v1/idm';

  Future<List<Product>> getAllProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/product'));

    if (response.statusCode == 200) {
      Iterable jsonResponse = json.decode(response.body);
      return jsonResponse.map((product) => Product.fromJson(product)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
