import 'package:flutter/material.dart';
import 'package:mvvm/Model/models/wallet.dart';
import 'package:mvvm/Routing/route_names.dart';
import 'package:mvvm/Services/navigation_service.dart';
import 'package:mvvm/View/components/image_widget.dart';
import 'package:mvvm/View/pages/detail_page.dart';
import 'package:mvvm/ViewModel/wallet_viewmodel.dart';
import 'package:mvvm/locator.dart';
import 'package:stacked/stacked.dart';

class WalletWidgetHome extends StatelessWidget {
  final List<Wallet> wallets;
  const WalletWidgetHome({Key key, this.wallets}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WalletViewModel>.reactive(
        viewModelBuilder: () => WalletViewModel(),
        builder: (context, model, child) => SingleChildScrollView(
              child: Row(
                children: <Widget>[
                  ...wallets
                      .asMap()
                      .map((index, wallet) => MapEntry(
                            index,
                            GestureDetector(
                                child: Container(
                                  child: Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                              height: 10,
                                            ),
                                            LogoImage(image: wallet.imageUrl),
                                            Text(wallet.name),
                                          ],
                                        ),
                                        Text(
                                            "${wallet.number} ${wallet.cryptoId}")
                                      ],
                                    ),
                                  ),
                                ),
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
