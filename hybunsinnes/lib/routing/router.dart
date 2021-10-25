import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hybunsinnes/routing/route_names.dart';
import 'package:hybunsinnes/pages/connexion.dart';
import 'package:hybunsinnes/pages/login.dart';
import 'package:hybunsinnes/pages/home.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HomeRoute:
      return _getPageRoute(const HomePage(), settings);
    case ConnexionRoute:
      return _getPageRoute(const ConnexionPage(), settings);
    case LoginRoute:
      return _getPageRoute(const LoginPage(), settings);
    default:
      return _getPageRoute(const ConnexionPage(), settings);
  }
}

PageRoute _getPageRoute(Widget child, RouteSettings settings) {
  return _FadeRoute(child: child, routeName: settings.name);
}

class _FadeRoute extends PageRouteBuilder {
  final Widget child;
  final String routeName;
  _FadeRoute({this.child, this.routeName})
      : super(
          settings: RouteSettings(name: routeName),
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              child,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}
