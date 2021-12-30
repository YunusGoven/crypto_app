import 'package:flutter/material.dart';
import 'package:mvvm/Model/crypto.dart';
import 'package:mvvm/View/widgets/crypto_widget.dart';
import 'package:mvvm/ViewModel/crypto_viewmodel.dart';
import 'package:stacked/stacked.dart';

class CryptoListHomeWidget extends StatelessWidget {
  final List<Crypto> cryptos;
  const CryptoListHomeWidget({Key key, this.cryptos}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CryptoViewModel>.reactive(
      viewModelBuilder: () => CryptoViewModel(),
      disposeViewModel: false,
      builder: (context, model, child) => Wrap(
        spacing: 30,
        runSpacing: 30,
        children: <Widget>[
          ...cryptos
              .asMap()
              .map((index, crypto) => MapEntry(
                    index,
                    GestureDetector(
                        child: CryptoWidget(model: crypto),
                        onTap: () => model.navigateToCrypto(crypto.Id)),
                  ))
              .values
              .toList()
        ],
      ),
    );
  }
}
