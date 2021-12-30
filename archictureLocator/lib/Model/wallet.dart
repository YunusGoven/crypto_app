// ignore_for_file: unnecessary_getters_setters

class Wallet {
  String _walletId;
  String _cryptoId;
  double _number;
  bool _notificationActivated;
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
      this._notificationActivated,
      this._imageUrl,
      this._name,
      this._lastValue,
      this._percent,
      this._gainsPertesTotal,
      this._gainsPertes);

  String get walletId => _walletId;
  String get cryptoId => _cryptoId;
  String get number => _number.toStringAsFixed(8);
  bool get notificationActivated => _notificationActivated;

  get walletViewModel => null;
  set nofitication(bool active) => _notificationActivated = active;
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
    _notificationActivated = json['notifiactionActivated'];
    _imageUrl = json['imageUrl'];
    _name = json['name'];
    _lastValue = json['last_Value'];
    _percent = json['percent'];
    _gainsPertesTotal = json['gainsPertesTotal'];
    _gainsPertes = json['gainsPertes'];
  }
}

class ConnectedWallet {
  double _number;
  String _cryptoId;

  ConnectedWallet({double number, String cryptoId}) {
    _number = number;
    _cryptoId = cryptoId;
  }

  double get number => _number;
  set number(double number) => _number = number;
  String get cryptoId => _cryptoId;
  set cryptoId(String cryptoId) => _cryptoId = cryptoId;

  ConnectedWallet.fromJson(Map<String, dynamic> json) {
    _number = json['number'];
    _cryptoId = json['cryptoId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['number'] = _number;
    data['cryptoId'] = _cryptoId;
    return data;
  }
}
