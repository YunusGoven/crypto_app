//all
//detail
//home
import 'package:flutter/cupertino.dart';
import 'package:mvvm/Model/models/crypto.dart';
import 'package:mvvm/Model/repository/api_services.dart';

class CrytoViewModel {
  final Crypto crypto;

  CrytoViewModel(this.crypto);

  Crypto get getCrypto => crypto;
}

class CryptoListViewModel extends ChangeNotifier {
  List<CrytoViewModel> cryptos = List.empty();
  CrytoViewModel crypto = null;

  Future<void> getAllCryptos() async {
    final results = await ApiService().getAllCryptos();
    cryptos = results.map((item) => CrytoViewModel(item)).toList();
    notifyListeners();
  }

  Future<void> getCryptos(String cryptoId) async {
    final results = await ApiService().getCrypto(cryptoId);
    crypto = CrytoViewModel(results);
    notifyListeners();
  }
}
