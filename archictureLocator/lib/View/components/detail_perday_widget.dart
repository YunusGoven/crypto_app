import 'package:flutter/material.dart';

class DetailPerDay extends StatelessWidget {
  final String day;
  final num price;
  const DetailPerDay({Key key, this.day, this.price}) : super(key: key);

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
          price.toStringAsFixed(3),
          style: TextStyle(
            color: price < 0 ? Colors.red : Colors.green,
          ),
        ),
      ],
    );
  }
}
