import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mvvm/Routing/route_names.dart';
import 'package:mvvm/Services/userinfo_service.dart';
import 'package:mvvm/locator.dart';

import 'navbar_item.dart';

class NavigationBarTabletDesktop extends StatefulWidget {
  const NavigationBarTabletDesktop({Key key}) : super(key: key);

  @override
  _NavigationBarTabletDesktopState createState() =>
      _NavigationBarTabletDesktopState();
}

class _NavigationBarTabletDesktopState
    extends State<NavigationBarTabletDesktop> {
  final auth = locator<Auth>();
  bool isAuth = false;
  @override
  void initState() {
    super.initState();
    getAuth();
  }

  getAuth() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      auth.isAuthenticate().then((value) {
        if (isAuth != value) {
          isAuth = value;
          setState(() {});
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      height: 50,
      child: Row(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 20,
              ),
              NavBarItem('Accueil', HomeRoute),
              SizedBox(
                width: 20,
              ),
              NavBarItem('Cryptos', CryptosRoute),
              SizedBox(
                width: 20,
              ),
              NavBarItem('Contact', ContactRoute),
              SizedBox(
                width: 20,
              ),
              if (isAuth)
                Row(
                  children: [
                    NavBarItem('Historique', HistoryRoute),
                    SizedBox(
                      width: 20,
                    ),
                    NavBarItem('Classement', RankingRoute),
                    SizedBox(
                      width: 20,
                    ),
                    NavBarItem('Notification', NotificationRoute),
                    SizedBox(
                      width: 20,
                    ),
                    NavBarItem('Portfeuille', WalletRoute),
                    SizedBox(
                      width: 20,
                    ),
                    NavBarItem('Deconnexion', ""),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              if (!isAuth)
                Row(
                  children: [
                    NavBarItem('Connexion', LoginRoute),
                    SizedBox(
                      width: 20,
                    ),
                    NavBarItem('Register', RegisterRoute),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                )
            ],
          )
        ],
      ),
    );
  }
}
