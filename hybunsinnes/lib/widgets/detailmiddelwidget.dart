import 'package:flutter/material.dart';
import 'package:hybunsinnes/model/crypto.dart';

class DetailMiddle extends StatefulWidget {
  final Crypto crypto;
  const DetailMiddle({Key key, this.crypto}) : super(key: key);

  @override
  _DetailMiddleState createState() => _DetailMiddleState();
}

class _DetailMiddleState extends State<DetailMiddle> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                "30d",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text("${widget.crypto.d30}"),
            ],
          ),
          Column(
            children: [
              Text(
                "7d",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text("${widget.crypto.d7}"),
            ],
          ),
          Column(
            children: [
              Text(
                "24h",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text("${widget.crypto.d1}"),
            ],
          ),
          Column(
            children: [
              Text(
                "1h",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text("${widget.crypto.h1}"),
            ],
          ),
        ],
      ),
    );
  }
}
