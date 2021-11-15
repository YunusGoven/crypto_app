//connection
//register
//ranking
import 'package:mvvm/Model/models/crypto.dart';
import 'package:mvvm/Model/models/user.dart';
import 'package:mvvm/Model/models/wallet.dart';
import 'package:mvvm/Model/repository/api_services.dart';

class ClassementViewModel {
  ClassementViewModel();
  ClassementUser _user;

  String get pseudo => _user.pseudo;
  num get solde => _user.solde;

  Future<List<ClassementViewModel>> getClassement() async {
    List<ClassementUser> wallets = await ApiService().getRanking();

    var cr = List<ClassementViewModel>();
    for (var item in wallets) {
      ClassementViewModel w = ClassementViewModel();
      w._user = item;
      cr.add(w);
    }

    return cr;
  }
}
