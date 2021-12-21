import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/Routing/route_names.dart';
import 'package:mvvm/Services/userinfo_service.dart';
import 'package:mvvm/View/pages/home_page.dart';
import 'package:mvvm/locator.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName,
      {Map<String, String> queryParams}) {
    if (routeName.isEmpty) {
      locator<Auth>().disconnect();
      routeName = kIsWeb ? HomeRoute : LoginRoute;
    }
    if (queryParams != null) {
      routeName = Uri(path: routeName, queryParameters: queryParams).toString();
    }

    return navigatorKey.currentState.pushReplacementNamed(routeName);
  }

  void goBack() {
    return navigatorKey.currentState.pop();
  }
}
