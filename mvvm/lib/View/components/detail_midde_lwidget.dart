import 'package:flutter/material.dart';
import 'package:mvvm/View/components/detail_perday_widget.dart';

import 'package:mvvm/ViewModel/crypto_viewmodel.dart';

class DetailMiddle extends StatefulWidget {
  final CryptoViewModel crypto;
  const DetailMiddle({Key key, this.crypto}) : super(key: key);

  @override
  _DetailMiddleState createState() => _DetailMiddleState();
}

class _DetailMiddleState extends State<DetailMiddle> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          DetailPerDay(
            currentPirce: widget.crypto.Price,
            day: "30d",
            price: widget.crypto.D30Price,
          ),
          DetailPerDay(
            currentPirce: widget.crypto.Price,
            day: "7d",
            price: widget.crypto.D7Price,
          ),
          DetailPerDay(
            currentPirce: widget.crypto.Price,
            day: "1d",
            price: widget.crypto.D1Price,
          ),
          DetailPerDay(
            currentPirce: widget.crypto.Price,
            day: "1h",
            price: widget.crypto.H1Price,
          ),
        ],
      ),
    );
  }
}
