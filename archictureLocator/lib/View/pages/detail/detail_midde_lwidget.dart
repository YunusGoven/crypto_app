import 'package:flutter/material.dart';
import 'package:mvvm/Model/crypto.dart';
import 'package:mvvm/View/pages/detail/detail_perday_widget.dart';

class DetailMiddle extends StatefulWidget {
  final Crypto crypto;
  const DetailMiddle({Key key, this.crypto}) : super(key: key);

  @override
  _DetailMiddleState createState() => _DetailMiddleState();
}

class _DetailMiddleState extends State<DetailMiddle> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        DetailPerDay(
          day: "30d",
          price: widget.crypto.Price + widget.crypto.D30Price,
          currentPrice: widget.crypto.Price,
        ),
        DetailPerDay(
          day: "7d",
          price: widget.crypto.Price + widget.crypto.D7Price,
          currentPrice: widget.crypto.Price,
        ),
        DetailPerDay(
          day: "1d",
          price: widget.crypto.Price + widget.crypto.D1Price,
          currentPrice: widget.crypto.Price,
        ),
        DetailPerDay(
          day: "1h",
          price: widget.crypto.Price + widget.crypto.H1Price,
          currentPrice: widget.crypto.Price,
        ),
      ],
    );
  }
}
