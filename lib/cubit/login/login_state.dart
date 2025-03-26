
import 'package:trio_market/model/login_model.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}
class LoginLoading extends LoginState {}
class LoginSuccess extends LoginState {
  final LoginResponse response;
  LoginSuccess(this.response);
}
class LoginFailure extends LoginState {
  final String error;
  LoginFailure(this.error);
}