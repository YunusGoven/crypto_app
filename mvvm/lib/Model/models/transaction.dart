class Transaction {
  String _cryptoId;
  num _number;
  num _currentValue;
  String _type;

  Transaction(this._cryptoId, this._number, this._currentValue, this._type);

  String get cryptoId => _cryptoId;
  num get number => _number;
  num get currentValue => _currentValue;
  String get type => _type;

  Transaction.fromJson(Map<String, dynamic> json) {
    _cryptoId = json['cryptoId'];
    _number = json['number'];
    _currentValue = json['currentValue'];
    _type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cryptoId'] = _cryptoId;
    data['number'] = _number;
    data['currentValue'] = _currentValue;
    data['type'] = _type;
    return data;
  }
}
