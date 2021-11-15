class History {
  String _transactionId;
  String _type;
  String _dateTransaction;
  num _number;
  num _value;
  String _imageUrl;
  String _cryptoId;
  String _cryptoName;

  History(this._transactionId, this._type, this._dateTransaction, this._number,
      this._value, this._imageUrl, this._cryptoId, this._cryptoName);

  String get transactionId => _transactionId;
  String get type => _type;
  String get dateTransaction => _dateTransaction;
  num get number => _number;
  num get value => _value;
  String get imageUrl => _imageUrl;
  String get cryptoId => _cryptoId;
  String get cryptoName => _cryptoName;

  History.fromJson(Map<String, dynamic> json) {
    _transactionId = json['transactionId'];
    _type = json['type'];
    _dateTransaction = json['dateTransaction'];
    _number = json['number'];
    _value = json['value'];
    _imageUrl = json['imageUrl'];
    _cryptoId = json['cryptoId'];
    _cryptoName = json['cryptoName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['transactionId'] = _transactionId;
    data['type'] = _type;
    data['dateTransaction'] = _dateTransaction;
    data['number'] = _number;
    data['value'] = _value;
    data['imageUrl'] = _imageUrl;
    data['cryptoId'] = _cryptoId;
    data['cryptoName'] = _cryptoName;
    return data;
  }
}
