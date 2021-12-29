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
      onModelReady: (model) => model.getAllCryptos(-1),
      disposeViewModel: false,
      builder: (context, model, child) => SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          model.cryptos == null
              ? const LinearProgressIndicator()
              : CryptoListWidget(cryptos: model.cryptos),
        ],
      )),
    );
  }
}
