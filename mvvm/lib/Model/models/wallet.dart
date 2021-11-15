class Wallet {
  String _walletId;
  String _cryptoId;
  double _number;
  bool _notifiactionActivated;
  String _imageUrl;
  String _name;
  num _lastValue;
  num _percent;
  num _gainsPertesTotal;
  num _gainsPertes;

  Wallet(
      this._walletId,
      this._cryptoId,
      this._number,
      this._notifiactionActivated,
      this._imageUrl,
      this._name,
      this._lastValue,
      this._percent,
      this._gainsPertesTotal,
      this._gainsPertes);

  String get walletId => _walletId;
  String get cryptoId => _cryptoId;
  num get number => _number;
  bool get notifiactionActivated => _notifiactionActivated;
  void set nofitication(bool active) => _notifiactionActivated = active;
  String get imageUrl => _imageUrl;
  String get name => _name;
  num get lastValue => _lastValue;
  num get percent => _percent;
  num get gainsPertesTotal => _gainsPertesTotal;
  num get gainsPertes => _gainsPertes;

  Wallet.fromJson(Map<String, dynamic> json) {
    _walletId = json['walletId'];
    _cryptoId = json['cryptoId'];
    _number = json['number'];
    _notifiactionActivated = json['notifiactionActivated'];
    _imageUrl = json['imageUrl'];
    _name = json['name'];
    _lastValue = json['last_Value'];
    _percent = json['percent'];
    _gainsPertesTotal = json['gainsPertesTotal'];
    _gainsPertes = json['gainsPertes'];
  }
}
