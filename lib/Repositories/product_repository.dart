import 'dart:convert';
import 'package:http/http.dart' as http; // إضافة الـ import لحل مشكلة http
import 'package:trio_market/model/product_model.dart';

class ProductRepository {
  Future<ProductResponse> getProductsByCategory(String categoryId) async {
    try {
      final response = await http.get(
        Uri.parse('https://student.valuxapps.com/api/products?category_id=$categoryId'),
        headers: {'Content-Type': 'application/json'},
      );
      print('Product API Response: ${response.body}');
      return ProductResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      print('Exception in ProductRepository: $e');
      throw Exception('Failed to fetch products: $e');
    }
  }

  Future<ProductDetailsResponse> getProductDetails(int productId) async {
    try {
      final response = await http.get(
        Uri.parse('https://student.valuxapps.com/api/products/$productId'),
        headers: {'Content-Type': 'application/json'},
      );
      print('Product Details Response: ${response.body}');
      return ProductDetailsResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw Exception('Failed to fetch product details: $e');
    }
  }

  Future<ProductResponse> searchProducts(String query) async {
    try {
      final response = await http.post(
        Uri.parse('https://student.valuxapps.com/api/products/search'),
        headers: {'Content-Type': 'application/json'}, // إضافة headers
        body: jsonEncode({'text': query}), // تحويل البيانات لـ JSON
      );
      print('Search API Response: ${response.body}');
      return ProductResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      print('Exception in Search: $e');
      throw Exception('Failed to search products: $e');
    }
  }
}