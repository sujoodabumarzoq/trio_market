part of 'signup_cubit.dart';

@immutable
abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpSuccess extends SignUpState {
  final SignUpResponse response;
  SignUpSuccess(this.response);
}

class SignUpFailure extends SignUpState {
  final String error;
  SignUpFailure(this.error);
}