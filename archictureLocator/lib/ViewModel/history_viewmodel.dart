import 'package:flutter/material.dart';
import 'package:mvvm/Model/models/history.dart';
import 'package:mvvm/Services/api_service.dart';
import 'package:mvvm/locator.dart';

class HistoryViewModel extends ChangeNotifier {
  final _api = locator<ApiService>();

  List<History> _history;

  List<History> get history => _history;

  Future getHistory() async {
    var results = await _api.getHistory();
    if (results is String) {
    } else {
      _history = results;
    }

    notifyListeners();
  }
}
