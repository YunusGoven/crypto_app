class User {
  UserModel _user;
  String _token;

  User({UserModel user, String token}) {
    this._user = user;
    this._token = token;
  }

  UserModel get user => _user;
  String get token => _token;

  User.fromJson(Map<String, dynamic> json) {
    _user = UserModel.fromJson(json['User']);
    _token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._user != null) {
      data['User'] = this._user.toJson();
    }
    data['token'] = this._token;
    return data;
  }
}

class UserModel {
  String _id;
  String _firstname;
  String _surname;
  String _ddn;
  String _mail;
  String _pseudo;
  int _solde;
  String _password;

  UserModel(
      {String id,
      String firstname,
      String surname,
      String ddn,
      String mail,
      String pseudo,
      int solde,
      String password}) {
    this._id = id;
    this._firstname = firstname;
    this._surname = surname;
    this._ddn = ddn;
    this._mail = mail;
    this._pseudo = pseudo;
    this._solde = solde;
    _password = password;
  }

  String get id => _id;
  String get firstname => _firstname;
  String get surname => _surname;
  String get ddn => _ddn;
  String get mail => _mail;
  String get pseudo => _pseudo;
  int get solde => _solde;
  String get password => _password;

  UserModel.fromJson(Map<String, dynamic> json) {
    _id = json['Id'];
    _firstname = json['Firstname'];
    _surname = json['Surname'];
    _ddn = json['Ddn'];
    _mail = json['Mail'];
    _pseudo = json['Pseudo'];
    _solde = json['Solde'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstname'] = this._firstname;
    data['surname'] = this._surname;
    data['bornDate'] = this._ddn;
    data['mail'] = this._mail;
    data['pseudo'] = this._pseudo;
    data['password'] = _password;
    return data;
  }
}
