import 'package:flutter/material.dart';
import 'package:hybunsinnes/locator.dart';
import 'package:hybunsinnes/routing/route_names.dart';
import 'package:hybunsinnes/routing/router.dart';
import 'package:hybunsinnes/services/navigation_service.dart';
import 'package:hybunsinnes/widgets/centered_view.dart';
import 'package:hybunsinnes/widgets/navigation_bar/navigation_bar.dart';

import '../constant.dart';

class ScreenTemplate extends StatelessWidget {
  final Widget child;
  const ScreenTemplate({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: CenteredView(
        child: Column(
          children: <Widget>[
            const NavigationBar(),
            Expanded(
              child: child,
            )
          ],
        ),
      ),
    );
  }
}
