class SignUpResponse {
  bool status;
  String message;
  dynamic data;

  SignUpResponse({required this.status, required this.message, this.data});

  factory SignUpResponse.fromJson(Map<String, dynamic> json) {
    return SignUpResponse(
      status: json['status'],
      message: json['message'],
      data: json['data'],
    );
  }
}