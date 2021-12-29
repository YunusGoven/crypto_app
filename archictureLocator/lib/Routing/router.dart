import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mvvm/Model/models/user.dart';
import 'package:mvvm/Routing/extensions.dart';
import 'package:mvvm/Routing/route_names.dart';
import 'package:mvvm/View/pages/administration_page.dart';
import 'package:mvvm/View/pages/all_page.dart';
import 'package:mvvm/View/pages/connection_page.dart';
import 'package:mvvm/View/pages/contact_page.dart';
import 'package:mvvm/View/pages/detail_page.dart';
import 'package:mvvm/View/pages/discussion_page.dart';
import 'package:mvvm/View/pages/history_page.dart';
import 'package:mvvm/View/pages/home_page.dart';
import 'package:mvvm/View/pages/notification_page.dart';
import 'package:mvvm/View/pages/ranking_page.dart';
import 'package:mvvm/View/pages/register_page.dart';
import 'package:mvvm/View/pages/wallet_page.dart';

import 'package:provider/provider.dart';

class Rooter {
  final BuildContext context;
  Rooter(this.context);
  Route<dynamic> generateRoute(RouteSettings settings) {
    final user = Provider.of<User>(context, listen: false);
    var routingData = settings.name.getRoutingData;
    switch (routingData.route) {
      case AdminPanelRoute:
        if (user == null || !user.admin) {
          return _getPageRoute(const HomePage(), settings);
        }
        return _getPageRoute(const AdministrationPage(), settings);
      case LoginRoute:
        if (user != null) return _getPageRoute(const HomePage(), settings);
        return _getPageRoute(const LoginPage(), settings);
      case HomeRoute:
        return _getPageRoute(const HomePage(), settings);
      case RegisterRoute:
        if (user != null) {
          if (!user.admin) return _getPageRoute(const HomePage(), settings);
        }

        return _getPageRoute(const RegisterPage(), settings);
      case ContactRoute:
        return _getPageRoute(const ContactPage(), settings);
      case CryptosRoute:
        return _getPageRoute(const AllCryptoPage(), settings);
      case HistoryRoute:
        if (user == null) return _getPageRoute(const HomePage(), settings);
        return _getPageRoute(const HistoryPage(), settings);
      case RankingRoute:
        if (user == null) return _getPageRoute(const HomePage(), settings);
        return _getPageRoute(const RankingPage(), settings);
      case NotificationRoute:
        if (user == null) return _getPageRoute(const HomePage(), settings);
        return _getPageRoute(const NotificationPage(), settings);
      case WalletRoute:
        if (user == null) return _getPageRoute(const HomePage(), settings);
        return _getPageRoute(const WalletPage(), settings);
      case CryptoDetailsRoute:
        var id = (routingData['cryptoId']);
        return _getPageRoute(
            DetailPage(
              cryptoId: id,
            ),
            settings);
      case MessagingRoute:
        if (user == null) return _getPageRoute(const HomePage(), settings);
        var id = (routingData['cryptoId']);
        return _getPageRoute(
            DiscussionPage(
              cryptoId: id,
            ),
            settings);
      default:
        return _getPageRoute(const HomePage(), settings);
    }
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
          transitionDuration: Duration.zero,
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
