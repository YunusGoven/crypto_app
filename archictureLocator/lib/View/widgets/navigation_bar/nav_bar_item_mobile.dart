import 'package:flutter/material.dart';
import 'package:mvvm/Services/navigation_service.dart';
import 'package:mvvm/locator.dart';

class NavBarMobile extends StatelessWidget {
  final String text;
  final String navigationPath;
  final int id;
  final IconData icon;

  // ignore: use_key_in_widget_constructors
  const NavBarMobile(this.id, this.text, this.navigationPath, this.icon);

  @override
  Widget build(BuildContext context) {
    return menuItem(id, text, icon);
  }

  Widget menuItem(int id, String text, IconData icon) {
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
      },
    );
  }
}
