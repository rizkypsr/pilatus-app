import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pilatusapp/domain/entities/product.dart';
import 'package:pilatusapp/domain/usecase/get_products.dart';
import 'package:pilatusapp/domain/usecase/get_products_by_category.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit(
      {required this.getProducts, required this.getProductsByCategory})
      : super(ProductsInitial());

  final GetProducts getProducts;
  final GetProductsByCategory getProductsByCategory;

  void fetchProducts() async {
    emit(ProductsLoading());
    final results = await getProducts.execute();

    results.fold((failure) async {
      emit(ProductsError(failure.message));
    }, (data) {
      emit(ProductsHasData(data));
    });
  }

  void fetchProductsByCategory(int id) async {
    emit(ProductsLoading());
    final results = await getProductsByCategory.execute(id);

    results.fold((failure) async {
      emit(ProductsError(failure.message));
    }, (data) {
      emit(ProductsHasData(data));
    });
  }
}
