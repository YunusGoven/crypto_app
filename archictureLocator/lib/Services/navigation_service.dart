import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/Routing/route_names.dart';
import 'package:mvvm/Services/firebase_authentification.dart';
import 'package:mvvm/Services/userinfo_service.dart';
import 'package:mvvm/locator.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final FirebaseAuthentification _firebaseAuthentification =
      FirebaseAuthentification();

  Future<dynamic> navigateTo(String routeName,
      {Map<String, String> queryParams}) async {
    if (routeName.isEmpty) {
      locator<Auth>().disconnect();
      await _firebaseAuthentification.signOut();

      routeName = kIsWeb ? HomeRoute : LoginRoute;
    }
    if (queryParams != null) {
      routeName = Uri(path: routeName, queryParameters: queryParams).toString();
    }
    return navigatorKey.currentState.popAndPushNamed(routeName);
  }

  void goBack() {
    return navigatorKey.currentState.pop();
  }
}
