import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/View/navigation_bar/navigation_bar_desktop.dart';
import 'package:mvvm/View/navigation_bar/navigation_bar_mobile.dart';
import 'package:mvvm/View/pages/centered_page.dart';

class ScreenTemplate extends StatefulWidget {
  final Widget child;
  const ScreenTemplate({Key key, this.child}) : super(key: key);

  @override
  _ScreenTemplateState createState() => _ScreenTemplateState();
}

class _ScreenTemplateState extends State<ScreenTemplate> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenwidht = screenSize.width;
    return Scaffold(
        appBar: screenwidht >= 1030
            ? null
            : AppBar(
                backgroundColor: Colors.black26,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [Text("CryptoYH")],
                ),
              ),
        drawer: screenwidht >= 1030
            ? null
            : Drawer(
                child: ListView(
                  children: [
                    SizedBox(
                      height: 120,
                      child: DrawerHeader(
                        child: Column(
                          children: const [
                            Text(
                              'HYCrypto',
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Echanger vos cryptomonnaies en toutes sécurité',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    NavigationBarMobile(drawerContext: context),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Goven & Collignon © - all rights reserved ',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    )
                  ],
                ),
              ),
        body: kIsWeb
            ? Column(
                children: <Widget>[
                  if (screenwidht >= 1030) const NavigationBarTabletDesktop(),
                  Expanded(
                    child: CenteredPage(child: widget.child),
                  ),
                ],
              )
            : widget.child);
  }
}
