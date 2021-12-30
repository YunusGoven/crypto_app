import 'package:flutter/material.dart';
import 'package:mvvm/Model/user.dart';
import 'package:mvvm/Services/api_service.dart';
import 'package:mvvm/locator.dart';

class ClassementViewModel extends ChangeNotifier {
  final _api = locator<ApiService>();

  List<ClassementUser> _users;

  List<ClassementUser> get users => _users;

  Future getClassement() async {
    List<ClassementUser> result = await _api.getRanking();

    _users = result;

    notifyListeners();
  }
}
