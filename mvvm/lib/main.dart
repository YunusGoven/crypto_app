import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mvvm/Routing/route_names.dart';
import 'package:mvvm/Routing/router.dart';
import 'package:mvvm/Services/navigation_service.dart';
import 'package:mvvm/View/pages/screen_template.dart';
import 'locator.dart';

// const AndroidNotificationChannel channel = AndroidNotificationChannel(
//     'high_importance_channel', // id
//     'High Importance Notifications', // title
//     'This channel is used for important notifications.', // description
//     importance: Importance.high,
//     playSound: true);

// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   print('A bg message just showed up :  ${message.messageId}');
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  setupLocator();
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
      title: 'crypto app',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      builder: (context, child) => ScreenTemplate(
        child: SafeArea(child: child),
      ),
      navigatorKey: locator<NavigationService>().navigatorKey,
      onGenerateRoute: generateRoute,
      initialRoute: HomeRoute,
    );
  }
}
        //drawer: /*global.user != null ? */ Menu(context: context) /* : null*/,
        // drawer: Menu(),
        // appBar: /*global.user != null
        //     ? */
        //     AppBar(
        //   title: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       SizedBox(
        //         width: 1,
        //       ),
        //       // Text(global.header),
        //       // Text("${global.user.solde} \$")
        //       Text("Joueur 456"),
        //       Text("100000\$")
        //     ],
        //   ),
        //   backgroundColor: Colors.black,
        // ) /*: null*/,
        // body: ChangeNotifierProvider(
        //   create: (context) => CryptoListViewModel(),
        //   child: HomePage(
        //     solde: 10000,
        //     username: 'Joueur 456',
        //   ),
        // ),
        // body: HomePage(),
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
