import 'package:trio_market/model/product_model.dart';

class Favorite {
  final int id;
  final Product product;

  Favorite({required this.id, required this.product});

  factory Favorite.fromJson(Map<String, dynamic> json) {
    return Favorite(
      id: json['id'],
      product: Product.fromJson(json['product']),
    );
  }
}

class FavoritesResponse {
  final bool status;
  final String message;
  final List<Favorite> favorites;

  FavoritesResponse({required this.status, required this.message, required this.favorites});

  factory FavoritesResponse.fromJson(Map<String, dynamic> json) {
    var favList = json['data']['data'] as List;
    return FavoritesResponse(
      status: json['status'],
      message: json['message'],
      favorites: favList.map((i) => Favorite.fromJson(i)).toList(),
    );
  }
}