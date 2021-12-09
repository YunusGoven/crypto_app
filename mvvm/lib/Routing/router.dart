import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mvvm/Routing/route_names.dart';
import 'package:mvvm/View/pages/all_page.dart';
import 'package:mvvm/View/pages/connection_page.dart';
import 'package:mvvm/View/pages/history_page.dart';
import 'package:mvvm/View/pages/home_page.dart';
import 'package:mvvm/View/pages/notification_page.dart';
import 'package:mvvm/View/pages/ranking_page.dart';
import 'package:mvvm/View/pages/wallet_page.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginRoute:
      return _getPageRoute(const LoginPage(), settings);
    case HomeRoute:
      return _getPageRoute(const HomePage(), settings);
    case CryptosRoute:
      return _getPageRoute(const AllCryptoPage(), settings);
    case HistoryRoute:
      return _getPageRoute(const HistoryPage(), settings);
    case RankingRoute:
      return _getPageRoute(const RankingPage(), settings);
    case NotificationRoute:
      return _getPageRoute(const NotificationPage(), settings);
    case WalletRoute:
      return _getPageRoute(const WalletPage(), settings);
    default:
      return _getPageRoute(const LoginPage(), settings);
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
