import 'package:flutter/material.dart';
import 'package:mvvm/Routing/route_names.dart';

import 'navbar_item.dart';

class NavigationBarTabletDesktop extends StatelessWidget {
  const NavigationBarTabletDesktop({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              NavBarItem('Accueil', HomeRoute),
              SizedBox(
                width: 60,
              ),
              NavBarItem('Cryptos', CryptosRoute),
              SizedBox(
                width: 60,
              ),
              NavBarItem('Historique', HistoryRoute),
              SizedBox(
                width: 60,
              ),
              NavBarItem('Classement', RankingRoute),
              SizedBox(
                width: 60,
              ),
              NavBarItem('Notification', NotificationRoute),
              SizedBox(
                width: 60,
              ),
              NavBarItem('Portfeuille', WalletRoute),
            ],
          )
        ],
      ),
    );
  }
}
