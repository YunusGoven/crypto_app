import 'package:flutter/material.dart';
import 'package:hybunsinnes/model/crypto.dart';
import 'package:hybunsinnes/pages/realclassement.dart';
import 'package:hybunsinnes/pages/realdetailpage.dart';
import 'locator.dart';
import 'model/user.dart';

void main() {
  setupLocator();
  runApp(const MyApp(
    solde: 10000,
    username: 'Joueur 456',
  ));
}

class MyApp extends StatefulWidget {
  final String username;
  final num solde;
  const MyApp({Key key, @required this.username, @required this.solde})
      : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          drawer: Drawer(
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
                Text(widget.username),
                Text("${widget.solde} \$")
              ],
            ),
            backgroundColor: Colors.black,
          ),
          // body: ClassementPage(users: [
          //   User("user1", "1@", "user1", 10000),
          //   User("user2", "2@", "user2", 100000),
          //   User("user3", "3@", "user3", 7000),
          //   User("user4", "4@", "user4", 5500),
          //   User("user5", "5@", "user5", 15000),
          //   User("user6", "6@", "user6", 10000),
          //   User("user7", "7@", "user7", 8000),
          //   User("user8", "8@", "user8", 100),
          // ]),
          body: DetailPage(
            crypto: Crypto(
                "Bitcoin",
                "BTC",
                41133.80,
                -0.10,
                40133.80,
                42122.56,
                41238.80,
                41233.80,
                "https://s3.us-east-2.amazonaws.com/nomics-api/static/images/currencies/eth.svg?url=https%3A%2F%2Fs3.us-east-2.amazonaws.com%2Fnomics-api%2Fstatic%2Fimages%2Fcurrencies%2Feth.svg&w=48&q=75"),
          ),
        ));
  }
}
