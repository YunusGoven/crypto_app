import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
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
  bool darkmode = false;
  dynamic savedThemeMode;

  Color _selectedNavbarColor;

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
    return Container(
      color: _selectedNavbarColor ?? Colors.grey,
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
          ),
          TextButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    actions: <Widget>[
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        icon: const Icon(Icons.check),
                      ),
                    ],
                    content: SingleChildScrollView(
                      child: SizedBox(
                        height: 75,
                        child: MaterialColorPicker(
                          circleSize: 50,
                          onColorChange: (Color color) {
                            setState(() {
                              _selectedNavbarColor = color;
                            });
                          },
                          selectedColor: _selectedNavbarColor,
                          colors: const [
                            Colors.red,
                            Colors.blue,
                            Colors.green,
                            Colors.orange,
                            Colors.yellow,
                            Colors.brown,
                            Colors.cyan,
                            Colors.grey,
                            Colors.amber,
                            Colors.blueGrey,
                            Colors.indigo,
                            Colors.pink,
                            Colors.purple,
                            Colors.lime,
                            Colors.teal,
                            Colors.lightBlue,
                            Colors.lightGreen,
                            Colors.redAccent
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            child: CircleAvatar(
              child: Icon(
                Icons.color_lens,
                color: darkmode ? Colors.white : Colors.black,
              ),
              backgroundColor: _selectedNavbarColor ?? Colors.grey,
            ),
          ),
          Switch(
            value: darkmode,
            activeColor: Colors.blue,
            onChanged: (bool value) {
              if (value == true) {
                AdaptiveTheme.of(context).setDark();
                _selectedNavbarColor = Colors.grey[700];
              } else {
                AdaptiveTheme.of(context).setLight();
                _selectedNavbarColor = Colors.grey[300];
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
      ),
    );
  }
}
