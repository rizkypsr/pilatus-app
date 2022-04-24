import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pilatusapp/injection.dart' as di;
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
import 'package:pilatusapp/presentation/cubit/province_cubit.dart';
import 'package:pilatusapp/presentation/cubit/shipping_cubit.dart';
import 'package:pilatusapp/presentation/cubit/user_cubit.dart';
import 'package:pilatusapp/presentation/pages/account_page.dart';
import 'package:pilatusapp/presentation/pages/address_page.dart';
import 'package:pilatusapp/presentation/pages/cart_page.dart';
import 'package:pilatusapp/presentation/pages/category_page.dart';
import 'package:pilatusapp/presentation/pages/checkout_page.dart';
import 'package:pilatusapp/presentation/pages/detail_category_page.dart';
import 'package:pilatusapp/presentation/pages/detail_order_page.dart';
import 'package:pilatusapp/presentation/pages/detail_product_page.dart';
import 'package:pilatusapp/presentation/pages/finished_checkout_page.dart';
import 'package:pilatusapp/presentation/pages/home_page.dart';
import 'package:pilatusapp/presentation/pages/login_page.dart';
import 'package:pilatusapp/presentation/pages/order_page.dart';
import 'package:pilatusapp/presentation/pages/payment_page.dart';
import 'package:pilatusapp/presentation/pages/personal_details_page.dart';
import 'package:pilatusapp/presentation/pages/personal_edit_page.dart';
import 'package:pilatusapp/presentation/pages/register_detail_page.dart';
import 'package:pilatusapp/presentation/pages/register_page.dart';
import 'package:pilatusapp/presentation/pages/select_shipping_page.dart';
import 'package:pilatusapp/presentation/pages/shipping_page.dart';
import 'package:pilatusapp/styles/colors.dart';
import 'package:pilatusapp/styles/text_styles.dart';
import 'package:pilatusapp/utils/routes.dart';

void main() {
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  late int _currentIndex;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<ButtomNavCubit>(
            create: (_) => di.locator<ButtomNavCubit>(),
          ),
          BlocProvider<ProductsCubit>(
            create: (_) => di.locator<ProductsCubit>(),
          ),
          BlocProvider<ProductDetailCubit>(
            create: (_) => di.locator<ProductDetailCubit>(),
          ),
          BlocProvider<CategoryCubit>(
            create: (_) => di.locator<CategoryCubit>(),
          ),
          BlocProvider<CartCubit>(
            create: (_) => di.locator<CartCubit>(),
          ),
          BlocProvider<OrderCubit>(
            create: (_) => di.locator<OrderCubit>(),
          ),
          BlocProvider<OrderDetailCubit>(
            create: (_) => di.locator<OrderDetailCubit>(),
          ),
          BlocProvider<ShippingCubit>(
            create: (_) => di.locator<ShippingCubit>(),
          ),
          BlocProvider<CityCubit>(
            create: (_) => di.locator<CityCubit>(),
          ),
          BlocProvider<ProvinceCubit>(
            create: (_) => di.locator<ProvinceCubit>(),
          ),
          BlocProvider<AddressCubit>(
            create: (_) => di.locator<AddressCubit>(),
          ),
          BlocProvider<ShippingCubit>(
            create: (_) => di.locator<ShippingCubit>(),
          ),
          BlocProvider<PaymentCubit>(
            create: (_) => di.locator<PaymentCubit>(),
          ),
          BlocProvider<AuthCubit>(
            create: (_) => di.locator<AuthCubit>()..checkLoginState(),
          ),
          BlocProvider<UserCubit>(
            create: (_) => di.locator<UserCubit>(),
          ),
          BlocProvider<BankCubit>(
            create: (_) => di.locator<BankCubit>(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Pilatus Showroom',
          theme: ThemeData.light().copyWith(
            textTheme: kTextTheme,
            colorScheme: kColorScheme,
          ),
          home: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is LoginErrorState) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            builder: (context, state) {
              if (state is LoadingLoginState) {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is LoginErrorState) {
                return const LoginPage();
              } else if (state is UnlogedState) {
                return const LoginPage();
              } else if (state is LogedState) {
                return BlocBuilder<ButtomNavCubit, int>(
                  builder: (context, state) {
                    _currentIndex = state;
                    return Scaffold(
                      body: _buildBody(state),
                      bottomNavigationBar: _buildBottomNavigationBar(context),
                    );
                  },
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          onGenerateRoute: (RouteSettings settings) {
            switch (settings.name) {
              case mainPageRoute:
                return MaterialPageRoute(builder: (_) => MyApp());
              case homePageRoute:
                return MaterialPageRoute(builder: (_) => const HomePage());
              case categoryPageRoute:
                return MaterialPageRoute(builder: (_) => const CategoryPage());
              case orderPageRoute:
                return MaterialPageRoute(builder: (_) => const OrderPage());
              case accountPageRoute:
                return MaterialPageRoute(builder: (_) => AccountPage());
              case cartPageRoute:
                return MaterialPageRoute(builder: (_) => const CartPage());
              case checkoutPageRoute:
                return MaterialPageRoute(builder: (_) => const CheckoutPage());
              case registerPageRoute:
                return MaterialPageRoute(builder: (_) => const RegisterPage());
              case selectShippingPageRoute:
                return MaterialPageRoute(
                    builder: (_) => const SelectShippingPage());
              case registerDetailPageRoute:
                return MaterialPageRoute(builder: (_) {
                  final data = settings.arguments as Map<String, String>;
                  return RegisterDetail(
                    data: data,
                  );
                });
              case paymentPageRoute:
                return MaterialPageRoute(builder: (_) {
                  final id = settings.arguments as int;
                  return PaymentPage(
                    orderId: id,
                  );
                });
              case shippingPageRoute:
                return MaterialPageRoute(builder: (_) {
                  final obj = settings.arguments as Map<String, dynamic>;
                  return ShippingPage(
                      origin: obj['origin'],
                      destination: obj['destination'],
                      weight: obj['weight']);
                });
              case finishedCheckoutPageRoute:
                return MaterialPageRoute(builder: (_) {
                  final id = settings.arguments as int;
                  return FinishedCheckoutPage(orderId: id);
                });
              case addressPageRoute:
                return MaterialPageRoute(builder: (_) => const AddressPage());
              case detailOrderPageRoute:
                final id = settings.arguments as int;
                return MaterialPageRoute(
                    builder: (_) => DetailOrderPage(id: id));
              case personalDetailsPageRoute:
                return MaterialPageRoute(
                    builder: (_) => const PersonalDetailsPage());
              case personalEditPageRoute:
                final data = settings.arguments as Map<String, dynamic>;
                return MaterialPageRoute(
                    builder: (_) => PersonalEditPage(
                          type: data['type'],
                          user: data['value'],
                        ));
              case detailCategoryPageRoute:
                final id = settings.arguments as int;
                return MaterialPageRoute(
                    builder: (_) => DetailCategoryPage(
                          id: id,
                        ));
              case detailProductPageRoute:
                final productId = settings.arguments as int;
                return MaterialPageRoute(
                    builder: (_) => ProductDetailPage(
                          productId: productId,
                        ));
              default:
                return MaterialPageRoute(builder: (_) {
                  return const Scaffold(
                    body: Center(
                      child: Text('Page not found :('),
                    ),
                  );
                });
            }
          },
        ));
  }

  Widget _buildBody(int index) {
    switch (index) {
      case 0:
        return const HomePage();
      case 1:
        return const CategoryPage();
      case 2:
        return const OrderPage();
      case 3:
        return AccountPage();
      default:
        return const Text('Not Found');
    }
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedIconTheme: Theme.of(context).iconTheme,
        showUnselectedLabels: true,
        currentIndex: _currentIndex,
        onTap: (index) {
          switch (index) {
            case 0:
              context.read<ButtomNavCubit>().getHomePage();
              break;
            case 1:
              context.read<ButtomNavCubit>().getCategoryPage();
              break;
            case 2:
              context.read<ButtomNavCubit>().getOrderPage();
              break;
            case 3:
              context.read<ButtomNavCubit>().getAccountPage();
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(
              icon: Icon(Icons.category_rounded), label: 'Kategori'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_rounded), label: 'Transaksi'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Akun'),
        ]);
  }
}
