import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:hybunsinnes/widgets/cryptowidget.dart';

class HomePage extends StatefulWidget {
  final String username;
  final num solde;

  const HomePage({Key key, @required this.username, @required this.solde})
      : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 5,
                ),
                Text("Solde disponible : "),
                Text("${widget.solde} \$"),
                SizedBox(
                  width: 5,
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            CryptoWidget(
              currentValue: 53397.85,
              imageurl:
                  "https://s3.us-east-2.amazonaws.com/nomics-api/static/images/currencies/btc.svg?url=https%3A%2F%2Fs3.us-east-2.amazonaws.com%2Fnomics-api%2Fstatic%2Fimages%2Fcurrencies%2Fbtc.svg&w=48&q=75",
              name: "BITCOIN",
              percent: 0.96,
            ),
            CryptoWidget(
              currentValue: 4316.36,
              imageurl:
                  "https://s3.us-east-2.amazonaws.com/nomics-api/static/images/currencies/eth.svg?url=https%3A%2F%2Fs3.us-east-2.amazonaws.com%2Fnomics-api%2Fstatic%2Fimages%2Fcurrencies%2Feth.svg&w=48&q=75",
              name: "ETHERUM",
              percent: -1.37,
            )
          ],
        ),
      ),
    );
  }
}
