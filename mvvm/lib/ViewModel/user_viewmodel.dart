//connection
//register
//ranking
import 'package:mvvm/Model/models/crypto.dart';
import 'package:mvvm/Model/models/user.dart';
import 'package:mvvm/Model/models/wallet.dart';
import 'package:mvvm/Services/api_service.dart';

class RankingViewModel {
  RankingViewModel();
  ClassementUser _user;

  String get pseudo => _user.pseudo;
  num get solde => _user.solde;

  Future<List<RankingViewModel>> getClassement() async {
    List<ClassementUser> wallets = await ApiService().getRanking();

    var cr = <RankingViewModel>[];
    for (var item in wallets) {
      RankingViewModel w = RankingViewModel();
      w._user = item;
      cr.add(w);
    }

    return cr;
  }
}
