import 'package:flutter/material.dart';
import 'package:mvvm/Model/models/wallet.dart';
import 'package:mvvm/Services/api_service.dart';
import 'package:mvvm/locator.dart';

class WalletViewModel extends ChangeNotifier {
  final _api = locator<ApiService>();

  List<Wallet> _wallets;

  List<Wallet> get wallets => _wallets;

  Future getWallets() async {
    var wallets = await _api.getWallet();
    if (wallets == null) {
    } else {
      _wallets = wallets;
    }

    notifyListeners();
  }

  Future<bool> disableNotification(String cryptoId) async {
    return (await _api.disableNotification(cryptoId)).code == 200;
  }
}
