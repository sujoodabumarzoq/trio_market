import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:trio_market/Repositories/auth_repository.dart';


part 'reset_password_state.dart';


class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final AuthRepository authRepository;
  ResetPasswordCubit(this.authRepository) : super(ResetPasswordInitial());

  void sendResetEmail(String email) async {
    emit(ResetPasswordLoading());
    // Assume sending email is handled by backend
    emit(ResetPasswordEmailSent());
  }

  void verifyCode(String email, String code) async {
    emit(ResetPasswordLoading());
    try {
      final response = await authRepository.verifyCode(email, code);
      if (response.status) {
        emit(ResetPasswordCodeVerified());
      } else {
        emit(ResetPasswordFailure(response.message));
      }
    } catch (e) {
      emit(ResetPasswordFailure('خطأ في التحقق من الكود'));
    }
  }

  void resetPassword(String email, String code, String newPassword) async {
    emit(ResetPasswordLoading());
    try {
      final response = await authRepository.resetPassword(email, code, newPassword);
      if (response.status) {
        emit(ResetPasswordSuccess());
      } else {
        emit(ResetPasswordFailure(response.message));
      }
    } catch (e) {
      emit(ResetPasswordFailure('خطأ في إعادة تعيين كلمة المرور'));
    }
  }
}