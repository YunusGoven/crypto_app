//connection
//register
//ranking
import 'package:mvvm/Model/models/crypto.dart';
import 'package:mvvm/Model/models/user.dart';
import 'package:mvvm/Model/models/wallet.dart';
import 'package:mvvm/Services/api_service.dart';
import 'package:mvvm/locator.dart';

class ClassementViewModel {
  final _api = locator<ApiService>();
  ClassementUser _user;

  String get pseudo => _user.pseudo;
  num get solde => _user.solde;

  Future<List<ClassementViewModel>> getClassement() async {
    List<ClassementUser> wallets = await _api.getRanking();

    List<ClassementViewModel> cr = <ClassementViewModel>[];
    for (var item in wallets) {
      ClassementViewModel w = ClassementViewModel();
      w._user = item;
      cr.add(w);
    }

    return cr;
  }
}
