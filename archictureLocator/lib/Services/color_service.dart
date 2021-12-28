import 'package:flutter/material.dart';
import 'package:localstore/localstore.dart';

class ColorService with ChangeNotifier {
  final _db = Localstore.instance;
  int primary;
  int navbar;

  ColorService({
    this.primary,
    this.navbar,
  });

  int get getprimary => primary;
  int get getnavbar => navbar;

  void changePrimaryColor(int prim) async {
    primary = prim;
    navbar ??= Colors.grey.value;
    _db
        .collection("color")
        .doc("currentuser")
        .set({'primary': prim, 'navbar': getnavbar});
    notifyListeners();
  }

  void changeNavbarColor(int nav) async {
    navbar = nav;
    primary ??= Colors.blue.value;
    _db
        .collection("color")
        .doc("currentuser")
        .set({'primary': getprimary, 'navbar': nav});
    notifyListeners();
  }
}
