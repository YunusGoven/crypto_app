import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hybunsinnes/model/notification.dart';

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
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.network(
              widget.notification.crypto.image,
              height: 50,
              width: 50,
            ),
            Column(
              children: [
                Text(
                  widget.notification.crypto.name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  widget.notification.message,
                  style: TextStyle(
                      color:
                          widget.notification.isUp ? Colors.green : Colors.red),
                )
              ],
            ),
            IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
          ],
        ),
      ),
    );
  }
}
