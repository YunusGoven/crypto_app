import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mvvm/Services/userinfo_service.dart';
import 'package:mvvm/View/widgets/crypto_list_widget.dart';
import 'package:mvvm/View/widgets/home_wallet_widget.dart';
import 'package:mvvm/ViewModel/crypto_viewmodel.dart';
import 'package:mvvm/ViewModel/wallet_viewmodel.dart';
import 'package:mvvm/locator.dart';
import 'package:stacked/stacked.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final auth = locator<Auth>();
  bool isAuth = false;
  @override
  void initState() {
    super.initState();
    getAuth();
  }

  getAuth() async {
    isAuth = await auth.isAuthenticate();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CryptoViewModel>.reactive(
      viewModelBuilder: () => CryptoViewModel(),
      onModelReady: (model) => model.getAllCryptos(15),
      builder: (context, model, child) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              if (isAuth) HomeWalletWidget(),
              Text(
                "Cryptomonnaie",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              SizedBox(
                height: 20,
              ),
              model.cryptos == null
                  ? const CircularProgressIndicator()
                  : CryptoListWidget(cryptos: model.cryptos)
            ],
          ),
        ),
      ),
    );
  }
}
