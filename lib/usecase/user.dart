import 'dart:convert';
import 'package:bloc_sample_clean/core/product_usecase_abstract.dart';
import 'package:bloc_sample_clean/domain/product.dart';
import 'package:http/http.dart' as http;

// Import your Product model file here
// import 'product_model.dart';


class ProductUseCase implements ProductUseCaseAbstract {
  final String baseUrl = 'https://dummyjson.com';

  @override
  Future<Product?> fetchProduct() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/products/1'));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return Product.fromJson(jsonData);
      } else {
        throw Exception('Failed to load product: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching product: $e');
      return null;
    }
  }
}
