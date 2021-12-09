import 'package:flutter/material.dart';
import 'package:mvvm/Routing/route_names.dart';
import 'package:mvvm/View/widgets/navigation_bar/nav_bar_item_mobile.dart';

class NavigationBarMobile extends StatelessWidget {
  const NavigationBarMobile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        children: <Widget>[
          NavBarMobile(1, 'Accueil', HomeRoute, Icons.home),
          NavBarMobile(
              2, 'Cryptos', CryptosRoute, Icons.shopping_cart_outlined),
          NavBarMobile(
              3, 'Historique', HistoryRoute, Icons.account_balance_wallet),
          NavBarMobile(4, 'Classement', RankingRoute, Icons.history),
          NavBarMobile(
              5, 'Notification', NotificationRoute, Icons.bar_chart_rounded),
          NavBarMobile(
              6, 'Portfeuille', WalletRoute, Icons.notifications_active),
        ],
      ),
    );
  }
}
