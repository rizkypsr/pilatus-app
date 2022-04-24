import 'package:flutter/material.dart';
import 'package:pilatusapp/common/enums.dart';
import 'package:pilatusapp/styles/text_styles.dart';
import 'package:pilatusapp/utils/helpers.dart';

class OrderTypeWidget extends StatelessWidget {
  const OrderTypeWidget({Key? key, required this.status}) : super(key: key);

  final String status;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: getOrderTypeColor(status),
      padding: const EdgeInsets.all(5),
      child: Text(formatOrderType(status),
          style: kSubtitle2.copyWith(fontWeight: FontWeight.bold)),
    );
  }
}

Color getOrderTypeColor(String status) {
  switch (status) {
    case "unpaid":
      return Colors.red.shade200;
    case "processed":
      return Colors.blue.shade100;
    case "finished":
      return Colors.green.shade200;
    case "cancelled":
      return Colors.black12;
    default:
      return Colors.green;
  }
}
