import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mvvm/Model/models/crypto.dart';
import 'package:mvvm/Model/models/user.dart';

class ApiService {
  //final url = "http://127.0.0.1:44336/api";
  final url = "http://10.0.2.2:44336/api";
  final Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'text/plain'
    //'Authorization': 'Bearer token'
  };

  Future<List<Crypto>> getAllCryptos() async {
    var c_url = url + "/Crypto";
    List<Crypto> cryptos = List.empty();
    var uri = Uri.parse(c_url);
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var crypto = (json.decode(response.body) as List);
      cryptos = crypto.map((apod) => Crypto.fromJson(apod)).toList();
      return cryptos;
    } else {
      return List.empty();
    }
  }

  Future<Crypto> getCrypto(String cryptoId) async {
    var c_url = url + '/Crypto/${cryptoId}';
    Crypto cryptoM = null;
    var uri = Uri.parse(c_url);
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      var crypto = json.decode(response.body) as List;
      cryptoM = crypto.map((apod) => Crypto.fromJson(apod)).toList().first;
      return cryptoM;
    } else {
      return null;
    }
  }

  Future<User> connection(String username, String password) async {
    var c_url = url + '/Users/SignIn';
    var uri = Uri.parse(c_url);
    var hashmdp = password;
    var response = await http.post(uri,
        headers: headers,
        body: '{"pseudo" : "${username}", "password", "${hashmdp}"}');
    if (response.statusCode == 200) {
      print(response.body);
    }
  }
}
