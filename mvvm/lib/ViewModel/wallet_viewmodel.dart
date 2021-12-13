import 'package:mvvm/Model/models/crypto.dart';
import 'package:mvvm/Model/models/wallet.dart';
import 'package:mvvm/Services/api_service.dart';
import 'package:mvvm/locator.dart';

class WalletViewModel {
  final _api = locator<ApiService>();
  Wallet _wallet;

  String get Imageurl => _wallet.imageUrl;
  String get Number => _wallet.number;
  String get Cryptoid => _wallet.cryptoId;
  bool get NoticationActivated => _wallet.notifiactionActivated;
  void NotificationActivated(bool active) => _wallet.nofitication = active;
  String get Name => _wallet.name;
  num get Percent => _wallet.percent;
  num get Total => _wallet.gainsPertesTotal;
  num get gainspertes => _wallet.gainsPertes;

  Future<List<WalletViewModel>> getWallets() async {
    List<Wallet> wallets = await _api.getWallet();
    if (wallets == null) return null;
    List<WalletViewModel> cr = <WalletViewModel>[];
    for (var item in wallets) {
      WalletViewModel w = WalletViewModel();
      w._wallet = item;
      cr.add(w);
    }

    return cr;
  }

  Future<bool> disableNotification(String cryptoId) async {
    return await _api.disableNotification(cryptoId);
  }
}
