class Order {
  final int id;
  final String status;
  final double total;

  Order({required this.id, required this.status, required this.total});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      status: json['status'],
      total: (json['total'] as num).toDouble(),
    );
  }
}

class OrderTrackingResponse {
  final bool status;
  final String message;
  final Order order;

  OrderTrackingResponse({required this.status, required this.message, required this.order});

  factory OrderTrackingResponse.fromJson(Map<String, dynamic> json) {
    return OrderTrackingResponse(
      status: json['status'],
      message: json['message'],
      order: Order.fromJson(json['data']),
    );
  }
}
class OrderHistoryResponse {
  final bool status;
  final String message;
  final List<Order> orders;

  OrderHistoryResponse({required this.status, required this.message, required this.orders});

  factory OrderHistoryResponse.fromJson(Map<String, dynamic> json) {
    var orderList = json['data'] as List;
    return OrderHistoryResponse(
      status: json['status'],
      message: json['message'],
      orders: orderList.map((i) => Order.fromJson(i)).toList(),
    );
  }
}