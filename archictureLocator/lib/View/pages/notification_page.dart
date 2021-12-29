import 'package:flutter/material.dart';
import 'package:mvvm/View/widgets/notifcationwidget.dart';
import 'package:mvvm/ViewModel/notification_viewmodel.dart';
import 'package:stacked/stacked.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final NotificationViewModel _nvm = NotificationViewModel();

  Widget createWildget(NotificationViewModel model) {
    model.notification.sort((a, b) => b.getDateTime.compareTo(a.getDateTime));
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        ...model.notification
            .asMap()
            .map((index, value) => MapEntry(
                index,
                Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey[700],
                        width: 5,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        NotificationWidget(notification: value),
                        IconButton(
                            onPressed: () async {
                              var isDeleted = await _nvm
                                  .deleteNotification(value.notificationId);
                              if (isDeleted.code == 200) {
                                setState(() {
                                  model.notification.removeWhere((element) =>
                                      element.notificationId ==
                                      value.notificationId);
                                });
                              }
                              final snackBar = SnackBar(
                                content: Text(
                                  isDeleted.value,
                                  style: const TextStyle(fontSize: 20),
                                ),
                                backgroundColor: isDeleted.code == 200
                                    ? Colors.green
                                    : Colors.red,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            },
                            icon: const Icon(Icons.delete)),
                      ],
                    ))))
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
      disposeViewModel: false,
      builder: (context, model, child) => SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            model.notification == null
                ? const CircularProgressIndicator()
                : model.notification.isEmpty
                    ? const Center(
                        child: Text(
                          "Vous n'avez pas de notifications",
                          style: TextStyle(fontSize: 24),
                        ),
                      )
                    : createWildget(model),
          ],
        ),
      )),
    );
  }
}
