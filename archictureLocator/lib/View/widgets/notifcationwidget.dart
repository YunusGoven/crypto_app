import 'package:flutter/material.dart';
import 'package:mvvm/Model/models/notification.dart';

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
    return Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 5,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.notification.message,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  widget.notification.dateNotif,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            )));
  }
}
