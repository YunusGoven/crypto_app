import 'package:mvvm/Model/models/wallet.dart';

class ConnectedUser {
  User _user;
  String _token;
  List<ConnectedWallet> _wallets;

  ConnectedUser(this._user, this._token, this._wallets);

  User get user => _user;
  String get token => _token;
  List<ConnectedWallet> get wallets => _wallets;

  ConnectedUser.fromJson(Map<String, dynamic> json) {
    _user = User.fromJson(json['User']);
    _token = json['token'];
    if (json['wallets'] != null) {
      _wallets = new List<ConnectedWallet>();
      json['wallets'].forEach((v) {
        _wallets.add(new ConnectedWallet.fromJson(v));
      });
    }
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

  User(this._id, this._firstname, this._surname, this._mail, this._pseudo,
      this._solde, this._password);

  String get id => _id;
  String get firstname => _firstname;
  String get surname => _surname;
  String get mail => _mail;
  String get pseudo => _pseudo;
  num get solde => _solde;
  String get password => _password;

  User.fromJson(Map<String, dynamic> json) {
    _id = json['Id'];
    _firstname = json['Firstname'];
    _surname = json['Surname'];
    _mail = json['Email'];
    _pseudo = json['UserName'];
    _solde = json['Solde'];
  }
}
