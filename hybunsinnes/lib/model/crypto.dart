class Crypto {
  final String name;
  final String id;
  final String image;
  final num currentvalue;
  final num currentpercent;
  final num d30;
  final num d7;
  final num d1;
  final num h1;
  Crypto(this.name, this.id, this.currentvalue, this.currentpercent, this.d30,
      this.d7, this.d1, this.h1, this.image);

  Crypto.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        id = json['id'],
        currentvalue = json['currentvalue'],
        currentpercent = json['currentpercent'],
        d30 = json['d30'],
        d7 = json['d7'],
        image = json['image'],
        d1 = json['d1'],
        h1 = json['h1'];
}
