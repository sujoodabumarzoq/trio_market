import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trio_market/Repositories/cart_repository.dart';
import 'package:trio_market/cubit/cart/cart_cubit.dart';

class CartScreen extends StatelessWidget {
  final String token = "YOUR_TOKEN_HERE"; // استبدلها بالـ token من التسجيل

  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit(CartRepository(), token)..fetchCart(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF1976D2),
          title: const Text('سلة التسوق', style: TextStyle(color: Colors.white)),
        ),
        body: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CartLoaded) {
              return ListView.builder(
                itemCount: state.cartItems.length,
                itemBuilder: (context, index) {
                  final item = state.cartItems[index];
                  return ListTile(
                    leading: Image.network(item.product.image, width: 50),
                    title: Text(item.product.name),
                    subtitle: Text('الكمية: ${item.quantity} - ${item.product.price} \$'),
                  );
                },
              );
            } else if (state is CartError) {
              return Center(child: Text(state.error));
            }
            return const Center(child: Text('السلة فارغة'));
          },
        ),
      ),
    );
  }
}