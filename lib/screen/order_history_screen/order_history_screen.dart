import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trio_market/Repositories/order_repository.dart';
import 'package:trio_market/cubit/order_history/order_history_cubit.dart';

class OrderHistoryScreen extends StatelessWidget {
  final String token = "YOUR_TOKEN_HERE";

  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderHistoryCubit(OrderRepository(), token)..fetchOrderHistory(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF1976D2),
          title: const Text('سجل الطلبات', style: TextStyle(color: Colors.white)),
        ),
        body: BlocBuilder<OrderHistoryCubit, OrderHistoryState>(
          builder: (context, state) {
            if (state is OrderHistoryLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is OrderHistoryLoaded) {
              return ListView.builder(
                itemCount: state.orders.length,
                itemBuilder: (context, index) {
                  final order = state.orders[index];
                  return ListTile(
                    title: Text('طلب رقم: ${order.id}'),
                    subtitle: Text('الحالة: ${order.status} - ${order.total} \$'),
                  );
                },
              );
            } else if (state is OrderHistoryError) {
              return Center(child: Text(state.error));
            }
            return const Center(child: Text('لا يوجد طلبات سابقة'));
          },
        ),
      ),
    );
  }
}