import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pilatusapp/domain/entities/product_detail.dart';
import 'package:pilatusapp/domain/usecase/get_product_detail.dart';

part 'product_detail_state.dart';

class ProductDetailCubit extends Cubit<ProductDetailState> {
  ProductDetailCubit({required this.getProductDetail})
      : super(ProductDetailInitial());

  final GetProductDetail getProductDetail;

  void fetchProductDetail(int id) async {
    emit(ProductDetailLoading());
    final detailResult = await getProductDetail.execute(id);

    detailResult.fold(
      (failure) {
        emit(ProductDetailError(failure.message));
      },
      (product) {
        emit(ProductDetailHasData(product));
      },
    );
  }
}
