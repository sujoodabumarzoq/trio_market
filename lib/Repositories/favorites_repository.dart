import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:trio_market/model/favorites_model.dart';

class FavoritesRepository {
  Future<FavoritesResponse> getFavorites(String token) async {
    try {
      final response = await http.get(
        Uri.parse('https://student.valuxapps.com/api/favorites'),
        headers: {'Authorization': 'Bearer $token'},
      );
      return FavoritesResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw Exception('Failed to fetch favorites: $e');
    }
  }

  Future<void> addFavorite(String token, int productId) async {
    await http.post(
      Uri.parse('https://student.valuxapps.com/api/favorites'),
      headers: {'Authorization': 'Bearer $token'},
      body: {'product_id': productId.toString()},
    );
  }
}