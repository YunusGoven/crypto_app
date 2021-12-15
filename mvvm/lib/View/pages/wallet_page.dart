import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mvvm/Routing/route_names.dart';
import 'package:mvvm/Services/navigation_service.dart';
import 'package:mvvm/Services/userinfo_service.dart';
import 'package:mvvm/View/widgets/wallet_widget.dart';
import 'package:mvvm/ViewModel/wallet_viewmodel.dart';
import 'package:mvvm/locator.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({Key key}) : super(key: key);

  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  final StreamController<List<WalletViewModel>> _walletStreamController =
      StreamController();
  final WalletViewModel _wvm = WalletViewModel();

  @override
  void initState() {
    verifyIsConnected();
    super.initState();
  }

  verifyIsConnected() async {
    var isAuth = await locator<Auth>().isAuthenticate();
    if (!isAuth) {
      dispose();
      locator<NavigationService>().navigateTo(HomeRoute);
    } else {
      getWallets();
      Timer.periodic(Duration(seconds: 35), (timer) {
        if (!_walletStreamController.isClosed) {
          getWallets();
        } else {
          timer.cancel();
        }
      });
    }
  }

  getWallets() async {
    List<WalletViewModel> wallets = await _wvm.getWallets();
    if (!_walletStreamController.isClosed) {
      _walletStreamController.sink.add(wallets);
    }
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    _walletStreamController.close();
  }

  @override
  void dispose() {
    super.dispose();
    _walletStreamController.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 25, left: 20, right: 20, bottom: 25),
          child: StreamBuilder(
            stream: _walletStreamController.stream,
            builder: (context, snapdata) {
              switch (snapdata.connectionState) {
                case ConnectionState.waiting:
                  return Center(
                    child: LinearProgressIndicator(),
                  );
                default:
                  if (snapdata.hasError) {
                    return Text("Attend frere");
                  } else {
                    return Column(
                      children: createWidget(snapdata.data),
                    );
                  }
              }
            },
          ),
        ),
      ),
    );
  }

  createWidget(List<WalletViewModel> data) {
    var walletlist = <Widget>[];
    data.forEach((element) {
      var widget = WalletWidget(walletViewModel: element);
      walletlist.add(widget);
      var divider =
          Divider(color: Colors.black, indent: 10, endIndent: 10, thickness: 5);
      walletlist.add(divider);
    });
    if (walletlist.isNotEmpty) walletlist.removeLast();

    return walletlist;
  }
}
