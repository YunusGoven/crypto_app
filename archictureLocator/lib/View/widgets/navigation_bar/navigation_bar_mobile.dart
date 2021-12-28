import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/Model/models/user.dart';
import 'package:mvvm/Routing/route_names.dart';
import 'package:mvvm/View/widgets/navigation_bar/nav_bar_item_mobile.dart';
import 'package:provider/provider.dart';

class NavigationBarMobile extends StatefulWidget {
  const NavigationBarMobile({
    Key key,
  }) : super(key: key);
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
    return Column(
      children: <Widget>[
        if (kIsWeb || user != null)
          Column(
            children: const [
              NavBarMobile(1, 'Accueil', HomeRoute, Icons.home),
              NavBarMobile(
                  2, 'Cryptos', CryptosRoute, Icons.shopping_cart_outlined),
              NavBarMobile(
                  10, 'Contact', ContactRoute, Icons.contact_support_outlined),
            ],
          ),
        if (user != null)
          Column(
            children: [
              const NavBarMobile(3, 'Historique', HistoryRoute, Icons.history),
              const NavBarMobile(
                  4, 'Classement', RankingRoute, Icons.bar_chart_rounded),
              const NavBarMobile(5, 'Notification', NotificationRoute,
                  Icons.notifications_active),
              const NavBarMobile(
                  6, 'Portfeuille', WalletRoute, Icons.account_balance_wallet),
              if (kIsWeb && user.admin)
                const NavBarMobile(
                    13, 'Admin', AdminPanelRoute, Icons.admin_panel_settings),
              const NavBarMobile(7, 'Deconnexion', "", Icons.logout),
            ],
          ),
        if (user == null)
          Column(
            children: const [
              NavBarMobile(8, 'Connexion', LoginRoute, Icons.login),
              NavBarMobile(9, 'Register', RegisterRoute, Icons.add),
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
