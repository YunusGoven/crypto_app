import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:localstore/localstore.dart';
import 'package:mvvm/Model/models/user.dart';
import 'package:mvvm/Routing/route_names.dart';
import 'package:mvvm/Routing/router.dart';
import 'package:mvvm/Services/navigation_service.dart';
import 'package:mvvm/Services/notification_service.dart';
import 'package:mvvm/Services/userinfo_service.dart';
import 'package:mvvm/View/pages/screen_template.dart';
import 'locator.dart';
import 'package:provider/provider.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

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
    NotificationService().listen(_messangerKey);
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: _auth.userInfo,
      initialData: null,
      //provider
      child: Builder(builder: (context1) {
        final user = Provider.of<User>(context1, listen: false);
        //theme
        return AdaptiveTheme(
            light: ThemeData(
              brightness: Brightness.light,
              primarySwatch: Colors.blue,
            ),
            dark: ThemeData(
              brightness: Brightness.dark,
              primarySwatch: Colors.red,
            ),
            initial: AdaptiveThemeMode.light,
            builder: (theme, darkTheme) =>
                //materialApp
                MaterialApp(
                  scrollBehavior: MyCustomScrollBehavior(),
                  title: 'crypto app',
                  debugShowCheckedModeBanner: false,
                  theme: theme,
                  darkTheme: darkTheme,
                  //routing
                  builder: (context, child) => Navigator(
                    key: locator<NavigationService>().screenNavigationKey,
                    onGenerateRoute: (settings) => MaterialPageRoute(
                        builder: (context) => ScreenTemplate(child: child)),
                  ),
                  //{
                  //   return SafeArea(
                  //     child: Overlay(
                  //       initialEntries: [
                  //         OverlayEntry(
                  //           builder: (context) => ScreenTemplate(child: child),
                  //         ),
                  //       ],
                  //     ),
                  //   );
                  // },
                  navigatorKey: locator<NavigationService>().navigatorKey,
                  onGenerateRoute: Rooter(context1).generateRoute,
                  initialRoute: kIsWeb || user != null ? HomeRoute : LoginRoute,
                ));
      }),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
