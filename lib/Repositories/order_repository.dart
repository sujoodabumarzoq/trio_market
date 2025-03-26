import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:trio_market/model/order_model.dart';

class OrderRepository {
  Future<OrderTrackingResponse> trackOrder(String token, int orderId) async {
    try {
      final response = await http.get(
        Uri.parse('https://student.valuxapps.com/api/orders/$orderId'), // افتراضي
        headers: {'Authorization': 'Bearer $token'},
      );
      return OrderTrackingResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw Exception('Failed to track order: $e');
    }
  }
  Future<OrderHistoryResponse> getOrderHistory(String token) async {
    try {
      final response = await http.get(
        Uri.parse('https://student.valuxapps.com/api/orders'),
        headers: {'Authorization': 'Bearer $token'},
      );
      return OrderHistoryResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw Exception('Failed to fetch order history: $e');
    }
  }
}