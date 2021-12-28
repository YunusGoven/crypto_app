import 'package:flutter/material.dart';
import 'package:localstore/localstore.dart';

class ThemeService with ChangeNotifier {
  ThemeData _selectedTheme;
  final _db = Localstore.instance;

  ThemeService({
    bool isDarkMode,
  }) {
    _selectedTheme = isDarkMode ? dark : light;
  }
  ThemeData light = ThemeData.light();
  ThemeData dark = ThemeData.dark();

  void swapDarkMode() async {
    if (_selectedTheme == dark) {
      _selectedTheme = light;
      _db.collection("theme").doc("currentuser").set({'isDark': false});
    } else {
      _selectedTheme = dark;
      _db.collection("theme").doc("currentuser").set({'isDark': true});
    }
    notifyListeners();
  }

  ThemeData get getTheme => _selectedTheme;
}
