import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trio_market/Repositories/checkout_repository.dart';
import 'package:trio_market/cubit/checkout/checkout_cubit.dart';

class CheckoutScreen extends StatelessWidget {
  final int productId;
  final String token = "YOUR_TOKEN_HERE";

  const CheckoutScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CheckoutCubit(CheckoutRepository(), token),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF1976D2),
          title: const Text('إتمام الطلب', style: TextStyle(color: Colors.white)),
        ),
        body: BlocConsumer<CheckoutCubit, CheckoutState>(
          listener: (context, state) {
            if (state is CheckoutSuccess) {
              Navigator.pop(context);
            } else if (state is CheckoutError) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
            }
          },
          builder: (context, state) {
            if (state is CheckoutLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text('تأكيد الطلب', style: TextStyle(fontSize: 24)),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      context.read<CheckoutCubit>().performCheckout(productId);
                    },
                    child: const Text('تأكيد الشراء'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}