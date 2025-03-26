import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:trio_market/model/product_model.dart';
import 'package:trio_market/Repositories/product_repository.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final ProductRepository productRepository;

  ProductDetailsCubit(this.productRepository) : super(ProductDetailsInitial());

  void fetchProductDetails(int productId) async {
    emit(ProductDetailsLoading());
    try {
      final response = await productRepository.getProductDetails(productId);
      if (response.status) {
        emit(ProductDetailsLoaded(response.product));
      } else {
        emit(ProductDetailsError(response.message));
      }
    } catch (e) {
      emit(ProductDetailsError('خطأ في جلب تفاصيل المنتج: $e'));
    }
  }
}