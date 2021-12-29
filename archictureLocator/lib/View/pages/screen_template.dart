import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/View/pages/centered_page.dart';
import 'package:mvvm/View/widgets/navigation_bar/navigation_bar_desktop.dart';
import 'package:mvvm/View/widgets/navigation_bar/navigation_bar_mobile.dart';

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
        appBar: screenwidht >= 1004
            ? null
            : AppBar(
                backgroundColor: Colors.black26,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [Text("CryptoYH")],
                ),
              ),
        drawer: screenwidht >= 1004
            ? null
            : Drawer(
                child: ListView(
                  children: [
                    const DrawerHeader(
                      decoration: BoxDecoration(),
                      child: Text(
                        'HYCrypto',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    NavigationBarMobile(drawerContext: context),
                  ],
                ),
              ),
        body: kIsWeb
            ? Column(
                children: <Widget>[
                  if (screenwidht >= 1004) const NavigationBarTabletDesktop(),
                  Expanded(
                    child: CenteredPage(child: widget.child),
                  ),
                ],
              )
            : widget.child);
  }
}
