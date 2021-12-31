import 'package:flutter/material.dart';

class DetailPerDay extends StatelessWidget {
  final String day;
  final num price;
  final num currentPrice;
  const DetailPerDay({Key key, this.day, this.price, this.currentPrice})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          day,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          price.toStringAsFixed(5),
          style: TextStyle(
            color: price < currentPrice ? Colors.red : Colors.green,
          ),
        ),
      ],
    );
  }
}
