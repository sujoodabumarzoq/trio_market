import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:trio_market/model/order_model.dart';
import 'package:trio_market/Repositories/order_repository.dart';

part 'order_history_state.dart';

class OrderHistoryCubit extends Cubit<OrderHistoryState> {
  final OrderRepository orderRepository;
  final String token;

  OrderHistoryCubit(this.orderRepository, this.token) : super(OrderHistoryInitial());

  void fetchOrderHistory() async {
    emit(OrderHistoryLoading());
    try {
      final response = await orderRepository.getOrderHistory(token);
      if (response.status) {
        emit(OrderHistoryLoaded(response.orders));
      } else {
        emit(OrderHistoryError(response.message));
      }
    } catch (e) {
      emit(OrderHistoryError('خطأ في جلب سجل الطلبات: $e'));
    }
  }
}