import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:localstore/localstore.dart';
import 'package:mvvm/Model/models/user.dart';
import 'package:mvvm/Model/models/wallet.dart';
import 'package:mvvm/Services/firebase_authentification.dart';

class Auth {
  final _db = Localstore.instance;
  User _user;
  User get getUsers => _user;

  void setUserSolde(num updating) {
    _user.setSolde = updating;
  }

  num get getUserSolde => _user.solde;

  Stream<User> get userInfo {
    return Stream<User>.periodic(const Duration(seconds: 1), (_) {
      getUser();
      return _user;
    }).map((event) => event);
  }

  void addToLocal(Map<String, dynamic> userinfo) {
    _db.collection("user").doc("currentUser").set(userinfo);
  }

  Future<String> token() async {
    final data = await _db.collection('user').doc("currentUser").get();
    if (data == null || data.isEmpty) return null;
    return data['token'];
  }

  Future<List<dynamic>> wallet() async {
    final data = await _db.collection('user').doc("currentUser").get();
    if (data == null || data.isEmpty) return null;
    var wallet = data['wallets'];
    var walets = wallet.map((e) {
      var w = ConnectedWallet.fromJson(e);
      return w;
    }).toList();

    return walets;
  }

  Future updateWallet(String cryptoId, num number) async {
    var wallets = await wallet();
    var currentNumber =
        wallets.firstWhere((element) => element.cryptoId == cryptoId).number;
    wallets.removeWhere((element) => element.cryptoId == cryptoId);
    num now = currentNumber - number;
    now = num.tryParse(now.toStringAsFixed(8));

    if (now > 0) {
      wallets.add(ConnectedWallet(number: now, cryptoId: cryptoId));
    }

    var tokenn = await token();
    print(tokenn);
    var valetModel = <ConnectedWallet>[];
    for (var item in wallets) {
      var i = item as ConnectedWallet;
      valetModel.add(i);
    }
    var user = ConnectedUser(tokenn, valetModel);
    addToLocal(user.toJson());
  }

  Future<ConnectedWallet> getThisWallet(String id) async {
    var wallets = await wallet();

    for (var wallet in wallets) {
      if (wallet.cryptoId == id) {
        return wallet;
      }
    }
    return null;
  }

  Future<bool> isAdmin() async {
    try {
      final data = _db.collection('user');
      if (data == null) {
        return false;
      }

      final data2 = await data.doc("currentUser").get();
      if (data2 == null || data2.isEmpty) {
        return false;
      }
      String token = data2['token'];
      var isAdmin = JwtDecoder.decode(token)['IsAdmin'];
      if (isAdmin == "True") {
        return true;
      }

      return false;
    } on Error {
      return false;
    }
  }

  Future<User> getUser() async {
    try {
      if (!await isAuthenticate()) {
        _user = null;
        return null;
      }
      if (_user != null) {
        return _user;
      }
      var usertoken = await token();
      String id = JwtDecoder.decode(usertoken)['UserId'];
      String firstname = JwtDecoder.decode(usertoken)['UserFirstName'];
      String surname = JwtDecoder.decode(usertoken)['UserSurname'];
      String username = JwtDecoder.decode(usertoken)['UserPseudo'];
      String email = JwtDecoder.decode(usertoken)['UserMail'];
      String soldeString = JwtDecoder.decode(usertoken)['UserSolde'];
      String admin = JwtDecoder.decode(usertoken)['IsAdmin'];
      var solde = num.tryParse(soldeString);
      var isAdmin = admin == "True";
      var user = User(id, firstname, surname, email, username, solde, isAdmin);
      _user = user;
      return user;
    } catch (ex) {
      print(ex.toString());
      return null;
    }
  }

  Future<bool> isAuthenticate() async {
    try {
      final data = _db.collection('user');
      if (data == null) {
        return false;
      }

      final data2 = await data.doc("currentUser").get();
      if (data2 == null || data2.isEmpty) {
        return false;
      }
      String token = data2['token'];
      if (JwtDecoder.isExpired(token)) {
        FirebaseAuthentification().signOut;
        disconnect();
        return false;
      }

      return true;
    } on Error {
      return false;
    }
  }

  void disconnect() {
    _db.collection('user').doc("currentUser").delete();
  }
}
