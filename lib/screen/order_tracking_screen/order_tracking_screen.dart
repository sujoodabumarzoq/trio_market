import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trio_market/Repositories/order_repository.dart';
import 'package:trio_market/cubit/order_tracking/order_tracking_cubit.dart';

class OrderTrackingScreen extends StatelessWidget {
  final int orderId = 1; // افتراضي، عدله حسب الطلب
  final String token = "YOUR_TOKEN_HERE";

  const OrderTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderTrackingCubit(OrderRepository(), token)..trackOrder(orderId),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF1976D2),
          title: const Text('تتبع الطلب', style: TextStyle(color: Colors.white)),
        ),
        body: BlocBuilder<OrderTrackingCubit, OrderTrackingState>(
          builder: (context, state) {
            if (state is OrderTrackingLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is OrderTrackingLoaded) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text('رقم الطلب: ${state.order.id}'),
                    Text('الحالة: ${state.order.status}'),
                    Text('الإجمالي: ${state.order.total} \$'),
                  ],
                ),
              );
            } else if (state is OrderTrackingError) {
              return Center(child: Text(state.error));
            }
            return const Center(child: Text('جاري تحميل التتبع'));
          },
        ),
      ),
    );
  }
}