import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pilatusapp/domain/entities/details_cart.dart';
import 'package:pilatusapp/domain/usecase/add_to_cart.dart';
import 'package:pilatusapp/domain/usecase/get_cart_list.dart';
import 'package:pilatusapp/domain/usecase/remove_from_cart.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit(
      {required this.getCartList,
      required this.addToCartUsecase,
      required this.removeFromCartUsecase})
      : super(CartInitial());

  final GetCartList getCartList;
  final AddToCart addToCartUsecase;
  final RemoveFromCart removeFromCartUsecase;

  void fetchCartList() async {
    emit(CartLoading());
    final results = await getCartList.execute();

    results.fold((failure) async {
      emit(CartError(failure.message));
    }, (data) {
      emit(CartHasData(data != null ? data.detailsCart : []));
    });
  }

  void addToCart(int productId) async {
    emit(CartLoading());
    final results = await addToCartUsecase.execute(productId);

    results.fold((failure) async {
      emit(CartError(failure.message));
    }, (data) {
      emit(CartAdded(data));
    });
  }

  void removeFromCart(int id) async {
    final results = await removeFromCartUsecase.execute(id);

    results.fold((failure) async {
      emit(CartError(failure.message));
    }, (data) {
      emit(CartRemoved(data));
    });

    fetchCartList();
  }
}
