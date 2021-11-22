import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mvvm/View/pages/connection_page.dart';
import 'package:mvvm/View/pages/home_page.dart';
import 'package:mvvm/View/pages/notification_page.dart';
import 'package:mvvm/View/pages/ranking_page.dart';
import 'package:mvvm/View/pages/register_page.dart';
import 'package:mvvm/View/widgets/menu_widget.dart';
import 'package:mvvm/ViewModel/crypto_viewmodel.dart';

import 'View/pages/wallet_page.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var messaging = FirebaseMessaging.instance;
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      .createNotificationChannel(channel);
  NotificationSettings settings = await messaging.requestPermission(
      alert: true, badge: true, provisional: true, sound: true);

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print("User granted permission");
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
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
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ));
      }
    });
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        //drawer: /*global.user != null ? */ Menu(context: context) /* : null*/,
        drawer: Menu(),
        appBar: /*global.user != null
            ? */
            AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 1,
              ),
              // Text(global.header),
              // Text("${global.user.solde} \$")
              Text("Joueur 456"),
              Text("100000\$")
            ],
          ),
          backgroundColor: Colors.black,
        ) /*: null*/,
        // body: ChangeNotifierProvider(
        //   create: (context) => CryptoListViewModel(),
        //   child: HomePage(
        //     solde: 10000,
        //     username: 'Joueur 456',
        //   ),
        // ),
        body: HomePage(),
        // body: HomePage(
        //   solde: 10000,
        //   username: 'Joueur 456',
        // ),

        //body: WalletPage(),
        //body: NotificationPage(),
        //body: ClassementPage(),

        // body: SafeArea(
        //   child: LoginPage(),
        // ),

        // body: SafeArea(
        //   child: RegisterPage(),
        // ),
      ),
    );
  }
}
