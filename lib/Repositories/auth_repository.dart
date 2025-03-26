import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart' as http_io;
import 'dart:convert';
import 'package:trio_market/model/login_model.dart';
import 'package:trio_market/model/resetPassword_model.dart';
import 'package:trio_market/model/signup_model.dart';

class AuthRepository {
  Future<SignUpResponse> signUp(String name, String email, String password, String phone, String role) async {
    final httpClient = HttpClient()
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    final client = http_io.IOClient(httpClient);

    try {
      final requestBody = {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
        'role': role,
      };
      print('Sending Request Body: $requestBody'); // للتحقق من البيانات قبل الإرسال
      final response = await client.post(
        Uri.parse('https://student.valuxapps.com/api/register'),
        headers: {'Content-Type': 'application/json'}, // صيغة JSON
        body: jsonEncode(requestBody), // تحويل البيانات لـ JSON
      );
      print('API Response: ${response.body}'); // الرد من الـ API
      return SignUpResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      print('Exception in AuthRepository: $e');
      rethrow;
    } finally {
      client.close();
    }
  }

  Future<LoginResponse> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('https://student.valuxapps.com/api/login'),
      body: {'email': email, 'password': password},
    );
    return LoginResponse.fromJson(jsonDecode(response.body));
  }

  Future<ResetPasswordResponse> resetPassword(String email, String code, String password) async {
    final response = await http.post(
      Uri.parse('https://student.valuxapps.com/api/reset-password'),
      body: {'email': email, 'code': code, 'password': password},
    );
    return ResetPasswordResponse.fromJson(jsonDecode(response.body));
  }

  Future<ResetPasswordResponse> verifyCode(String email, String code) async {
    final response = await http.post(
      Uri.parse('https://student.valuxapps.com/api/verify-code'),
      body: {'email': email, 'code': code},
    );
    return ResetPasswordResponse.fromJson(jsonDecode(response.body));
  }
}