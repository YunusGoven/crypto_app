class ConnectedUser {
  User _user;
  String _token;

  ConnectedUser(this._user, this._token);

  User get user => _user;
  String get token => _token;

  ConnectedUser.fromJson(Map<String, dynamic> json) {
    _user = User.fromJson(json['User']);
    _token = json['token'];
  }
}

class RegisterUser {
  final String _firstName;
  final String _surname;
  final DateTime _bornDate;
  final String _mail;
  final String _pseudo;
  final String _password;

  RegisterUser(this._firstName, this._surname, this._bornDate, this._mail,
      this._pseudo, this._password);

  String get firstName => _firstName;
  String get surname => _surname;
  String get bornDate => _bornDate.toIso8601String();
  String get mail => _mail;
  String get pseudo => _pseudo;
  String get password => _password;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['surname'] = surname;
    data['bornDate'] = bornDate;
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
  String _ddn;
  String _mail;
  String _pseudo;
  num _solde;
  String _password;

  User(this._id, this._firstname, this._surname, this._ddn, this._mail,
      this._pseudo, this._solde, this._password);

  String get id => _id;
  String get firstname => _firstname;
  String get surname => _surname;
  String get ddn => _ddn;
  String get mail => _mail;
  String get pseudo => _pseudo;
  num get solde => _solde;
  String get password => _password;

  User.fromJson(Map<String, dynamic> json) {
    _id = json['Id'];
    _firstname = json['Firstname'];
    _surname = json['Surname'];
    _ddn = json['Ddn'];
    _mail = json['Mail'];
    _pseudo = json['Pseudo'];
    _solde = json['Solde'];
  }
}
