import 'package:mvvm/Model/models/crypto.dart';
import 'package:mvvm/Model/models/wallet.dart';
import 'package:mvvm/Model/repository/api_services.dart';

class WalletViewModel {
  WalletViewModel();
  Wallet _wallet;

  String get Imageurl => _wallet.imageUrl;
  num get Number => _wallet.number;
  String get Cryptoid => _wallet.cryptoId;
  bool get NoticationActivated => _wallet.notifiactionActivated;
  void NotificationActivated(bool active) => _wallet.nofitication = active;
  String get Name => _wallet.name;
  num get Percent => _wallet.percent;
  num get Total => _wallet.gainsPertesTotal;
  num get gainspertes => _wallet.gainsPertes;

  Future<List<WalletViewModel>> getWallets() async {
    List<Wallet> wallets = await ApiService().getWallet();

    var cr = List<WalletViewModel>();
    for (var item in wallets) {
      WalletViewModel w = WalletViewModel();
      w._wallet = item;
      cr.add(w);
    }

    return cr;
  }
}
