import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:pilatusapp/data/datasources/auth_local_data_source.dart';
import 'package:pilatusapp/data/datasources/auth_remote_data_source.dart';
import 'package:pilatusapp/data/datasources/bank_remote_data_source.dart';
import 'package:pilatusapp/data/datasources/cart_remote_data_source.dart';
import 'package:pilatusapp/data/datasources/category_local_data_source.dart';
import 'package:pilatusapp/data/datasources/category_remote_data_source.dart';
import 'package:pilatusapp/data/datasources/db/database_helper.dart';
import 'package:pilatusapp/data/datasources/order_remote_data_source.dart';
import 'package:pilatusapp/data/datasources/product_local_data_source.dart';
import 'package:pilatusapp/data/datasources/product_remote_data_source.dart';
import 'package:pilatusapp/data/datasources/address_remote_data_source.dart';
import 'package:pilatusapp/data/datasources/shipping_remote_data_source.dart';
import 'package:pilatusapp/data/datasources/user_remote_data_source.dart';
import 'package:pilatusapp/data/repositories/auth_repository_impl.dart';
import 'package:pilatusapp/data/repositories/cart_repository_impl.dart';
import 'package:pilatusapp/data/repositories/category_repository_impl.dart';
import 'package:pilatusapp/data/repositories/order_repository_impl.dart';
import 'package:pilatusapp/data/repositories/payment_repository_impl.dart';
import 'package:pilatusapp/data/repositories/product_repository_impl.dart';
import 'package:pilatusapp/data/repositories/address_repository_impl.dart';
import 'package:pilatusapp/data/repositories/shipping_repository_impl.dart';
import 'package:pilatusapp/data/repositories/user_repository_impl.dart';
import 'package:pilatusapp/domain/repositories/auth_repository.dart';
import 'package:pilatusapp/domain/repositories/cart_repository.dart';
import 'package:pilatusapp/domain/repositories/category_repository.dart';
import 'package:pilatusapp/domain/repositories/order_repository.dart';
import 'package:pilatusapp/domain/repositories/payment_repository.dart';
import 'package:pilatusapp/domain/repositories/product_repository.dart';
import 'package:pilatusapp/domain/repositories/address_repository.dart';
import 'package:pilatusapp/domain/repositories/shipping_repository.dart';
import 'package:pilatusapp/domain/repositories/user_repository.dart';
import 'package:pilatusapp/domain/usecase/add_order.dart';
import 'package:pilatusapp/domain/usecase/add_to_cart.dart';
import 'package:pilatusapp/domain/usecase/finish_order.dart';
import 'package:pilatusapp/domain/usecase/get_address.dart';
import 'package:pilatusapp/domain/usecase/get_bank.dart';
import 'package:pilatusapp/domain/usecase/get_cart_list.dart';
import 'package:pilatusapp/domain/usecase/get_categories.dart';
import 'package:pilatusapp/domain/usecase/get_city.dart';
import 'package:pilatusapp/domain/usecase/get_cost.dart';
import 'package:pilatusapp/domain/usecase/get_order_detail.dart';
import 'package:pilatusapp/domain/usecase/get_orders.dart';
import 'package:pilatusapp/domain/usecase/get_payment.dart';
import 'package:pilatusapp/domain/usecase/get_product_detail.dart';
import 'package:pilatusapp/domain/usecase/get_products.dart';
import 'package:pilatusapp/domain/usecase/get_products_by_category.dart';
import 'package:pilatusapp/domain/usecase/get_province.dart';
import 'package:pilatusapp/domain/usecase/get_token.dart';
import 'package:pilatusapp/domain/usecase/get_user.dart';
import 'package:pilatusapp/domain/usecase/login_auth.dart';
import 'package:pilatusapp/domain/usecase/logout_auth.dart';
import 'package:pilatusapp/domain/usecase/register_auth.dart';
import 'package:pilatusapp/domain/usecase/remove_from_cart.dart';
import 'package:pilatusapp/domain/usecase/save_address.dart';
import 'package:pilatusapp/domain/usecase/save_token.dart';
import 'package:pilatusapp/domain/usecase/update_payment.dart';
import 'package:pilatusapp/domain/usecase/update_user.dart';
import 'package:pilatusapp/presentation/cubit/address_cubit.dart';
import 'package:pilatusapp/presentation/cubit/auth_cubit.dart';
import 'package:pilatusapp/presentation/cubit/bank_cubit.dart';
import 'package:pilatusapp/presentation/cubit/city_cubit.dart';
import 'package:pilatusapp/presentation/cubit/buttom_nav_cubit.dart';
import 'package:pilatusapp/presentation/cubit/cart_cubit.dart';
import 'package:pilatusapp/presentation/cubit/category_cubit.dart';
import 'package:pilatusapp/presentation/cubit/order_cubit.dart';
import 'package:pilatusapp/presentation/cubit/order_detail_cubit.dart';
import 'package:pilatusapp/presentation/cubit/payment_cubit.dart';
import 'package:pilatusapp/presentation/cubit/product_detail_cubit.dart';
import 'package:pilatusapp/presentation/cubit/products_cubit.dart';
import 'package:http/http.dart' as http;
import 'package:pilatusapp/presentation/cubit/province_cubit.dart';
import 'package:pilatusapp/presentation/cubit/shipping_cubit.dart';
import 'package:pilatusapp/presentation/cubit/user_cubit.dart';

final locator = GetIt.instance;

void init() {
  locator.registerFactory(() => ButtomNavCubit());
  locator.registerFactory(() => ShippingCubit(getCost: locator()));
  locator.registerFactory(() =>
      ProductsCubit(getProducts: locator(), getProductsByCategory: locator()));
  locator.registerFactory(() => CategoryCubit(getCategories: locator()));
  locator
      .registerFactory(() => ProductDetailCubit(getProductDetail: locator()));
  locator.registerFactory(() => CartCubit(
      getCartList: locator(),
      addToCartUsecase: locator(),
      removeFromCartUsecase: locator()));
  locator.registerFactory(() => OrderCubit(
      getOrders: locator(),
      addOrder: locator(),
      updatePayment: locator(),
      finishOrder: locator()));
  locator.registerFactory(() => OrderDetailCubit(getOrderDetail: locator()));
  locator.registerFactory(() => CityCubit(getCity: locator()));
  locator.registerFactory(() => ProvinceCubit(getProvince: locator()));
  locator.registerFactory(() =>
      AddressCubit(saveAdressUsecase: locator(), getAddressUsecase: locator()));
  locator.registerFactory(() => PaymentCubit(getPayment: locator()));
  locator.registerFactory(() => AuthCubit(
      getToken: locator(),
      loginAuth: locator(),
      saveToken: locator(),
      logoutAuth: locator(),
      registerAuth: locator()));
  locator.registerFactory(
      () => UserCubit(getUser: locator(), updateUser: locator()));
  locator.registerFactory(() => BankCubit(getBank: locator()));

  // usecase
  locator.registerLazySingleton(() => GetProducts(locator()));
  locator.registerLazySingleton(() => GetProductsByCategory(locator()));
  locator.registerLazySingleton(() => GetCategories(locator()));
  locator.registerLazySingleton(() => GetProductDetail(locator()));
  locator.registerLazySingleton(() => GetCartList(locator()));
  locator.registerLazySingleton(() => AddToCart(locator()));
  locator.registerLazySingleton(() => RemoveFromCart(locator()));
  locator.registerLazySingleton(() => GetOrders(locator()));
  locator.registerLazySingleton(() => GetOrderDetail(locator()));
  locator.registerLazySingleton(() => GetProvince(locator()));
  locator.registerLazySingleton(() => GetCity(locator()));
  locator.registerLazySingleton(() => SaveAdress(locator()));
  locator.registerLazySingleton(() => GetAddress(locator()));
  locator.registerLazySingleton(() => GetCost(locator()));
  locator.registerLazySingleton(() => AddOrder(locator()));
  locator.registerLazySingleton(() => UpdatePayment(locator()));
  locator.registerLazySingleton(() => GetPayment(locator()));
  locator.registerLazySingleton(() => GetToken(locator()));
  locator.registerLazySingleton(() => SaveToken(locator()));
  locator.registerLazySingleton(() => LoginAuth(locator()));
  locator.registerLazySingleton(() => LogoutAuth(locator()));
  locator.registerLazySingleton(() => RegisterAuth(locator()));
  locator.registerLazySingleton(() => GetUser(locator()));
  locator.registerLazySingleton(() => UpdateUser(locator()));
  locator.registerLazySingleton(() => FinishOrder(locator()));
  locator.registerLazySingleton(() => GetBank(locator()));

  // repositoriessss
  locator.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<CartRepository>(
    () => CartRepositoryImpl(
      remoteDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<OrderRepository>(
    () => OrderRepositoryImpl(
      remoteDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<AddressRepository>(
    () => AddressRepositoryImpl(
      remoteDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<ShippingRepository>(
    () => ShippingRepositoryImpl(
      remoteDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      remoteDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<PaymentRepository>(
    () => PaymentRepositoryImpl(
      remoteDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<ProductLocalDataSource>(
      () => ProductLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<CategoryRemoteDataSource>(
      () => CategoryRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<CategoryLocalDataSource>(
      () => CategoryLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<CartRemoteDataSource>(() =>
      CartRemoteDataSourceImpl(client: locator(), secureStorage: locator()));
  locator.registerLazySingleton<OrderRemoteDataSource>(() =>
      OrderRemoteDataSourceImpl(client: locator(), secureStorage: locator()));
  locator.registerLazySingleton<AddressRemoteDataSource>(() =>
      AddressRemoteDataSourceImpl(client: locator(), secureStorage: locator()));
  locator.registerLazySingleton<ShippingRemoteDataSource>(
      () => ShippingRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(secureStorage: locator()));
  locator.registerLazySingleton<UserRemoteDataSource>(() =>
      UserRemoteDataSourceImpl(secureStorage: locator(), client: locator()));
  locator.registerLazySingleton<BankRemoteDataSource>(
      () => BankRemoteDataSourceImpl(client: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => const FlutterSecureStorage());
}
