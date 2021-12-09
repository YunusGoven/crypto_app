import 'package:flutter/material.dart';
import 'package:mvvm/View/widgets/navigation_bar/navigation_bar.dart';

class ScreenTemplate extends StatelessWidget {
  final Widget child;
  const ScreenTemplate({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          const NavigationBar(),
          Expanded(
            child: child,
          )
        ],
      ),
    );
  }
}
