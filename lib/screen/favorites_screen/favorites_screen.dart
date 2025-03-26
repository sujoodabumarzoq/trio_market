import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trio_market/Repositories/favorites_repository.dart';
import 'package:trio_market/cubit/favorites/favorites_cubit.dart';

class FavoritesScreen extends StatelessWidget {
  final String token = "YOUR_TOKEN_HERE";

  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoritesCubit(FavoritesRepository(), token)..fetchFavorites(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF1976D2),
          title: const Text('المفضلة', style: TextStyle(color: Colors.white)),
        ),
        body: BlocBuilder<FavoritesCubit, FavoritesState>(
          builder: (context, state) {
            if (state is FavoritesLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is FavoritesLoaded) {
              return ListView.builder(
                itemCount: state.favorites.length,
                itemBuilder: (context, index) {
                  final favorite = state.favorites[index];
                  return ListTile(
                    leading: Image.network(favorite.product.image, width: 50),
                    title: Text(favorite.product.name),
                    subtitle: Text('${favorite.product.price} \$'),
                  );
                },
              );
            } else if (state is FavoritesError) {
              return Center(child: Text(state.error));
            }
            return const Center(child: Text('لا يوجد مفضلات'));
          },
        ),
      ),
    );
  }
}