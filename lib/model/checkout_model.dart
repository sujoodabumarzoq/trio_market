class CheckoutResponse {
  final bool status;
  final String message;

  CheckoutResponse({required this.status, required this.message});

  factory CheckoutResponse.fromJson(Map<String, dynamic> json) {
    return CheckoutResponse(
      status: json['status'],
      message: json['message'],
    );
  }
}