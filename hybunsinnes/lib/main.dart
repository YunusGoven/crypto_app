import 'package:hybunsinnes/pages/screen_template.dart';
import 'package:hybunsinnes/routing/route_names.dart';
import 'package:hybunsinnes/routing/router.dart';
import 'package:hybunsinnes/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'locator.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HYBusiness',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      builder: (context, child) => ScreenTemplate(
        child: child,
      ),
      navigatorKey: locator<NavigationService>().navigatorKey,
      onGenerateRoute: generateRoute,
      initialRoute: LoginRoute,
    );
  }
}
