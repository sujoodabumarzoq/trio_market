class LoginResponse {
  bool status;
  String message;
  dynamic data;

  LoginResponse({required this.status, required this.message, this.data});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: json['status'],
      message: json['message'],
      data: json['data'],
    );
  }
}