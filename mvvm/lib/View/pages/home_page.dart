import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mvvm/Services/userinfo_service.dart';
import 'package:mvvm/View/widgets/crypto_list_widget.dart';
import 'package:mvvm/View/widgets/home_wallet_widget.dart';
import 'package:mvvm/ViewModel/crypto_viewmodel.dart';
import 'package:mvvm/ViewModel/wallet_viewmodel.dart';
import 'package:mvvm/locator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final StreamController<List<CryptoViewModel>> _cryptoStreamController =
      StreamController();
  final StreamController<List<WalletViewModel>> _walletStreamController =
      StreamController();
  final CryptoViewModel _cvm = CryptoViewModel();
  final WalletViewModel _wvm = WalletViewModel();
  final auth = locator<Auth>();
  bool isAuth = false;
  @override
  void initState() {
    super.initState();
    getWallets();
    Timer.periodic(Duration(seconds: 10), (timer) {
      done();
    });
  }

  getWallets() async {
    isAuth = await auth.isAuthenticate();
    if (isAuth) {
      List<WalletViewModel> wallets = await _wvm.getWallets();
      if (!_walletStreamController.isClosed) {
        _walletStreamController.sink.add(wallets);
      }
    }
  }

  done() async {
    List<CryptoViewModel> cr = await _cvm.getAllCryptos(6);
    if (!_cryptoStreamController.isClosed) {
      _cryptoStreamController.sink.add(cr);
    }
  }

  @override
  void dispose() {
    print("DISPOSSEEEE");
    _cryptoStreamController.close();
    _walletStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              if (isAuth) showOwnedCrypto(),
              Text(
                "Cryptomonnaie",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              SizedBox(
                height: 20,
              ),
              CryptoListWidget(cryptoController: _cryptoStreamController)
            ],
          ),
        ),
      ),
    );
  }

  createWalletListWidget(List<WalletViewModel> data) {
    var walletlist = <Widget>[];
    data.forEach((element) {
      var widget = HomeWalletWidget(walletViewModel: element);
      walletlist.add(widget);
      var divider =
          Divider(color: Colors.black, indent: 10, endIndent: 10, thickness: 5);
      walletlist.add(divider);
    });
    if (walletlist.isNotEmpty) walletlist.removeLast();

    return walletlist;
  }

  showOwnedCrypto() {
    return Column(
      children: [
        Text(
          "Vos cryptos",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(
          height: 10,
        ),
        SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: StreamBuilder(
              stream: _walletStreamController.stream,
              builder: (context, snapdata) {
                switch (snapdata.connectionState) {
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    print("waiting");
                    return CircularProgressIndicator(
                      color: Colors.red,
                    );
                  default:
                    if (snapdata.hasError) {
                      print("erreur");
                      return Center(child: Text(snapdata.error));
                    } else {
                      if (!snapdata.hasData) {
                        print("pas de donnée");
                        return Center(
                          child: Text("Aucune donnée n'a été trouvé"),
                        );
                      } else {
                        return Row(
                          children: createWalletListWidget(snapdata.data),
                        );
                      }
                    }
                }
              },
            )),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
