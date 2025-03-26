import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:trio_market/model/order_model.dart';
import 'package:trio_market/Repositories/order_repository.dart';

part 'order_tracking_state.dart';

class OrderTrackingCubit extends Cubit<OrderTrackingState> {
  final OrderRepository orderRepository;
  final String token;

  OrderTrackingCubit(this.orderRepository, this.token) : super(OrderTrackingInitial());

  void trackOrder(int orderId) async {
    emit(OrderTrackingLoading());
    try {
      final response = await orderRepository.trackOrder(token, orderId);
      if (response.status) {
        emit(OrderTrackingLoaded(response.order));
      } else {
        emit(OrderTrackingError(response.message));
      }
    } catch (e) {
      emit(OrderTrackingError('خطأ في تتبع الطلب: $e'));
    }
  }
}