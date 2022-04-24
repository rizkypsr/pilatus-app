import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pilatusapp/presentation/cubit/cart_cubit.dart';
import 'package:pilatusapp/presentation/cubit/order_cubit.dart';
import 'package:pilatusapp/utils/helpers.dart';
import 'package:pilatusapp/utils/routes.dart';

class SelectShippingPage extends StatefulWidget {
  const SelectShippingPage({Key? key}) : super(key: key);

  @override
  State<SelectShippingPage> createState() => _SelectShippingPageState();
}

class _SelectShippingPageState extends State<SelectShippingPage> {
  final Map<String, dynamic> results = {
    "products": [],
    "total": 0,
    "address_id": null,
    "courier": null,
    "shipping_cost": null,
    "service": null
  };

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CartCubit>(context).fetchCartList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pilih Pengiriman'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              width: double.maxFinite,
              child: Card(
                child: BlocListener<CartCubit, CartState>(
                  listener: (context, state) {
                    if (state is CartHasData) {
                      results['total'] = calculateTotal(toArray(state.results));
                      results['products'] = List.from(state.results.map((e) => {
                            "product_id": e.product.id,
                            "quantity": e.quantity
                          }));
                    }
                  },
                  child: InkWell(
                    onTap: () {
                      BlocProvider.of<OrderCubit>(context).saveOrder(results);
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(24.0),
                      child: Text('Ambil Barang Di Toko'),
                    ),
                  ),
                ),
              ),
            ),
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
              child: const SizedBox(
                height: 10,
              ),
            ),
            SizedBox(
              width: double.maxFinite,
              child: Card(
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, checkoutPageRoute);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(24.0),
                    child: Text('Barang Dikirim'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
