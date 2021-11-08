import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hybunsinnes/model/user.dart';

class ApiManager {
  Future<dynamic> connecction(String pseudo, String password) async {
    var url = Uri.parse('http://10.0.2.2:24521/api/Users/SignIn');

    final response = await http.post(url,
        headers: {"Accept": "application/json"},
        body: {"pseudo": pseudo, "password": password});

    print(response.statusCode);

    return 'fetch error';
  }
}
