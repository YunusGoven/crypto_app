import 'package:flutter/material.dart';
import 'package:mvvm/View/widgets/wallet_widget_home.dart';
import 'package:mvvm/ViewModel/wallet_viewmodel.dart';
import 'package:stacked/stacked.dart';

class HomeWalletWidget extends StatelessWidget {
  const HomeWalletWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WalletViewModel>.reactive(
      viewModelBuilder: () => WalletViewModel(),
      onModelReady: (model) => model.getWallets(),
      builder: (context, model, child) => SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          const Text(
            "Vos cryptos",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(
            height: 10,
          ),
          model.wallets == null
              ? const CircularProgressIndicator()
              : WalletWidgetHome(wallets: model.wallets),
        ],
      )),
    );
  }
}
