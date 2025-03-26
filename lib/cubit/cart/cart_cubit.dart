import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:trio_market/model/cart_model.dart';
import 'package:trio_market/Repositories/cart_repository.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepository cartRepository;
  final String token;

  CartCubit(this.cartRepository, this.token) : super(CartInitial());

  void fetchCart() async {
    emit(CartLoading());
    try {
      final response = await cartRepository.getCart(token);
      if (response.status) {
        emit(CartLoaded(response.cartItems));
      } else {
        emit(CartError(response.message));
      }
    } catch (e) {
      emit(CartError('خطأ في جلب السلة: $e'));
    }
  }
}