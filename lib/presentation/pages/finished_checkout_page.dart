import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pilatusapp/presentation/cubit/bank_cubit.dart';
import 'package:pilatusapp/styles/text_styles.dart';
import 'package:pilatusapp/utils/routes.dart';

class FinishedCheckoutPage extends StatefulWidget {
  const FinishedCheckoutPage({Key? key, required this.orderId})
      : super(key: key);

  final int orderId;

  @override
  State<FinishedCheckoutPage> createState() => _FinishedCheckoutPageState();
}

class _FinishedCheckoutPageState extends State<FinishedCheckoutPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<BankCubit>(context).getBankAccount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/order_confirmed.svg",
              semanticsLabel: 'Order Confirmed',
              width: MediaQuery.of(context).size.width * 0.7,
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              "Order Berhasil",
              style: kHeading5,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, paymentPageRoute,
                      arguments: widget.orderId);
                },
                child: const Text("Kirim Bukti Pembayaran")),
            const SizedBox(
              height: 5,
            ),
            OutlinedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, mainPageRoute);
                },
                child: const Text("Belanja Lagi"))
          ],
        ),
      ),
    );
  }
}
