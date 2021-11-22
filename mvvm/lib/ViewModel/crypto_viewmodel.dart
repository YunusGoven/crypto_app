import 'package:mvvm/Model/models/crypto.dart';
import 'package:mvvm/Model/repository/api_services.dart';

class CryptoViewModel {
  Crypto _crypto;

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

  //all  //home
  Future<List<CryptoViewModel>> getAllCryptos(int number) async {
    final List<Crypto> results = await ApiService().getAllCryptos(number);

    var cr = List<CryptoViewModel>();
    for (var item in results) {
      CryptoViewModel c = CryptoViewModel();
      c._crypto = item;
      cr.add(c);
    }
    cr.removeRange(cr.length - number, cr.length);
    return cr;
  }

  //detail
  Future<CryptoViewModel> getCrypto(String cryptoId) async {
    final results = await ApiService().getCrypto(cryptoId);
    _crypto = results;
    return this;
  }
}
