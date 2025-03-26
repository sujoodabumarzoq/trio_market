import 'dart:convert';

class Product {
  final int id;
  final String name;
  final String description;
  final double price;
  final String image;
  final bool inFavorites; // للمفضلة
  final bool inCart;     // للسلة

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.inFavorites,
    required this.inCart,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'] ?? '',
      price: (json['price'] as num).toDouble(),
      image: json['image'],
      inFavorites: json['in_favorites'] ?? false,
      inCart: json['in_cart'] ?? false,
    );
  }
}

class ProductDetailsResponse {
  final bool status;
  final String message;
  final Product product;

  ProductDetailsResponse({
    required this.status,
    required this.message,
    required this.product,
  });

  factory ProductDetailsResponse.fromJson(Map<String, dynamic> json) {
    return ProductDetailsResponse(
      status: json['status'],
      message: json['message'],
      product: Product.fromJson(json['data']),
    );
  }
}

class ProductResponse {
  final bool status;
  final String message;
  final List<Product> products;

  ProductResponse({
    required this.status,
    required this.message,
    required this.products,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    var productList = json['data']['data'] as List;
    List<Product> products = productList.map((i) => Product.fromJson(i)).toList();
    return ProductResponse(
      status: json['status'],
      message: json['message'],
      products: products,
    );
  }
}