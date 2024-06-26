import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/product_service.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductService productService;

  ProductBloc({required this.productService}) : super(ProductLoading()) {
    on<FetchProducts>(_onFetchProducts);
    on<FetchProductsByCategory>(_onFetchProductsByCategory);
  }

  void _onFetchProducts(FetchProducts event, Emitter<ProductState> emit) async {
    try {
      final products = await productService.getAllProducts();
      emit(ProductLoaded(products: products));
    } catch (_) {
      emit(ProductError('Failed to fetch products'));
    }
  }

  void _onFetchProductsByCategory(
      FetchProductsByCategory event, Emitter<ProductState> emit) async {
    try {
      final products = await productService.getAllProducts();
      final filteredProducts = products
          .where((product) => product.category == event.category)
          .toList();
      emit(ProductLoaded(products: filteredProducts));
    } catch (_) {
      emit(ProductError('Failed to fetch products'));
    }
  }
}
