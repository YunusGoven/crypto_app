class History {
  String _transactionId;
  String _type;
  String _dateTransaction;
  num _number;
  num _value;
  String _imageUrl;
  String _cryptoId;
  String _cryptoName;
  num _onTransactionValue;

  History(
      this._transactionId,
      this._type,
      this._dateTransaction,
      this._number,
      this._value,
      this._imageUrl,
      this._cryptoId,
      this._cryptoName,
      this._onTransactionValue);

  String get transactionId => _transactionId;
  String get type => _type;
  String get dateTransaction => _dateTransaction;
  DateTime get getDateTime => DateTime.tryParse(_dateTransaction);
  num get number => _number;
  num get value => _value;
  String get imageUrl => _imageUrl;
  String get cryptoId => _cryptoId;
  String get cryptoName => _cryptoName;
  num get onTransactionValue => _onTransactionValue;

  History.fromJson(Map<String, dynamic> json) {
    _transactionId = json['transactionId'];
    _type = json['type'];
    _dateTransaction = json['dateTransaction'];
    _number = json['number'];
    _value = json['value'];
    _imageUrl = json['imageUrl'];
    _cryptoId = json['cryptoId'];
    _cryptoName = json['cryptoName'];
    _onTransactionValue = json['onTransactionValue'];
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
    data['onTransactionValue'] = _onTransactionValue;
    return data;
  }
}
