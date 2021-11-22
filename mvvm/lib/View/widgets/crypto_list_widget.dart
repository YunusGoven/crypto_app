import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mvvm/ViewModel/crypto_viewmodel.dart';

import 'crypto_widget.dart';

class CryptoListWidget extends StatelessWidget {
  final StreamController<List<CryptoViewModel>> cryptoController;
  const CryptoListWidget({Key key, @required this.cryptoController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: cryptoController.stream,
      builder: (context, snapdata) {
        switch (snapdata.connectionState) {
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(),
            );
          default:
            if (snapdata.hasError) {
              return Text("Attend frere");
            } else {
              return Column(
                children: createCryptoListWidget(snapdata.data),
              );
            }
        }
      },
    );
  }

  createCryptoListWidget(List<CryptoViewModel> data) {
    var cryptoWidget = <Widget>[];
    data.forEach((crypto) {
      var widget = CryptoWidget(crypto: crypto);
      cryptoWidget.add(widget);
      var divider =
          Divider(color: Colors.black, indent: 10, endIndent: 10, thickness: 5);
      cryptoWidget.add(divider);
    });
    if (cryptoWidget.isNotEmpty) cryptoWidget.removeLast();

    return cryptoWidget;
  }
}
