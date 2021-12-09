import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mvvm/ViewModel/notification_viewmodel.dart';

class NotificationWidget extends StatefulWidget {
  final NotificationViewModel notification;

  const NotificationWidget({Key key, @required this.notification})
      : super(key: key);

  @override
  _NotificationWidgetState createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  @override
  Widget build(BuildContext context) {
    return /*Container(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [*/
        Column(
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
    ) /*,
            IconButton(
                onPressed: () async {
                  var isDeleted = await ApiService()
                      .deleteNotification(widget.notification.notificationId);
                  if (isDeleted) {}
                },
                icon: Icon(Icons.delete)),
          ],
        ),
      ),
    )*/
        ;
  }
}
