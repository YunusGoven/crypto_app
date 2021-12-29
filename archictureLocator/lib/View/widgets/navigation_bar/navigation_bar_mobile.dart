import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/Model/models/user.dart';
import 'package:mvvm/Routing/route_names.dart';
import 'package:mvvm/View/widgets/navigation_bar/nav_bar_item_mobile.dart';
import 'package:provider/provider.dart';

class NavigationBarMobile extends StatefulWidget {
  final BuildContext drawerContext;
  const NavigationBarMobile({Key key, this.drawerContext}) : super(key: key);
  @override
  _NavigationBarMobileState createState() => _NavigationBarMobileState();
}

class _NavigationBarMobileState extends State<NavigationBarMobile> {
  bool darkmode = false;
  dynamic savedThemeMode;

  @override
  void initState() {
    super.initState();
    getCurrentTheme();
  }

  Future getCurrentTheme() async {
    savedThemeMode = await AdaptiveTheme.getThemeMode();
    if (savedThemeMode.toString() == 'AdaptiveThemeMode.dark') {
      setState(() {
        darkmode = true;
      });
    } else {
      setState(() {
        darkmode = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    BuildContext drawerContext = widget.drawerContext;
    return Column(
      children: <Widget>[
        if (kIsWeb || user != null)
          Column(
            children: [
              NavBarMobile(drawerContext, 'Accueil', HomeRoute, Icons.home),
              NavBarMobile(drawerContext, 'Cryptos', CryptosRoute,
                  Icons.shopping_cart_outlined),
              NavBarMobile(drawerContext, 'Contact', ContactRoute,
                  Icons.contact_support_outlined),
            ],
          ),
        if (user != null)
          Column(
            children: [
              NavBarMobile(
                  drawerContext, 'Historique', HistoryRoute, Icons.history),
              NavBarMobile(drawerContext, 'Classement', RankingRoute,
                  Icons.bar_chart_rounded),
              NavBarMobile(drawerContext, 'Notification', NotificationRoute,
                  Icons.notifications_active),
              NavBarMobile(drawerContext, 'Portfeuille', WalletRoute,
                  Icons.account_balance_wallet),
              NavBarMobile(drawerContext, 'Deconnexion', "", Icons.logout),
            ],
          ),
        if (user == null)
          Column(
            children: [
              NavBarMobile(drawerContext, 'Connexion', LoginRoute, Icons.login),
              NavBarMobile(drawerContext, 'Register', RegisterRoute, Icons.add),
            ],
          ),
        Switch(
          value: darkmode,
          activeColor: Colors.blue,
          onChanged: (bool value) {
            if (value == true) {
              AdaptiveTheme.of(context).setDark();
            } else {
              AdaptiveTheme.of(context).setLight();
            }
            setState(() {
              darkmode = value;
            });
          },
        ),
        darkmode
            ? const Icon(
                Icons.dark_mode,
                color: Colors.white,
              )
            : const Icon(
                Icons.light_mode,
                color: Colors.black,
              )
      ],
    );
  }
}
