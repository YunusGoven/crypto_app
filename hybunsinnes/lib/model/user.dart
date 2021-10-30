class User {
  final String pseudo;
  final String email;
  final num solde;
  final String name;

  User(this.name, this.email, this.pseudo, this.solde);

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = json['email'],
        solde = json['solde'],
        pseudo = json['solde'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'solde': solde,
        'pseudo': pseudo,
      };
}
