import 'package:flutter/material.dart';
import 'package:mvvm/Model/models/user.dart';
import 'package:mvvm/Model/models/wallet.dart';
import 'package:mvvm/Services/api_response.dart';
import 'package:mvvm/Services/api_service.dart';
import 'package:mvvm/locator.dart';

class UserViewModel extends ChangeNotifier {
  final _api = locator<ApiService>();

  List<User> _users;

  List<User> get users => _users;

  Future getUsers() async {
    var user = await _api.getAllUsers();
    if (user == null) {
    } else {
      _users = user;
    }

    notifyListeners();
  }

  //block
  Future<ApiResponse> blockUser(String userid) async {
    var isBlock = await _api.blockUser(userid);
    if (isBlock.code == 200) getUsers();
    return isBlock;
  }

  //delete
  Future<ApiResponse> deleteUser(String userid) async {
    var isBlock = await _api.deleteUser(userid);
    if (isBlock.code == 200) getUsers();
    return isBlock;
  }

  // //new crypto
  // Future<ApiResponse> addNewCrypto(String cryptoId) async {
  //   var added = await _api.addNewCrypto(cryptoId);
  //   return added;
  // }
}
