import 'package:trio_market/model/product_model.dart';

class CartItem {
  final int id;
  final Product product;
  final int quantity;

  CartItem({required this.id, required this.product, required this.quantity});

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      product: Product.fromJson(json['product']),
      quantity: json['quantity'],
    );
  }
}

class CartResponse {
  final bool status;
  final String message;
  final List<CartItem> cartItems;

  CartResponse({required this.status, required this.message, required this.cartItems});

  factory CartResponse.fromJson(Map<String, dynamic> json) {
    var cartList = json['data']['cart_items'] as List;
    return CartResponse(
      status: json['status'],
      message: json['message'],
      cartItems: cartList.map((i) => CartItem.fromJson(i)).toList(),
    );
  }
}