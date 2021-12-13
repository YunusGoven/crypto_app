import 'package:flutter/material.dart';
import 'package:mvvm/Routing/route_names.dart';
import 'package:mvvm/Services/userinfo_service.dart';
import 'package:mvvm/locator.dart';

import 'navbar_item.dart';

class NavigationBarTabletDesktop extends StatelessWidget {
  const NavigationBarTabletDesktop({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Row(
        children: <Widget>[
          //790
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
              FutureBuilder<bool>(
                future: locator<Auth>().isAuthenticate(),
                builder: (context, snapshot) {
                  if (snapshot.data) {
                    return Row(
                      children: [
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
                    );
                  } else {
                    return Row(
                      children: [
                        NavBarItem('Log In', LoginRoute),
                        SizedBox(
                          width: 60,
                        ),
                        NavBarItem('Register', RegisterRoute),
                      ],
                    );
                  }
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
