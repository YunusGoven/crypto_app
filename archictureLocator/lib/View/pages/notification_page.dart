import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mvvm/Routing/route_names.dart';
import 'package:mvvm/Services/navigation_service.dart';
import 'package:mvvm/Services/userinfo_service.dart';
import 'package:mvvm/View/widgets/notifcationwidget.dart';
import 'package:mvvm/ViewModel/notification_viewmodel.dart';
import 'package:mvvm/locator.dart';
import 'package:stacked/stacked.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final NotificationViewModel _nvm = NotificationViewModel();

  Widget createWildget(NotificationViewModel model) {
    return Wrap(
      children: [
        ...model.notification
            .asMap()
            .map((index, value) => MapEntry(
                index,
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      NotificationWidget(notification: value),
                      IconButton(
                          onPressed: () async {
                            var isDeleted = await _nvm
                                .deleteNotification(value.notificationId);

                            final snackBar = SnackBar(
                              content: Text(
                                isDeleted.value,
                                style: TextStyle(fontSize: 20),
                              ),
                              backgroundColor: isDeleted.code == 200
                                  ? Colors.green
                                  : Colors.red,
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          },
                          icon: Icon(Icons.delete)),
                    ],
                  ),
                )))
            .values
            .toList()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NotificationViewModel>.reactive(
      viewModelBuilder: () => NotificationViewModel(),
      onModelReady: (model) => model.getNotifications(),
      builder: (context, model, child) => SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          model.notification == null
              ? const CircularProgressIndicator()
              : createWildget(model),
        ],
      )),
    );
  }
}
