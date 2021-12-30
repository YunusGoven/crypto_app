import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mvvm/Model/user.dart';
import 'package:mvvm/Routing/route_names.dart';
import 'package:mvvm/Services/navigation_service.dart';
import 'package:mvvm/Services/userinfo_service.dart';
import 'package:mvvm/View/pages/accueil/crypto_list_home_widget.dart';
import 'package:mvvm/View/pages/accueil/welcome_message_widget.dart';
import 'package:mvvm/View/pages/accueil/home_wallet_widget.dart';
import 'package:mvvm/ViewModel/crypto_viewmodel.dart';
import 'package:mvvm/locator.dart';

import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    asyncMethod();
  }

  void asyncMethod() async {
    var isCo = await locator<Auth>().isAuthenticate();
    if (!kIsWeb && !isCo) {
      locator<NavigationService>().navigateTo(LoginRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    final user = Provider.of<User>(context);
    var isAuth = user != null;

    return ViewModelBuilder<CryptoViewModel>.reactive(
      viewModelBuilder: () => CryptoViewModel(),
      onModelReady: (model) => model.getAllCryptos(4),
      disposeViewModel: false,
      builder: (context, model, child) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isAuth) const HomeWalletWidget(),
              if (kIsWeb && !isAuth) const WelcomeMessage(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Top Cryptomonnaie",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  TextButton.icon(
                      onPressed: () {
                        locator<NavigationService>().navigateTo(CryptosRoute);
                      },
                      label: size > 460 ? const Text("Plus") : const Text(""),
                      icon: const Icon(Icons.add_circle_rounded))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              model.cryptos == null
                  ? const CircularProgressIndicator()
                  : CryptoListHomeWidget(cryptos: model.cryptos)
            ],
          ),
        ),
      ),
    );
  }
}
