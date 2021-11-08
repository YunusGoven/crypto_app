class Wallet {
  final String imageurl;
  final num number;
  final String name;
  final String cryptid;
  Wallet(this.imageurl, this.number, this.name, this.cryptid);

  Wallet.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        number = json['number'],
        imageurl = json['imageurl'],
        cryptid = json['cryptid'];
}
