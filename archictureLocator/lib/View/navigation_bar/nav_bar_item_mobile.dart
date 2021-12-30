import 'package:flutter/material.dart';
import 'package:mvvm/Services/navigation_service.dart';
import 'package:mvvm/locator.dart';

class NavBarMobile extends StatelessWidget {
  final String text;
  final String navigationPath;
  final BuildContext drawerContext;
  final IconData icon;

  // ignore: use_key_in_widget_constructors
  const NavBarMobile(
      this.drawerContext, this.text, this.navigationPath, this.icon);

  @override
  Widget build(BuildContext context) {
    return menuItem(drawerContext, text, icon);
  }

  Widget menuItem(BuildContext drawerContext, String text, IconData icon) {
    return ListTile(
      title: Row(
        children: [
          Icon(icon),
          const SizedBox(
            width: 60,
          ),
          Text(text),
        ],
      ),
      onTap: () {
        locator<NavigationService>().navigateTo(navigationPath);
        Navigator.of(drawerContext).pop();
      },
    );
  }
}
