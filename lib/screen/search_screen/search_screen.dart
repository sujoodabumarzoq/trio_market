import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trio_market/Repositories/product_repository.dart';
import 'package:trio_market/cubit/search/search_cubit.dart';

class SearchScreen extends StatelessWidget {
  final _searchController = TextEditingController();

   SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(ProductRepository()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF1976D2),
          title: const Text('البحث', style: TextStyle(color: Colors.white)),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  labelText: 'ابحث عن منتج',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      context.read<SearchCubit>().searchProducts(_searchController.text);
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  if (state is SearchLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is SearchLoaded) {
                    return ListView.builder(
                      itemCount: state.products.length,
                      itemBuilder: (context, index) {
                        final product = state.products[index];
                        return ListTile(
                          leading: Image.network(product.image, width: 50),
                          title: Text(product.name),
                          subtitle: Text('${product.price} \$'),
                        );
                      },
                    );
                  } else if (state is SearchError) {
                    return Center(child: Text(state.error));
                  }
                  return const Center(child: Text('ابحث عن منتج'));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}