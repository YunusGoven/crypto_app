import 'package:flutter/material.dart';
import 'package:hybunsinnes/routing/route_names.dart';
import 'package:hybunsinnes/widgets/navbar_item.dart';
import 'navbar_logo.dart';

class NavigationBarWeb extends StatelessWidget {
  const NavigationBarWeb({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const NavBarLogo(),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: const <Widget>[
              NavBarItem('home', HomeRoute),
              SizedBox(
                width: 60,
              ),
              // NavBarItem('About', AboutRoute),
            ],
          )
        ],
      ),
    );
  }
}
