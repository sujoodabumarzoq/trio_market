import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trio_market/Repositories/product_repository.dart';
import 'package:trio_market/cubit/product_details/product_details_cubit.dart';

class ProductDetailsScreen extends StatelessWidget {
  final int productId;

  const ProductDetailsScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductDetailsCubit(ProductRepository())..fetchProductDetails(productId),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF1976D2),
          title: const Text('تفاصيل المنتج', style: TextStyle(color: Colors.white)),
        ),
        body: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
          builder: (context, state) {
            if (state is ProductDetailsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProductDetailsLoaded) {
              final product = state.product;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(product.image, height: 200, fit: BoxFit.cover),
                    const SizedBox(height: 16),
                    Text(product.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text('${product.price} \$', style: const TextStyle(fontSize: 20, color: Colors.green)),
                    const SizedBox(height: 8),
                    Text(product.description),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/cart', arguments: product.id);
                          },
                          child: const Text('إضافة إلى السلة'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/checkout', arguments: product.id);
                          },
                          child: const Text('شراء الآن'),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            } else if (state is ProductDetailsError) {
              return Center(child: Text(state.error));
            }
            return const Center(child: Text('جاري تحميل التفاصيل'));
          },
        ),
      ),
    );
  }
}