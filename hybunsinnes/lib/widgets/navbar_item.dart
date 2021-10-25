import 'package:flutter/material.dart';
import 'package:hybunsinnes/locator.dart';
import 'package:hybunsinnes/model/navbar_item_model.dart';
import 'package:hybunsinnes/services/navigation_service.dart';
import 'package:provider/provider.dart';

class NavBarItem extends StatelessWidget {
  final String title;
  final String navigationPath;
  final IconData icon;
  // ignore: use_key_in_widget_constructors
  const NavBarItem(this.title, this.navigationPath, {this.icon});

  @override
  Widget build(BuildContext context) {
    var model = NavBarItemModel(
      title: title,
      navigationPath: navigationPath,
      iconData: icon,
    );
    return GestureDetector(
      onTap: () {
        locator<NavigationService>().navigateTo(navigationPath);
      },
      child: Provider.value(
        value: model,
        child: Padding(
          padding: const EdgeInsets.only(left: 30, top: 60),
          child: Text(
            model.title,
            style: const TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
