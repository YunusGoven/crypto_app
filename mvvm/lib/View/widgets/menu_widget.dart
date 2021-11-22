import 'package:flutter/material.dart';
import 'package:mvvm/View/pages/wallet_page.dart';

class Menu extends StatelessWidget {
  final dynamic context;
  const Menu({Key key, this.context}) : super(key: key);

  @override
  Widget build(BuildContext ctx) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.black,
            ),
            child: Column(children: [
              Image.asset(
                "assets/images/logo.jpg",
                height: 100,
                width: 100,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'HYCrypto',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ]),
          ),
          ListTile(
            title: Row(
              children: const [
                Icon(Icons.home),
                SizedBox(
                  width: 60,
                ),
                Text("Accueil"),
              ],
            ),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Row(
              children: const [
                Icon(Icons.shopping_cart_outlined),
                SizedBox(
                  width: 60,
                ),
                Text("Cryptos"),
              ],
            ),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Row(
              children: const [
                Icon(Icons.account_balance_wallet),
                SizedBox(
                  width: 60,
                ),
                Text("Wallet"),
              ],
            ),
            onTap: () {
              // Update the state of the app

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => (const WalletPage())),
              );
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Row(
              children: const [
                Icon(Icons.history),
                SizedBox(
                  width: 60,
                ),
                Text("Historique"),
              ],
            ),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              //global.header = "Historique";

              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Row(
              children: const [
                Icon(Icons.bar_chart_rounded),
                SizedBox(
                  width: 60,
                ),
                Text("Classement"),
              ],
            ),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Row(
              children: const [
                Icon(Icons.notifications_active),
                SizedBox(
                  width: 60,
                ),
                Text("Notifications"),
              ],
            ),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Row(
              children: const [
                Icon(Icons.person_outline),
                SizedBox(
                  width: 60,
                ),
                Text("Profil"),
              ],
            ),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Row(
              children: const [
                Icon(Icons.logout),
                SizedBox(
                  width: 60,
                ),
                Text("Deconnexion"),
              ],
            ),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
