import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pilatusapp/common/constants.dart';
import 'package:pilatusapp/domain/entities/order.dart';
import 'package:pilatusapp/presentation/cubit/order_cubit.dart';
import 'package:pilatusapp/presentation/widgets/order_type_widget.dart';
import 'package:pilatusapp/styles/text_styles.dart';
import 'package:pilatusapp/utils/helpers.dart';
import 'package:pilatusapp/utils/routes.dart';

class OrderViewPage extends StatefulWidget {
  const OrderViewPage({Key? key, required this.status}) : super(key: key);

  final String status;

  @override
  State<OrderViewPage> createState() => _OrderViewPageState();
}

class _OrderViewPageState extends State<OrderViewPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<OrderCubit>(context).fetchOrders(widget.status);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocBuilder<OrderCubit, OrderState>(
              builder: (context, state) {
                if (state is OrderLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is OrderError) {
                  return Center(
                    child: Text(state.message),
                  );
                } else if (state is OrderHasData) {
                  return ListView.builder(
                      itemCount: state.orders.length,
                      itemBuilder: (context, index) {
                        return OrderList(order: state.orders[index]);
                      });
                } else {
                  return const Center(child: Text('Tidak ada transaksi'));
                }
              },
            )));
  }
}

class OrderList extends StatelessWidget {
  OrderList({Key? key, required this.order}) : super(key: key);

  final Orders order;
  final formatCurrency = NumberFormat.simpleCurrency(locale: 'id_ID');

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            detailOrderPageRoute,
            arguments: order.id,
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(formatDate(order.createdAt)),
                  OrderTypeWidget(
                    status: order.status,
                  )
                ],
              ),
              const Divider(),
              Row(
                children: [
                  CachedNetworkImage(
                    imageUrl:
                        '$baseUrl/images/${order.detailsOrder[0].products.photo}',
                    width: 100,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          order.detailsOrder[0].products.name,
                          style: kHeading6,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                            '${order.detailsOrder[0].quantity.toString()} barang',
                            style: kSubtitle2)
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 15),
              const Text('Total Belanja'),
              Text(formatCurrency.format(order.total),
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
