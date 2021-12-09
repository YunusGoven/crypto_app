import 'package:flutter/material.dart';
import 'package:mvvm/Services/navigation_service.dart';
import 'package:mvvm/locator.dart';

class NavBarMobile extends StatelessWidget {
  final String text;
  final String navigationPath;
  final int id;
  final IconData icon;

  const NavBarMobile(this.id, this.text, this.navigationPath, this.icon);

  @override
  Widget build(BuildContext context) {
    return menuItem(id, text, icon, context);
  }

  Widget menuItem(int id, String text, IconData icon, BuildContext context) {
    return ListTile(
      //tileColor: id == currentPage ? Colors.grey : Colors.transparent,
      title: Row(
        children: [
          Icon(icon),
          SizedBox(
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
