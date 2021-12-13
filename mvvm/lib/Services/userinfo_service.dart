import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:localstore/localstore.dart';
import 'package:mvvm/Model/models/user.dart';
import 'package:mvvm/Model/models/wallet.dart';

class Auth {
  final _db = Localstore.instance;

  void addToLocal(Map<String, dynamic> userinfo) {
    _db.collection("user").doc("currentUser").set(userinfo);
    print(_db.collection('user').doc("currentUser").get());
  }

  Future<String> token() async {
    final data = await _db.collection('user').doc("currentUser").get();
    if (data == null || data.isEmpty) return null;
    return data['token'];
  }

  Future<User> user() async {
    final data = await _db.collection('user').doc("currentUser").get();
    if (data == null || data.isEmpty) return null;
    var u = data["User"];
    var user = User.fromJson(u);
    return user;
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

  Future<bool> isAuthenticate() async {
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
      disconnect();
      return false;
    }

    return true;
  }

  void disconnect() {
    _db.collection('user').doc("currentUser").delete();
  }
}
