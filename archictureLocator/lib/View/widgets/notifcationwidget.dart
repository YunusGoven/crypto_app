import 'package:flutter/material.dart';
import 'package:mvvm/Model/models/notification.dart';
import 'package:mvvm/ViewModel/notification_viewmodel.dart';

class NotificationWidget extends StatefulWidget {
  final NotificationModel notification;

  const NotificationWidget({Key key, @required this.notification})
      : super(key: key);

  @override
  _NotificationWidgetState createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.notification.message,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          widget.notification.dateNotif,
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}
