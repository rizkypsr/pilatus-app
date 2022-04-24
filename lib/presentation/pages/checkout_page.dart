import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pilatusapp/common/constants.dart';
import 'package:pilatusapp/domain/entities/details_cart.dart';
import 'package:pilatusapp/presentation/cubit/address_cubit.dart';
import 'package:pilatusapp/presentation/cubit/cart_cubit.dart';
import 'package:pilatusapp/presentation/cubit/order_cubit.dart';
import 'package:pilatusapp/styles/colors.dart';
import 'package:pilatusapp/styles/text_styles.dart';
import 'package:pilatusapp/utils/helpers.dart';
import 'package:pilatusapp/utils/routes.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AddressCubit>(context).getAddress();
    BlocProvider.of<CartCubit>(context).fetchCartList();
  }

  final formatCurrency = NumberFormat.simpleCurrency(locale: 'id_ID');
  int weight = 0;
  Map<String, dynamic> shipping = {"cost": 0};

  final Map<String, dynamic> results = {
    "products": [],
    "total": 0,
    "address_id": 0,
    "courier": "jne",
    "shipping_cost": 0,
    "service": ""
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        centerTitle: false,
        actions: [
          BlocListener<OrderCubit, OrderState>(
            listener: (context, state) {
              if (state is OrderAdded) {
                Navigator.pushNamed(context, finishedCheckoutPageRoute,
                    arguments: state.id);
              } else if (state is OrderError) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            child: IconButton(
                onPressed: () {
                  if (shipping['cost'] != 0) {
                    BlocProvider.of<OrderCubit>(context).saveOrder(results);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Pilih Pengiriman terlebih dahulu')));
                  }
                },
                icon: const Icon(Icons.arrow_forward_ios_rounded)),
          )
        ],
      ),
      body: SizedBox(
        child: SingleChildScrollView(
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, addressPageRoute);
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      const Icon(Icons.location_on_rounded),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Alamat Pengiriman'),
                            const SizedBox(
                              height: 5,
                            ),
                            BlocBuilder<AddressCubit, AddressState>(
                              builder: (context, state) {
                                if (state is AddressError) {
                                  return Text(state.message);
                                }
                                if (state is AddressHasData) {
                                  final address = state.address;

                                  results['address_id'] = address.id;

                                  return Text(
                                      'Rizky Pratama Syahrul Ramadhan\n${address.street}\n${address.city.cityName} - ${address.district}, ${address.province.province}, ${address.postalCode}');
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios),
                    ],
                  ),
                ),
              ),
              const Divider(thickness: 2),
              BlocBuilder<CartCubit, CartState>(
                builder: (context, state) {
                  if (state is CartLoading) {
                    return const CircularProgressIndicator();
                  } else if (state is CartError) {
                    return Text(state.message);
                  } else if (state is CartHasData) {
                    results['products'] = List.from(state.results.map((e) =>
                        {"product_id": e.product.id, "quantity": e.quantity}));
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.results.length,
                        itemBuilder: (context, index) {
                          return OrderProductList(
                              detailsCart: state.results[index]);
                        });
                  } else {
                    return Container();
                  }
                },
              ),
              const Divider(
                height: 0,
              ),
              BlocBuilder<CartCubit, CartState>(
                builder: (context, state) {
                  if (state is CartHasData) {
                    final detailsCart = state.results;

                    for (var dt in detailsCart) {
                      weight += dt.product.weight;
                    }

                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total Pesanan(${detailsCart.length} Produk)'),
                          Text(
                              formatCurrency
                                  .format(calculateTotal(toArray(detailsCart)))
                                  .toString(),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    );
                  }

                  return Container();
                },
              ),
              const Divider(thickness: 2),
              BlocBuilder<AddressCubit, AddressState>(
                builder: (context, state) {
                  if (state is AddressHasData) {
                    final address = state.address;

                    return InkWell(
                      onTap: () async {
                        Map<String, dynamic> obj = {
                          "origin": address.city.cityId,
                          "destination": 365,
                          "weight": weight
                        };
                        final results = await Navigator.pushNamed(
                            context, shippingPageRoute,
                            arguments: obj);

                        if (results != null) {
                          setState(() {
                            shipping = results as Map<String, dynamic>;
                          });
                        }
                      },
                      child: Container(
                        color: kLightPrimary.withOpacity(0.1),
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Pengiriman',
                              style: TextStyle(
                                  color: kLightPrimary,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text('Pilih Opsi Pengiriman'),
                                Icon(Icons.arrow_forward_ios_rounded)
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }

                  return Container();
                },
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: BlocBuilder<CartCubit, CartState>(
                  builder: (context, state) {
                    if (state is CartHasData) {
                      final detailsCart = state.results;

                      results['total'] = calculateTotal(toArray(detailsCart),
                          cost: shipping['cost']!);
                      results['shipping_cost'] = shipping['cost'];
                      results['service'] = shipping['service'];

                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Subtotal Produk'),
                              Text(formatCurrency
                                  .format(calculateTotal(toArray(detailsCart)))
                                  .toString()),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Ongkir'),
                              Text(formatCurrency.format(shipping['cost'])),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Total Pembayaran',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                formatCurrency
                                    .format(calculateTotal(toArray(detailsCart),
                                        cost: shipping['cost']!))
                                    .toString(),
                                style: kHeading6,
                              ),
                            ],
                          )
                        ],
                      );
                    }
                    return Container();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class OrderProductList extends StatelessWidget {
  OrderProductList({Key? key, required this.detailsCart}) : super(key: key);

  final DetailsCart detailsCart;
  final formatCurrency = NumberFormat.simpleCurrency(locale: 'id_ID');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            CachedNetworkImage(
              imageUrl: "$baseUrl/images/${detailsCart.product.photo}",
              width: 70,
              fit: BoxFit.cover,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    detailsCart.product.name,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text('x${detailsCart.quantity.toString()}', style: kSubtitle2)
                ],
              ),
            )
          ],
        ),
        const SizedBox(height: 15),
        const Text('Total Harga'),
        Text(
            formatCurrency
                .format(detailsCart.quantity * detailsCart.product.total)
                .toString(),
            style: const TextStyle(fontWeight: FontWeight.bold)),
      ]),
    );
  }
}
