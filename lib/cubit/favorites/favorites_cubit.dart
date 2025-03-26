import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:trio_market/model/favorites_model.dart';
import 'package:trio_market/Repositories/favorites_repository.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final FavoritesRepository favoritesRepository;
  final String token;

  FavoritesCubit(this.favoritesRepository, this.token) : super(FavoritesInitial());

  void fetchFavorites() async {
    emit(FavoritesLoading());
    try {
      final response = await favoritesRepository.getFavorites(token);
      if (response.status) {
        emit(FavoritesLoaded(response.favorites));
      } else {
        emit(FavoritesError(response.message));
      }
    } catch (e) {
      emit(FavoritesError('خطأ في جلب المفضلة: $e'));
    }
  }
}