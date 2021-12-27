import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/foundation.dart';

class NotificationService {
  final AndroidNotificationChannel _channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      'This channel is used for important notifications.', // description
      importance: Importance.high,
      playSound: true);

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    print('A bg message just showed up :  ${message.notification.body}');
  }

  Future<void> listen(GlobalKey<ScaffoldMessengerState> key) async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
          FlutterLocalNotificationsPlugin();
      var messaging = FirebaseMessaging.instance;
      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);
      await _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          .createNotificationChannel(_channel);
      NotificationSettings settings = await messaging.requestPermission(
          alert: true, badge: true, provisional: true, sound: true);

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        print("User granted permission");
        FirebaseMessaging.onMessage.listen((RemoteMessage message) {
          RemoteNotification notification = message.notification;
          AndroidNotification android = message.notification?.android;
          if (notification != null && android != null) {
            _flutterLocalNotificationsPlugin.show(
                notification.hashCode,
                notification.title,
                notification.body,
                NotificationDetails(
                  android: AndroidNotificationDetails(
                    _channel.id,
                    _channel.name,
                    _channel.description,
                    color: Colors.blue,
                    playSound: true,
                    icon: '@mipmap/ic_launcher',
                  ),
                ));
          }
        });
        FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
          print('A new onMessageOpenedApp event was published!');
          RemoteNotification notification = message.notification;
          AndroidNotification android = message.notification?.android;
          if (notification != null && android != null) {
            _flutterLocalNotificationsPlugin.show(
                notification.hashCode,
                notification.title,
                notification.body,
                NotificationDetails(
                  android: AndroidNotificationDetails(
                    _channel.id,
                    _channel.name,
                    _channel.description,
                    color: Colors.blue,
                    playSound: true,
                    icon: '@mipmap/ic_launcher',
                  ),
                ));
          }
        });
      } else {
        FirebaseMessaging.onMessage.listen((RemoteMessage message) {
          RemoteNotification notification = message.notification;
          if (notification != null) {
            final title = notification.title;
            final body = notification.body;
            print('$title | $body');
            key.currentState.showSnackBar(SnackBar(content: Text(body)));
          }
        });
      }
    }
  }
}
