import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trio_market/Repositories/auth_repository.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository authRepository;
  LoginCubit(this.authRepository) : super(LoginInitial());

  void login(String email, String password) async {
    emit(LoginLoading());
    try {
      final response = await authRepository.login(email, password);
      if (response.status) {
        emit(LoginSuccess(response));
      } else {
        emit(LoginFailure(response.message));
      }
    } catch (e) {
      emit(LoginFailure('حدث خطأ أثناء تسجيل الدخول'));
    }
  }
}