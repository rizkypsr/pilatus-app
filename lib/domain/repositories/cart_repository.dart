import 'package:dartz/dartz.dart';
import 'package:pilatusapp/common/failure.dart';
import 'package:pilatusapp/domain/entities/cart.dart';

abstract class CartRepository {
  Future<Either<Failure, Cart?>> getCartList();
  Future<Either<Failure, String>> addToCart(int productId);
  Future<Either<Failure, String>> removeFromCart(int id);
}
