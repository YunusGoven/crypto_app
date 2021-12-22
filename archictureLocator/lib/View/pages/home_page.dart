import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mvvm/Routing/route_names.dart';
import 'package:mvvm/Services/navigation_service.dart';
import 'package:mvvm/Services/userinfo_service.dart';
import 'package:mvvm/View/widgets/crypto_list_widget.dart';
import 'package:mvvm/View/widgets/home_wallet_widget.dart';
import 'package:mvvm/View/widgets/welcome_message_widget.dart';
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

  getAuth() {
    auth.isAuthenticate().then((value) {
      if (value) {
        isAuth = value;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CryptoViewModel>.reactive(
      viewModelBuilder: () => CryptoViewModel(),
      onModelReady: (model) => model.getAllCryptos(4),
      builder: (context, model, child) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isAuth) HomeWalletWidget(),
              if (kIsWeb && !isAuth) WelcomeMessage(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Top Cryptomonnaie",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  TextButton.icon(
                      onPressed: () {
                        locator<NavigationService>().navigateTo(CryptosRoute);
                      },
                      label: Text("Plus"),
                      icon: Icon(Icons.add_circle_rounded))
                ],
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
