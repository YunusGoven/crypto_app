import 'package:mvvm/Model/models/crypto.dart';
import 'package:mvvm/Services/api_service.dart';
import 'package:mvvm/locator.dart';

class CryptoViewModel {
  Crypto _crypto;
  final _api = locator<ApiService>();
  CryptoViewModel();

  String get Id => _crypto.Id;
  String get Symbole => _crypto.Symbole;
  String get Name => _crypto.Name;
  num get Price => _crypto.Price;
  String get PriceDate => _crypto.PriceDate;
  String get LogoUrl => _crypto.LogoUrl;
  num get Percent => _crypto.Percent;
  Map<String, dynamic> get History => _crypto.HistoryValue;
  num get H1Price => _crypto.H1Price;
  num get D1Price => _crypto.D1Price;
  num get D7Price => _crypto.D7Price;
  num get D30Price => _crypto.D30Price;

  Future<List<CryptoViewModel>> getAllCryptos(int number) async {
    final List<Crypto> results = await _api.getAllCryptos(number);
    if (results == null) return null;
    List<CryptoViewModel> cr = <CryptoViewModel>[];
    for (var item in results) {
      CryptoViewModel c = CryptoViewModel();
      c._crypto = item;
      cr.add(c);
    }
    return cr;
  }

  //detail
  Future<CryptoViewModel> getCrypto(String cryptoId) async {
    final results = await _api.getCrypto(cryptoId);
    _crypto = results;
    return this;
  }
}
