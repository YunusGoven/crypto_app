class NotificationModel {
  String _notificationId;
  String _dateNotif;
  String _message;

  NotificationModel({String notificationId, String dateNotif, String message}) {
    this._notificationId = notificationId;
    this._dateNotif = dateNotif;
    this._message = message;
  }

  String get notificationId => _notificationId;
  String get dateNotif => _dateNotif;
  String get message => _message;

  NotificationModel.fromJson(Map<String, dynamic> json) {
    _notificationId = json['notificationId'];
    _dateNotif = json['dateNotif'];
    _message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['notificationId'] = this._notificationId;
    data['dateNotif'] = this._dateNotif;
    data['message'] = this._message;
    return data;
  }
}
