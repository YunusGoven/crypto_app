import 'package:flutter/material.dart';
import 'package:hybunsinnes/widgets/centered_view.dart';
import 'package:hybunsinnes/widgets/navigation_bar/navigation_bar.dart';

import '../constant.dart';

class ScreenTemplate extends StatelessWidget {
  final Widget child;
  const ScreenTemplate({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
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
