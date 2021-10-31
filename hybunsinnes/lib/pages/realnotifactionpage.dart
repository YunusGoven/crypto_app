import 'package:flutter/material.dart';
import 'package:hybunsinnes/model/notification.dart';
import 'package:hybunsinnes/widgets/notifcationwidget.dart';

class NotificationPage extends StatefulWidget {
  final List<NotificationModel> notifications;
  const NotificationPage({Key key, this.notifications}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(top: 25, left: 20, right: 20, bottom: 25),
        child: Column(
          children: createWidget(),
        ),
      ),
    );
  }

  createWidget() {
    var userWidget = <Widget>[];
    widget.notifications.forEach((element) {
      var wi = NotificationWidget(
        notification: element,
      );
      userWidget.add(wi);
      var divider =
          Divider(color: Colors.black, indent: 10, endIndent: 10, thickness: 5);
      userWidget.add(divider);
    });
    userWidget.removeLast();
    return userWidget;
  }
}
