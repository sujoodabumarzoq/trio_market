import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:trio_market/model/signup_model.dart';
import '../../Repositories/auth_repository.dart';

part 'signup_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepository authRepository;
  SignUpCubit(this.authRepository) : super(SignUpInitial());

  void signUp(String name, String email, String password, String phone, String role) async {
    print('SignUp Data: name=$name, email=$email, password=$password, phone=$phone, role=$role');
    emit(SignUpLoading());
    try {
      final response = await authRepository.signUp(name, email, password, phone, role);
      if (response.status) {
        emit(SignUpSuccess(response));
      } else {
        print('API Error: ${response.message}');
        emit(SignUpFailure(response.message));
      }
    } catch (e) {
      print('Exception: $e');
      emit(SignUpFailure('خطأ في الاتصال بالسيرفر: $e'));
    }
  }
}