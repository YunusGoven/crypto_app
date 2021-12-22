import 'package:flutter/material.dart';
import 'package:mvvm/Routing/route_names.dart';
import 'package:mvvm/Services/userinfo_service.dart';
import 'package:mvvm/View/widgets/navigation_bar/nav_bar_item_mobile.dart';
import 'package:mvvm/locator.dart';

class NavigationBarMobile extends StatefulWidget {
  const NavigationBarMobile({
    Key key,
  }) : super(key: key);
  @override
  _NavigationBarMobileState createState() => _NavigationBarMobileState();
}

class _NavigationBarMobileState extends State<NavigationBarMobile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black26,
      padding: EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        children: <Widget>[
          NavBarMobile(1, 'Accueil', HomeRoute, Icons.home),
          NavBarMobile(
              2, 'Cryptos', CryptosRoute, Icons.shopping_cart_outlined),
          NavBarMobile(
              10, 'Contact', ContactRoute, Icons.contact_support_outlined),
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
                    return Column(
                      children: [
                        NavBarMobile(
                            3, 'Historique', HistoryRoute, Icons.history),
                        NavBarMobile(4, 'Classement', RankingRoute,
                            Icons.bar_chart_rounded),
                        NavBarMobile(5, 'Notification', NotificationRoute,
                            Icons.notifications_active),
                        NavBarMobile(6, 'Portfeuille', WalletRoute,
                            Icons.account_balance_wallet),
                        NavBarMobile(7, 'Deconnexion', "", Icons.logout),
                      ],
                    );
                  } else {
                    return Column(
                      children: [
                        NavBarMobile(8, 'Connexion', LoginRoute, Icons.login),
                        NavBarMobile(9, 'Register', RegisterRoute, Icons.add),
                      ],
                    );
                  }
              }
            },
          ),
        ],
      ),
    );
  }
}
