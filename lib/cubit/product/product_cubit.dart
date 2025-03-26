import 'package:bloc/bloc.dart';
import 'package:trio_market/model/product_model.dart';
import 'package:trio_market/Repositories/product_repository.dart';
import 'package:meta/meta.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository productRepository;

  ProductCubit(this.productRepository) : super(ProductInitial());

  void fetchProducts(String categoryId) async {
    emit(ProductLoading());
    try {
      final response = await productRepository.getProductsByCategory(categoryId);
      if (response.status) {
        emit(ProductLoaded(response.products));
      } else {
        emit(ProductError(response.message));
      }
    } catch (e) {
      emit(ProductError('خطأ في جلب المنتجات: $e'));
    }
  }
}