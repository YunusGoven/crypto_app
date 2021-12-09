import 'package:intl/intl.dart';
import 'package:mvvm/Model/models/notification.dart';
import 'package:mvvm/Services/api_service.dart';

class NotificationViewModel {
  NotificationViewModel();
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
    List<NotificationModel> notifications =
        await ApiService().getNotification();

    var cr = <NotificationViewModel>[];
    for (var item in notifications) {
      NotificationViewModel w = NotificationViewModel();
      w._notification = item;
      cr.add(w);
    }

    return cr;
  }
}
