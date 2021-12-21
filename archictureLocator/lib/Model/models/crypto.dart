import 'dart:collection';

import 'package:intl/intl.dart';

// max 8 chiffre apres la virgule

class Crypto {
  final String _id;
  final String _symbol;
  final String _name;
  final String _logoUrl;
  final String _price;
  final String _priceDate;
  final Day _h1;
  final Day _d1;
  final Day _d7;
  final Day _d30;
  final Map<String, dynamic> _history;

  String get Id => _id;
  String get Symbole => _symbol;
  String get Name => _name;
  num get Price => num.tryParse(_price);
  String get PriceDate => _priceDate;
  String get LogoUrl => _logoUrl;
  num get Percent => _h1.PricePercentChange;
  Map<String, dynamic> get HistoryValue => _history;
  num get H1Price => _h1.PriceChange;
  num get D1Price => _d1.PriceChange;
  num get D7Price => _d7.PriceChange;
  num get D30Price => _d30.PriceChange;

  Crypto(this._id, this._symbol, this._name, this._logoUrl, this._price,
      this._priceDate, this._h1, this._d1, this._d7, this._d30, this._history);

  Crypto.fromJson(Map<String, dynamic> json)
      : _id = json['id'],
        _symbol = json['symbol'],
        _name = json['name'],
        _logoUrl = json['logo_Url'],
        _price = json['price'],
        _priceDate = json['price_Date'],
        _history = json['history'],
        _h1 = Day.fromJson(json['price_Change_Pct_1D']),
        _d1 = Day.fromJson(json['price_Change_Pct_1H']),
        _d7 = Day.fromJson(json['price_Change_Pct_7D']),
        _d30 = Day.fromJson(json['price_Change_Pct_30D']);
}

class Day {
  final String _priceChangePct;
  final String _priceChange;

  Day(this._priceChangePct, this._priceChange);

  Day.fromJson(Map<String, dynamic> json)
      : _priceChangePct = json['price_change_pct'],
        _priceChange = json['price_Change'];

  num get PricePercentChange => num.tryParse(_priceChangePct);
  num get PriceChange => num.tryParse(_priceChange);
}
