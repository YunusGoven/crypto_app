import 'package:mvvm/Model/models/wallet.dart';

class ConnectedUser {
  String _token;
  List<ConnectedWallet> _wallets;

  ConnectedUser(this._token, this._wallets);

  String get token => _token;
  List<ConnectedWallet> get wallets => _wallets;

  ConnectedUser.fromJson(Map<String, dynamic> json) {
    _token = json['token'];
    if (json['wallets'] != null) {
      _wallets = <ConnectedWallet>[];
      json['wallets'].forEach((v) {
        _wallets.add(ConnectedWallet.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    if (wallets != null) {
      data['wallets'] = wallets.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RegisterUser {
  final String _firstName;
  final String _surname;
  final String _mail;
  final String _pseudo;
  final String _password;

  RegisterUser(
      this._firstName, this._surname, this._mail, this._pseudo, this._password);

  String get firstName => _firstName;
  String get surname => _surname;
  String get mail => _mail;
  String get pseudo => _pseudo;
  String get password => _password;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['surname'] = surname;
    data['mail'] = mail;
    data['pseudo'] = pseudo;
    data['password'] = password;
    return data;
  }
}

class ClassementUser {
  String _pseudo;
  num _solde;

  ClassementUser(this._pseudo, this._solde);

  String get pseudo => _pseudo;
  num get solde => _solde;

  ClassementUser.fromJson(Map<String, dynamic> json) {
    _pseudo = json['pseudo'];
    _solde = json['solde'];
  }
}

class User {
  String _id;
  String _firstname;
  String _surname;
  String _mail;
  String _pseudo;
  num _solde;
  String _password;
  bool _isBlocked;
  bool _isAdmin;
  User(this._id, this._firstname, this._surname, this._mail, this._pseudo,
      this._solde, this._isAdmin);

  bool get isBlocked => _isBlocked;
  String get id => _id;
  String get firstname => _firstname;
  String get surname => _surname;
  String get mail => _mail;
  String get pseudo => _pseudo;
  num get solde => _solde;
  set setSolde(num update) {
    _solde += update;
  }

  String get password => _password;
  bool get admin => _isAdmin;

  User.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _firstname = json['firstname'];
    _surname = json['surname'];
    _mail = json['email'];
    _pseudo = json['userName'];
    _solde = json['solde'];
    _isBlocked = json['isBlocked'];
  }
}
