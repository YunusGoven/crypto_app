import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mvvm/Routing/route_names.dart';
import 'package:mvvm/Services/navigation_service.dart';
import 'package:mvvm/Services/userinfo_service.dart';
import 'package:mvvm/View/widgets/wallet_widget.dart';
import 'package:mvvm/ViewModel/wallet_viewmodel.dart';
import 'package:mvvm/locator.dart';
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
              if (model.wallets == null) LinearProgressIndicator(),
              if (model.wallets != null)
                ...model.wallets
                    .asMap()
                    .map((index, wallet) => MapEntry(
                          index,
                          Container(
                            child: WalletWidget(
                              model: wallet,
                              walletViewModel: model,
                            ),
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
