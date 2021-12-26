import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:localstore/localstore.dart';
import 'package:mvvm/Model/models/user.dart';
import 'package:mvvm/Model/models/wallet.dart';
import 'package:mvvm/Services/firebase_authentification.dart';

class Auth {
  final _db = Localstore.instance;
  User _user;
  User get getUsers => _user;

  User _userInfo(User info) {
    return info;
  }

  Stream<User> get userInfo {
    return Stream<User>.periodic(Duration(seconds: 1), (_) {
      getUser();
      return _user;
    }).map((event) => event);
  }

  void addToLocal(Map<String, dynamic> userinfo) {
    _db.collection("user").doc("currentUser").set(userinfo);
    print(_db.collection('user').doc("currentUser").get());
  }

  Future<String> token() async {
    final data = await _db.collection('user').doc("currentUser").get();
    if (data == null || data.isEmpty) return null;
    return data['token'];
  }

  Future<List<Wallet>> wallet() async {
    final data = await _db.collection('user').doc("currentUser").get();
    if (data == null || data.isEmpty) return null;
    var wallet = data['wallets'] as List;
    var walets = <Wallet>[];
    wallet.forEach((element) {
      walets.add(Wallet.fromJson(element));
    });
    return walets;
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
