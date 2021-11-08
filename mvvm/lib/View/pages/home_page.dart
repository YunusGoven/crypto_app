import 'package:flutter/material.dart';
import 'package:mvvm/View/widgets/crypto_widget.dart';
import 'package:mvvm/ViewModel/crypto_viewmodel.dart';
import 'package:provider/provider.dart';

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
  void initState() {
    super.initState();
    Provider.of<CryptoListViewModel>(context, listen: false).getAllCryptos();
  }

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
            Column(
              children: createWidget(),
            )
          ],
        ),
      ),
    );
  }

  createWidget() {
    final vm = Provider.of<CryptoListViewModel>(context);
    var cryptoWidget = <Widget>[];
    vm.cryptos.forEach((crypto) {
      var widget = CryptoWidget(crypto: crypto);
      cryptoWidget.add(widget);
      var divider =
          Divider(color: Colors.black, indent: 10, endIndent: 10, thickness: 5);
      cryptoWidget.add(divider);
    });
    if (!cryptoWidget.isEmpty) cryptoWidget.removeLast();

    return cryptoWidget;
  }
}
