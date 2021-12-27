import 'package:flutter/material.dart';
import 'package:mvvm/View/widgets/wallet_widget.dart';
import 'package:mvvm/ViewModel/wallet_viewmodel.dart';
import 'package:stacked/stacked.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({Key key}) : super(key: key);

  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WalletViewModel>.reactive(
      viewModelBuilder: () => WalletViewModel(),
      onModelReady: (model) => model.getWallets(),
      builder: (context, model, child) => SingleChildScrollView(
        child: Center(
          child: Wrap(
            spacing: 30,
            runSpacing: 30,
            children: <Widget>[
              const Text(
                "Vos cryptos",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(
                height: 10,
              ),
              if (model.wallets == null) const LinearProgressIndicator(),
              if (model.wallets != null)
                ...model.wallets
                    .asMap()
                    .map((index, wallet) => MapEntry(
                          index,
                          WalletWidget(
                            model: wallet,
                            walletViewModel: model,
                          ),
                        ))
                    .values
                    .toList()
            ],
          ),
        ),
      ),
    );
  }
}
