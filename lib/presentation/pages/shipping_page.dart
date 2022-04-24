import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pilatusapp/presentation/cubit/shipping_cubit.dart';

class ShippingPage extends StatefulWidget {
  const ShippingPage(
      {Key? key,
      required this.origin,
      required this.destination,
      required this.weight})
      : super(key: key);

  final int origin;
  final int destination;
  final int weight;

  @override
  State<ShippingPage> createState() => _ShippingPageState();
}

class _ShippingPageState extends State<ShippingPage> {
  late List<DropdownMenuItem<String>> costsMenuItem = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ShippingCubit>(context)
        .fetchCost(widget.origin, widget.destination, widget.weight);
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pilih Jasa Pengiriman',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            BlocBuilder<ShippingCubit, ShippingState>(
                builder: (context, state) {
              if (state is ShippingLoading) {
                return const Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                );
              } else if (state is ShippingHasData) {
                final costs = state.costs;
                costsMenuItem = List.generate(
                  state.costs.length,
                  (index) => DropdownMenuItem(
                      child: Text(
                          "${costs[index].service} - ${costs[index].costs[0].value} (${costs[index].costs[0].etd} hari)"),
                      value:
                          "${costs[index].costs[0].value.toString()}-${costs[index].service}"),
                );
              }

              return DropdownButtonFormField(
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Pastikan data terisi dengan benar';
                  }
                  return null;
                },
                value: state is ShippingOnChanged ? state.selectedValue : null,
                items: costsMenuItem,
                onChanged: (String? newValue) {
                  BlocProvider.of<ShippingCubit>(context)
                      .costOnChanged(newValue!);

                  Navigator.pop(context, {
                    "cost": int.parse(seperateString(newValue)[0]),
                    "service": seperateString(newValue)[1]
                  });
                },
              );
            }),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }

  List<String> seperateString(value) {
    return value.split('-');
  }
}
