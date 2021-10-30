import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:hybunsinnes/widgets/cryptowidget.dart';

class HomePage extends StatelessWidget {
  final String username;
  final num solde;
  const HomePage({Key key, this.username, this.solde}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
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
      ),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 1,
            ),
            Text(username),
            Text("${solde} \$")
          ],
        ),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 5,
                ),
                Text("Solde disponible : "),
                Text("${solde} \$"),
                SizedBox(
                  width: 5,
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            CryptoWidget(
              currentValue: 53397.85,
              imageurl:
                  "https://s3.us-east-2.amazonaws.com/nomics-api/static/images/currencies/btc.svg?url=https%3A%2F%2Fs3.us-east-2.amazonaws.com%2Fnomics-api%2Fstatic%2Fimages%2Fcurrencies%2Fbtc.svg&w=48&q=75",
              name: "BITCOIN",
              percent: 0.96,
            ),
            CryptoWidget(
              currentValue: 4316.36,
              imageurl:
                  "https://s3.us-east-2.amazonaws.com/nomics-api/static/images/currencies/eth.svg?url=https%3A%2F%2Fs3.us-east-2.amazonaws.com%2Fnomics-api%2Fstatic%2Fimages%2Fcurrencies%2Feth.svg&w=48&q=75",
              name: "ETHERUM",
              percent: -1.37,
            )
          ],
        ),
      ),
    );
  }
}
