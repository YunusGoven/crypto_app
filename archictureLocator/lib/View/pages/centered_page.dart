import 'package:flutter/material.dart';

class CenteredPage extends StatelessWidget {
  final Widget child;
  const CenteredPage({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 60, left: 70, right: 70, bottom: 20),
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1600), child: child),
    );
  }
}
