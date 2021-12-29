import 'package:flutter/material.dart';
import 'package:mvvm/Model/models/wallet.dart';
import 'package:mvvm/Routing/route_names.dart';
import 'package:mvvm/Services/navigation_service.dart';
import 'package:mvvm/View/widgets/wallet_widget_home.dart';
import 'package:mvvm/ViewModel/wallet_viewmodel.dart';
import 'package:mvvm/locator.dart';
import 'package:stacked/stacked.dart';

class WalletListWidgetHome extends StatelessWidget {
  final List<Wallet> wallets;
  const WalletListWidgetHome({Key key, this.wallets}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WalletViewModel>.reactive(
        disposeViewModel: false,
        viewModelBuilder: () => WalletViewModel(),
        builder: (context, model, child) => SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Wrap(
                spacing: 30,
                runSpacing: 30,
                children: <Widget>[
                  ...wallets
                      .asMap()
                      .map((index, wallet) => MapEntry(
                            index,
                            GestureDetector(
                                child: WalletWidgetHome(model: wallet),
                                onTap: () {
                                  locator<NavigationService>().navigateTo(
                                      CryptoDetailsRoute,
                                      queryParams: {
                                        'cryptoId': wallet.cryptoId
                                      });
                                }),
                          ))
                      .values
                      .toList()
                ],
              ),
            ));
  }
}
