import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pilatusapp/common/constants.dart';
import 'package:pilatusapp/domain/entities/details_cart.dart';
import 'package:pilatusapp/presentation/cubit/cart_cubit.dart';
import 'package:pilatusapp/styles/text_styles.dart';
import 'package:pilatusapp/utils/routes.dart';
import 'package:shimmer/shimmer.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CartCubit>(context).fetchCartList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Keranjang'),
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<CartCubit, CartState>(
                builder: (context, state) {
                  if (state is CartLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is CartError) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else if (state is CartHasData) {
                    return ListView.builder(
                        itemCount: state.results.length,
                        itemBuilder: (context, index) {
                          return CartList(detailsCart: state.results[index]);
                        });
                  } else {
                    return const Center(
                      child: Text('Keranjang masih kosong'),
                    );
                  }
                },
              ),
            ),
            SafeArea(
              child: Container(
                padding: const EdgeInsets.all(16),
                color: Colors.white,
                height: 70,
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, selectShippingPageRoute);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.shopping_bag_rounded),
                      Text("CHECKOUT")
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }
}

class CartList extends StatelessWidget {
  CartList({Key? key, required this.detailsCart}) : super(key: key);

  final DetailsCart detailsCart;
  final formatCurrency = NumberFormat.simpleCurrency(locale: 'id_ID');

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(24),
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: "$baseUrl/images/${detailsCart.product.photo}",
              imageBuilder: (_, imageProvider) => Container(
                  height: 90,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    image: DecorationImage(
                        fit: BoxFit.cover, image: imageProvider),
                  )),
              placeholder: (_, __) => Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 90,
                    width: 120,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                  )),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    detailsCart.product.name,
                    overflow: TextOverflow.ellipsis,
                    style: kHeading6,
                  ),
                  Text(
                    formatCurrency.format(
                        detailsCart.product.total * detailsCart.quantity),
                    style: kSubtitle,
                  ),
                  Text(
                    'x${detailsCart.quantity.toString()}',
                    style: kSubtitle,
                  ),
                ],
              ),
            ),
            BlocListener<CartCubit, CartState>(
              listener: (context, state) {
                if (state is CartRemoved) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.message)));
                }
              },
              child: IconButton(
                  onPressed: () {
                    BlocProvider.of<CartCubit>(context)
                        .removeFromCart(detailsCart.id);
                  },
                  icon: const Icon(
                    Icons.delete_forever_rounded,
                    color: Colors.red,
                  )),
            ),
          ],
        ));
  }
}
