import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mvvm/Routing/route_names.dart';
import 'package:mvvm/Services/navigation_service.dart';
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    int i = 0;

    Timer.periodic(Duration(seconds: 1), (timer) async {
      var isAut = await locator<Auth>().isAuthenticate();
      if (isAut && i == 0) {
        setState(() {});
        i = 1;
      }
      if (!isAut) {
        i = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
              FutureBuilder<bool>(
                future: locator<Auth>().isAuthenticate(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Text('Loading....');
                    default:
                      if (snapshot.hasError)
                        return Text('Error: ${snapshot.error}');
                      else if (snapshot.data) {
                        return Row(
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
                            //NavBarItem('Deconnexion', ""),
                            GestureDetector(
                              onTap: () {
                                locator<NavigationService>().navigateTo("");
                                setState(() {});
                              },
                              child: Text(
                                "Deconnexion",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                          ],
                        );
                      } else {
                        return Row(
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
                        );
                      }
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
