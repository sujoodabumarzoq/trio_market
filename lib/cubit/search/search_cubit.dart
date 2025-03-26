import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:trio_market/model/product_model.dart';
import 'package:trio_market/Repositories/product_repository.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final ProductRepository productRepository;

  SearchCubit(this.productRepository) : super(SearchInitial());

  void searchProducts(String query) async {
    emit(SearchLoading());
    try {
      final response = await productRepository.searchProducts(query);
      if (response.status) {
        emit(SearchLoaded(response.products));
      } else {
        emit(SearchError(response.message));
      }
    } catch (e) {
      emit(SearchError('خطأ في البحث: $e'));
    }
  }
}