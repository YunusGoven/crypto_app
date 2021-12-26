import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:mvvm/Model/models/notification.dart';
import 'package:mvvm/Services/api_response.dart';
import 'package:mvvm/Services/api_service.dart';
import 'package:mvvm/locator.dart';

class NotificationViewModel extends ChangeNotifier {
  final _api = locator<ApiService>();

  List<NotificationModel> _notification;
  List<NotificationModel> get notification => _notification;

  Future getNotifications() async {
    var result = await _api.getNotification();
    if (result == null) {
    } else {
      _notification = result;
    }
    notifyListeners();
  }

  Future<ApiResponse> deleteNotification(String notificationId) async {
    var send = await _api.deleteNotification(notificationId);
    getNotifications();
    return send;
  }
}
