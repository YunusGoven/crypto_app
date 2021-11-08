import 'package:flutter/material.dart';
import 'package:hybunsinnes/model/crypto.dart';
import 'package:hybunsinnes/model/notification.dart';
import 'package:hybunsinnes/model/transaction.dart';
import 'package:hybunsinnes/model/wallet.dart';
import 'package:hybunsinnes/pages/realclassement.dart';
import 'package:hybunsinnes/pages/realdetailpage.dart';
import 'package:hybunsinnes/pages/realhistorypage.dart';
import 'package:hybunsinnes/pages/reallogin.dart';
import 'package:hybunsinnes/pages/realnotifactionpage.dart';
import 'package:hybunsinnes/pages/realregister.dart';
import 'package:hybunsinnes/pages/realtransactiondonepage.dart';
import 'package:hybunsinnes/pages/realwalletpage.dart';
import 'locator.dart';
import 'model/user.dart';
import 'global.dart' as global;

void main() {
  setupLocator();
  global.user = User("Joueur 456", "456@gmail.com", "Joueur 456", 10000);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        drawer: global.user != null ? WidgetDrawer(context) : null,
        appBar: global.user != null
            ? AppBar(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 1,
                    ),
                    Text(global.header),
                    Text("${global.user.solde} \$")
                  ],
                ),
                backgroundColor: Colors.black,
              )
            : null,
        // body: SafeArea(
        //   child: LoginPage(),
        // ),

        // body: SafeArea(
        //   child: RegisterPage(),
        // ),

        // body: SafeArea(
        //   child: ClassementPage(users: [
        //     User("user1", "1@", "user1", 10000),
        //     User("user2", "2@", "user2", 100000),
        //     User("user3", "3@", "user3", 7000),
        //     User("user4", "4@", "user4", 5500),
        //     User("user5", "5@", "user5", 15000),
        //     User("user6", "6@", "user6", 10000),
        //     User("user7", "7@", "user7", 8000),
        //     User("user8", "8@", "user8", 100),
        //   ]),
        // )

        // body: SafeArea(
        //   child: DetailPage(
        //     crypto: Crypto(
        //         "Bitcoin",
        //         "BTC",
        //         41133.80,
        //         -0.10,
        //         40133.80,
        //         42122.56,
        //         41238.80,
        //         41233.80,
        //         "https://s3.us-east-2.amazonaws.com/nomics-api/static/images/currencies/eth.svg?url=https%3A%2F%2Fs3.us-east-2.amazonaws.com%2Fnomics-api%2Fstatic%2Fimages%2Fcurrencies%2Feth.svg&w=48&q=75"),
        //   ),
        // )

        // body: SafeArea(
        //   child: WalletPage(
        //     wallets: [
        //       Wallet(
        //           "https://s3.us-east-2.amazonaws.com/nomics-api/static/images/currencies/btc.svg?url=https%3A%2F%2Fs3.us-east-2.amazonaws.com%2Fnomics-api%2Fstatic%2Fimages%2Fcurrencies%2Fbtc.svg&w=48&q=75",
        //           0.254441,
        //           "Bitcoin",
        //           "BTC"),
        //       Wallet(
        //           "https://s3.us-east-2.amazonaws.com/nomics-api/static/images/currencies/eth.svg?url=https%3A%2F%2Fs3.us-east-2.amazonaws.com%2Fnomics-api%2Fstatic%2Fimages%2Fcurrencies%2Feth.svg&w=48&q=75",
        //           10.254441,
        //           "Etherum",
        //           "ETH")
        //     ],
        //   ),
        // )

        // body: SafeArea(
        //   child: HistoryPage(
        //     transactions: [
        //       Transaction("btc", 41133.80, 41133.80, 1, 'ACHAT',
        //           DateTime(2020, 02, 10)),
        //       Transaction(
        //           "eth",
        //           50000,
        //           21459.22,
        //           2.33,
        //           'ACHAT',
        //           DateTime(
        //             2020,
        //             02,
        //             10,
        //           )),
        //       Transaction("btc", 0.8, 41133.80, 32907.04, 'VENTE',
        //           DateTime(2020, 02, 10)),
        //       Transaction("eth", 1, 21459.22, 21459.22, 'VENTE',
        //           DateTime(2020, 02, 10)),
        //     ],
        //   ),
        // )

        // body: SafeArea(
        //   child: TransactionDonePage(
        //     crypto: Crypto(
        //         "Bitcoin",
        //         "BTC",
        //         41133.80,
        //         -0.10,
        //         40133.80,
        //         42122.56,
        //         41238.80,
        //         41233.80,
        //         "https://s3.us-east-2.amazonaws.com/nomics-api/static/images/currencies/eth.svg?url=https%3A%2F%2Fs3.us-east-2.amazonaws.com%2Fnomics-api%2Fstatic%2Fimages%2Fcurrencies%2Feth.svg&w=48&q=75"),
        //     type: "VENTE",
        //     wallet: Wallet(
        //         "https://s3.us-east-2.amazonaws.com/nomics-api/static/images/currencies/eth.svg?url=https%3A%2F%2Fs3.us-east-2.amazonaws.com%2Fnomics-api%2Fstatic%2Fimages%2Fcurrencies%2Feth.svg&w=48&q=75",
        //         0.25,
        //         "Bitcoin",
        //         "BTC"),
        //   ),
        // )

        body: SafeArea(
          child: NotificationPage(
            notifications: [
              NotificationModel(
                "a augmenté de 1%",
                true,
                Crypto(
                    "Bitcoin",
                    "BTC",
                    41133.80,
                    -0.10,
                    40133.80,
                    42122.56,
                    41238.80,
                    41233.80,
                    "https://nomics.com/_next/image?url=https%3A%2F%2Fs3.us-east-2.amazonaws.com%2Fnomics-api%2Fstatic%2Fimages%2Fcurrencies%2Fbtc.svg&w=48&q=75"),
              ),
              NotificationModel(
                "a augmenté de 2%",
                true,
                Crypto(
                    "Ethereum",
                    "ETH",
                    41133.80,
                    -0.10,
                    40133.80,
                    42122.56,
                    41238.80,
                    41233.80,
                    "https://s3.us-east-2.amazonaws.com/nomics-api/static/images/currencies/eth.svg?url=https%3A%2F%2Fs3.us-east-2.amazonaws.com%2Fnomics-api%2Fstatic%2Fimages%2Fcurrencies%2Feth.svg&w=48&q=75"),
              ),
              NotificationModel(
                "a diminué de 1%",
                false,
                Crypto(
                    "Tether",
                    "USDT",
                    41133.80,
                    -0.10,
                    40133.80,
                    42122.56,
                    41238.80,
                    41233.80,
                    "https://nomics.com/_next/image?url=https%3A%2F%2Fs3.us-east-2.amazonaws.com%2Fnomics-api%2Fstatic%2Fimages%2Fcurrencies%2Fusdt.svg&w=32&q=75"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

WidgetDrawer(context) {
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
            global.header = "Historique";

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
