import 'package:intl/intl.dart';

class NotificationModel {
  String _notificationId;
  String _dateNotif;
  String _message;

  NotificationModel({String notificationId, String dateNotif, String message}) {
    _notificationId = notificationId;
    _dateNotif = dateNotif;
    _message = message;
  }

  String get notificationId => _notificationId;
  String get dateNotif {
    var datetime = DateTime.parse(_dateNotif);
    var formated = DateFormat("dd-MM-yyyy HH:mm").format(datetime);
    return formated;
  }

  DateTime get getDateTime => DateTime.parse(_dateNotif);

  String get message => _message;

  NotificationModel.fromJson(Map<String, dynamic> json) {
    _notificationId = json['notificationId'];
    _dateNotif = json['dateNotif'];
    _message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['notificationId'] = _notificationId;
    data['dateNotif'] = _dateNotif;
    data['message'] = _message;
    return data;
  }
}
