import 'package:flutter/material.dart';
import 'package:mvvm/Routing/route_names.dart';
import 'package:mvvm/Services/navigation_service.dart';
import 'package:mvvm/Services/userinfo_service.dart';
import 'package:mvvm/locator.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  void initState() {
    verifyIsConnected();
    super.initState();
  }

  verifyIsConnected() async {
    var isAuth = await locator<Auth>().isAuthenticate();
    if (!isAuth) {
      dispose();
      locator<NavigationService>().navigateTo(HomeRoute);
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("History"),
      ),
    );
  }
}
