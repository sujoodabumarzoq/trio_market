class ResetPasswordResponse {
  bool status;
  String message;
  dynamic data;

  ResetPasswordResponse({required this.status, required this.message, this.data});

  factory ResetPasswordResponse.fromJson(Map<String, dynamic> json) {
    return ResetPasswordResponse(
      status: json['status'],
      message: json['message'],
      data: json['data'],
    );
  }
}