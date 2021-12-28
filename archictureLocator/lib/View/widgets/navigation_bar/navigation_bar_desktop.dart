import 'package:flutter/material.dart';
import 'package:mvvm/Model/models/user.dart';
import 'package:mvvm/Routing/route_names.dart';

import 'package:provider/provider.dart';
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
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Container(
      color: Colors.grey,
      height: 50,
      child: Row(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                width: 20,
              ),
              const NavBarItem('Accueil', HomeRoute),
              const SizedBox(
                width: 20,
              ),
              const NavBarItem('Cryptos', CryptosRoute),
              const SizedBox(
                width: 20,
              ),
              const NavBarItem('Contact', ContactRoute),
              const SizedBox(
                width: 20,
              ),
              const NavBarItem('Option', OptionRoute),
              const SizedBox(
                width: 20,
              ),
              if (user != null)
                Row(
                  children: [
                    const NavBarItem('Historique', HistoryRoute),
                    const SizedBox(
                      width: 20,
                    ),
                    const NavBarItem('Classement', RankingRoute),
                    const SizedBox(
                      width: 20,
                    ),
                    const NavBarItem('Notification', NotificationRoute),
                    const SizedBox(
                      width: 20,
                    ),
                    const NavBarItem('Portfeuille', WalletRoute),
                    const SizedBox(
                      width: 20,
                    ),
                    if (user.admin) const NavBarItem('Admin', AdminPanelRoute),
                    const SizedBox(
                      width: 20,
                    ),
                    const NavBarItem('Deconnexion', ""),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              if (user == null)
                Row(
                  children: const [
                    NavBarItem('Connexion', LoginRoute),
                    SizedBox(
                      width: 20,
                    ),
                    NavBarItem('Register', RegisterRoute),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
            ],
          )
        ],
      ),
    );
  }
}
