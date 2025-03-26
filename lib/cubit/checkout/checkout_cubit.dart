import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:trio_market/model/checkout_model.dart';
import 'package:trio_market/Repositories/checkout_repository.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  final CheckoutRepository checkoutRepository;
  final String token;

  CheckoutCubit(this.checkoutRepository, this.token) : super(CheckoutInitial());

  void performCheckout(int productId) async {
    emit(CheckoutLoading());
    try {
      final response = await checkoutRepository.checkout(token, productId);
      if (response.status) {
        emit(CheckoutSuccess());
      } else {
        emit(CheckoutError(response.message));
      }
    } catch (e) {
      emit(CheckoutError('خطأ في إتمام الطلب: $e'));
    }
  }
}