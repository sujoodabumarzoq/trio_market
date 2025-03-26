import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:trio_market/model/checkout_model.dart';

class CheckoutRepository {
  Future<CheckoutResponse> checkout(String token, int productId) async {
    try {
      final response = await http.post(
        Uri.parse('https://student.valuxapps.com/api/carts'), // افتراضي، لو في API منفصل، عدله
        headers: {'Authorization': 'Bearer $token'},
        body: jsonEncode({'product_id': productId}),
      );
      return CheckoutResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw Exception('Failed to checkout: $e');
    }
  }
}