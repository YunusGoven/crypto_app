import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/View/widgets/navigation_bar/navigation_bar.dart';
import 'package:mvvm/View/widgets/navigation_bar/navigation_bar_desktop.dart';
import 'package:mvvm/View/widgets/navigation_bar/navigation_bar_mobile.dart';

class ScreenTemplate extends StatelessWidget {
  final Widget child;
  const ScreenTemplate({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kIsWeb
          ? null
          : AppBar(
              backgroundColor: Colors.black26,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text("Pala")],
              ),
            ),
      drawer: kIsWeb
          ? null
          : Drawer(
              child: ListView(
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.black26,
                    ),
                    child: Text(
                      'HYCrypto',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  NavigationBarMobile()
                ],
              ),
            ),
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          //if (kIsWeb) const NavigationBar(),
          if (kIsWeb) NavigationBarTabletDesktop(),
          Expanded(
            child: child,
          )
        ],
      ),
    );
  }
}