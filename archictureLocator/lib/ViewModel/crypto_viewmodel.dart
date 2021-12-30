import 'package:flutter/material.dart';
import 'package:mvvm/Model/crypto.dart';
import 'package:mvvm/Routing/route_names.dart';
import 'package:mvvm/Services/api_service.dart';
import 'package:mvvm/Services/navigation_service.dart';
import 'package:mvvm/locator.dart';

class CryptoViewModel extends ChangeNotifier {
  final _api = locator<ApiService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Crypto _crypto;
  List<Crypto> _cryptos;

  Crypto get crypto => _crypto;
  List<Crypto> get cryptos => _cryptos;

  Future getAllCryptos(int number) async {
    var results = await _api.getAllCryptos(number);
    if (results is String) {
    } else {
      _cryptos = results;
    }

    notifyListeners();
  }

  //detail
  Future getCrypto(String cryptoId) async {
    var results = await _api.getCrypto(cryptoId);
    if (results is String) {
    } else {
      _crypto = results;
    }

    notifyListeners();
  }

  void navigateToCrypto(String id) {
    _navigationService
        .navigateTo(CryptoDetailsRoute, queryParams: {'cryptoId': id});
  }
}
