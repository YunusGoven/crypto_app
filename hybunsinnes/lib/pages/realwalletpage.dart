import 'package:flutter/material.dart';
import 'package:hybunsinnes/model/wallet.dart';
import 'package:hybunsinnes/widgets/walletwidget.dart';

class WalletPage extends StatefulWidget {
  final List<Wallet> wallets;
  const WalletPage({Key key, this.wallets}) : super(key: key);

  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(top: 25, left: 20, right: 20, bottom: 25),
        child: Column(
          children: createWidget(),
        ),
      ),
    );
  }

  createWidget() {
    var userWidget = <Widget>[];
    widget.wallets.forEach((element) {
      var wi = WalletWidget(
        wallet: element,
      );
      userWidget.add(wi);
      var divider =
          Divider(color: Colors.black, indent: 10, endIndent: 10, thickness: 5);
      userWidget.add(divider);
    });
    userWidget.removeLast();
    return userWidget;
  }
}
