import 'package:flutter/material.dart';

class CenteredPage extends StatelessWidget {
  final Widget child;
  const CenteredPage({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/background.jpg"), fit: BoxFit.cover)),
      padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 60),
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1600),
        child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: child),
      ),
    );
  }
}
