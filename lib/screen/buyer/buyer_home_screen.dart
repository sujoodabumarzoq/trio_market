import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trio_market/Repositories/product_repository.dart';
import 'package:trio_market/cubit/product/product_cubit.dart';

class BuyerHomeScreen extends StatelessWidget {
  const BuyerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCubit(ProductRepository())..fetchProducts('1'), // افتراضياً category_id=1
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF1976D2),
          title: const Text('الصفحة الرئيسية - المشتري', style: TextStyle(color: Colors.white)),
        ),
        body: BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProductLoaded) {
              return ListView.builder(
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  final product = state.products[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: ListTile(
                      leading: Image.network(product.image, width: 50, height: 50, fit: BoxFit.cover),
                      title: Text(product.name),
                      subtitle: Text('${product.price} \$'),
                      trailing: IconButton(
                        icon: const Icon(Icons.arrow_forward, color: Color(0xFF1976D2)),
                        onPressed: () {
                          Navigator.pushNamed(context, '/product_details', arguments: product.id);
                        },
                      ),
                    ),
                  );
                },
              );
            } else if (state is ProductError) {
              return Center(child: Text(state.error));
            }
            return const Center(child: Text('اضغط لتحميل المنتجات'));
          },
        ),
      ),
    );
  }
}