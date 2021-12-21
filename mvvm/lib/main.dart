import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:localstore/localstore.dart';
import 'package:mvvm/Routing/route_names.dart';
import 'package:mvvm/Routing/router.dart';
import 'package:mvvm/Services/navigation_service.dart';
import 'package:mvvm/Services/notification_service.dart';
import 'package:mvvm/Services/userinfo_service.dart';
import 'package:mvvm/View/pages/screen_template.dart';
import 'locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();
  final db = Localstore.instance;

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _auth = locator<Auth>();
  final _messangerKey = GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    if (kIsWeb) NotificationService().listen(_messangerKey);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'crypto app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      builder: (context, child) {
        return SafeArea(
          child: Overlay(
            initialEntries: [
              OverlayEntry(
                builder: (context) => ScreenTemplate(child: child),
              ),
            ],
          ),
        );
      },
      navigatorKey: locator<NavigationService>().navigatorKey,
      onGenerateRoute: generateRoute,
      initialRoute: kIsWeb ? HomeRoute : LoginRoute,
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
