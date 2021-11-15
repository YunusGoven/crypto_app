import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mvvm/View/widgets/wallet_widget.dart';
import 'package:mvvm/ViewModel/wallet_viewmodel.dart';

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
    super.initState();

    Timer.periodic(Duration(seconds: 15), (timer) {
      getWallets();
    });
  }

  getWallets() async {
    List<WalletViewModel> wallets = await _wvm.getWallets();
    _walletStreamController.sink.add(wallets);
  }

  @override
  void dispose() {
    _walletStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(top: 25, left: 20, right: 20, bottom: 25),
        child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: StreamBuilder(
              stream: _walletStreamController.stream,
              builder: (context, snapdata) {
                switch (snapdata.connectionState) {
                  case ConnectionState.waiting:
                    return Center(
                      child: CircularProgressIndicator(),
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
            )),
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
