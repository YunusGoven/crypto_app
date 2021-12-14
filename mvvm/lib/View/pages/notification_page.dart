import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mvvm/View/widgets/notifcationwidget.dart';
import 'package:mvvm/ViewModel/notification_viewmodel.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final StreamController<List<NotificationViewModel>> notificationsController =
      StreamController();
  final NotificationViewModel _nvm = NotificationViewModel();

  @override
  void initState() {
    super.initState();
    getNotifications();
  }

  getNotifications() async {
    List<NotificationViewModel> notifications = await _nvm.getNotifications();
    if (!notificationsController.isClosed) {
      notificationsController.sink.add(notifications);
    }
  }

  @override
  void dispose() {
    notificationsController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 25, left: 20, right: 20, bottom: 25),
          child: StreamBuilder(
            stream: notificationsController.stream,
            builder: (context, snapdata) {
              switch (snapdata.connectionState) {
                case ConnectionState.waiting:
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                default:
                  if (snapdata.hasError) {
                    return Text("Attend frere");
                  } else {
                    return Column(
                      children: createWidget(snapdata.data),
                    );
                  }
              }
            },
          ),
        ),
      ),
    );
  }

  createWidget(List<NotificationViewModel> data) {
    var notifications = <Widget>[];
    data.forEach((element) {
      var r = Container(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              NotificationWidget(notification: element),
              IconButton(
                  onPressed: () async {
                    var isDeleted =
                        await _nvm.deleteNotification(element.notificationId);
                    if (isDeleted) {
                      setState(() {
                        data.remove(element);
                      });
                    }
                  },
                  icon: Icon(Icons.delete)),
            ],
          ),
        ),
      );

      notifications.add(r);

      //var widget = NotificationWidget(notification: element);
      //notifications.add(widget);
      var divider =
          Divider(color: Colors.black, indent: 10, endIndent: 10, thickness: 5);
      notifications.add(divider);
    });

    if (notifications.isNotEmpty) notifications.removeLast();
    return notifications;
  }
}
