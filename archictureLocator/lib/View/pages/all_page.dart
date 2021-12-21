import 'package:flutter/material.dart';
import 'package:mvvm/View/widgets/crypto_list_widget.dart';
import 'package:mvvm/ViewModel/crypto_viewmodel.dart';
import 'package:stacked/stacked.dart';

class AllCryptoPage extends StatelessWidget {
  const AllCryptoPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CryptoViewModel>.reactive(
      viewModelBuilder: () => CryptoViewModel(),
      onModelReady: (model) => model.getAllCryptos(15),
      builder: (context, model, child) => SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          // const SizedBox(
          //   height: 100,
          // ),
          model.cryptos == null
              ? const CircularProgressIndicator()
              : CryptoListWidget(cryptos: model.cryptos),
        ],
      )),
    );
  }
}
