import 'package:flutter/material.dart';

class DetailPerDay extends StatelessWidget {
  final String day;
  final num price;
  final num currentPirce;
  const DetailPerDay({Key key, this.day, this.price, this.currentPirce})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var priceadd = price + currentPirce;
    return Column(
      children: [
        Text(
          day,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "${priceadd.toStringAsFixed(3)}",
          style: TextStyle(
            color: priceadd < currentPirce ? Colors.red : Colors.green,
          ),
        ),
      ],
    );
  }
}
