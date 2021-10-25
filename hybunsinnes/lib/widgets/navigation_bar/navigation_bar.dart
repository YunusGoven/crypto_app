import 'package:flutter/material.dart';
import 'package:hybunsinnes/widgets/navigation_bar/navigation_bar_mobile.dart';
import 'package:hybunsinnes/widgets/navigation_bar/navigation_bar_web.dart';
import 'package:responsive_builder/responsive_builder.dart';

class NavigationBar extends StatelessWidget {
  const NavigationBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: const NavigationBarMobile(),
      tablet: const NavigationBarWeb(),
    );
  }
}
