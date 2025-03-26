import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:trio_market/model/cart_model.dart';

class CartRepository {
  Future<CartResponse> getCart(String token) async {
    try {
      final response = await http.get(
        Uri.parse('https://student.valuxapps.com/api/carts'),
        headers: {'Authorization': 'Bearer $token'},
      );
      return CartResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw Exception('Failed to fetch cart: $e');
    }
  }

  Future<void> addToCart(String token, int productId) async {
    await http.post(
      Uri.parse('https://student.valuxapps.com/api/carts'),
      headers: {'Authorization': 'Bearer $token'},
      body: {'product_id': productId.toString()},
    );
  }
}