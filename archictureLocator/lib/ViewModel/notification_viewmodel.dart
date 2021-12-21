import 'package:intl/intl.dart';
import 'package:mvvm/Model/models/notification.dart';
import 'package:mvvm/Services/api_service.dart';
import 'package:mvvm/locator.dart';

class NotificationViewModel {
  final _api = locator<ApiService>();

  NotificationModel _notification;

  String get notificationId => _notification.notificationId;
  String get dateNotif {
    var date = _notification.dateNotif;
    var datetime = DateTime.parse(date);
    var formated = DateFormat("hh:mm dd-MM-yyyy").format(datetime);

    return formated;
  }

  String get message => _notification.message;

  Future<List<NotificationViewModel>> getNotifications() async {
    List<NotificationModel> notifications = await _api.getNotification();

    List<NotificationViewModel> cr = <NotificationViewModel>[];
    for (var item in notifications) {
      NotificationViewModel w = NotificationViewModel();
      w._notification = item;
      cr.add(w);
    }

    return cr;
  }

  Future<bool> deleteNotification(String notificationId) async {
    return await _api.deleteNotification(notificationId);
  }
}
