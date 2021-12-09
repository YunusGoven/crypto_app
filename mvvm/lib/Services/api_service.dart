import 'dart:convert';
import 'dart:io';

// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:mvvm/Model/models/crypto.dart';
import 'package:mvvm/Model/models/history.dart';
import 'package:mvvm/Model/models/notification.dart';
import 'package:mvvm/Model/models/transaction.dart';
import 'package:mvvm/Model/models/user.dart';
import 'package:mvvm/Model/models/wallet.dart';

class ApiService {
  //final url = "http://127.0.0.1:44336/api";
  // final url = "http://10.0.2.2:44336/api";
  final url = "https://porthos-intra.cg.helmo.be/grGU/api";
  final Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'text/plain',
  };

  final Map<String, String> connectedHeaders = {
    'Content-type': 'application/json',
    'Accept': 'text/plain',
    'Authorization':
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVc2VySWQiOiJiMmZiZGEyZS1jMGNiLTQzMDEtODc5NC1lZDEwOGY2MDFlODAiLCJVc2VyTmFtZSI6ImEiLCJVc2VyU3VybmFtZSI6ImEiLCJVc2VyUHNldWRvIjoic3RyaW5nIiwiVXNlck1haWwiOiJzdHJpbmdAZ21haWwuY29tIiwiVXNlclNvbGRlIjoiOTM0OSIsIm5iZiI6MTYzNzE0NjMyNywiZXhwIjoxNjM3MTQ5OTI3LCJpYXQiOjE2MzcxNDYzMjd9.RuyRUaFXYpDRwGKgwKM9KF3RDXpNus-gQtD01tgsv08'
  };

  //All crypto
  Future<List<Crypto>> getAllCryptos(int number) async {
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

  //Detail crypto
  Future<Crypto> getCrypto(String cryptoId) async {
    var c_url = url + '/Crypto/${cryptoId}';
    Crypto cryptoM = null;
    var uri = Uri.parse(c_url);
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      var crypto = json.decode(response.body);
      cryptoM = Crypto.fromJson(crypto);
      return cryptoM;
    } else {
      return null;
    }
  }

  //Connexion
  Future<String> connection(String username, String password) async {
    //var identifier = await FirebaseMessaging.instance.getToken();

    var c_url = url + '/Users/SignIn';
    var uri = Uri.parse(c_url);
    var hashmdp = password;
    var response = await http.post(uri,
        headers: headers,
        body: '{"pseudo" : "${username}", "password": "${hashmdp}" }');
    if (response.statusCode == 200) {
      ConnectedUser user = ConnectedUser.fromJson(jsonDecode(response.body));
      return "Connection Succesful";
    } else {
      return response.body;
    }
  }

  //Register
  Future<String> register(String username, String password, String mail) async {
    var hashmdp = password;
    RegisterUser um = RegisterUser(
        "_firstName", "_surname", DateTime.now(), mail, username, hashmdp);
    var c_url = url + '/Users/Register';
    var uri = Uri.parse(c_url);
    var response =
        await http.post(uri, headers: headers, body: jsonEncode(um.toJson()));
    if (response.statusCode == 200) {
      return "Registration Succesful";
    } else {
      return response.body;
    }
  }

  //Ranking
  Future<List<ClassementUser>> getRanking() async {
    var c_url = url + '/Users/Classement';
    var uri = Uri.parse(c_url);
    var response = await http.get(uri, headers: connectedHeaders);
    if (response.statusCode == 200) {
      var users = (json.decode(response.body) as List);
      var usersList = users.map((res) => ClassementUser.fromJson(res)).toList();
      return usersList;
    } else {
      return List.empty();
    }
  }

  //History
  Future<List<History>> getHistory() async {
    var c_url = url + '/Transaction/Historique';
    var uri = Uri.parse(c_url);
    var response = await http.get(uri, headers: connectedHeaders);
    if (response.statusCode == 200) {
      var history = (json.decode(response.body) as List);
      var historyList = history.map((res) => History.fromJson(res)).toList();
      return historyList;
    } else {
      return List.empty();
    }
  }

  //Notification
  Future<List<NotificationModel>> getNotification() async {
    var c_url = url + '/Notifications';
    var uri = Uri.parse(c_url);
    var response = await http.get(uri, headers: connectedHeaders);
    if (response.statusCode == 200) {
      var notifications = (json.decode(response.body) as List);
      var notificationsList =
          notifications.map((res) => NotificationModel.fromJson(res)).toList();
      return notificationsList;
    } else {
      return List.empty();
    }
  }

  //Disable Notification
  Future<bool> disableNotification(String crytpoId) async {
    var body = '"${crytpoId}"';
    var c_url = url + '/Wallets/DisableNotification';
    var uri = Uri.parse(c_url);
    var response = await http.post(uri, headers: connectedHeaders, body: body);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  //Wallet
  Future<List<Wallet>> getWallet() async {
    var c_url = url + '/Wallets';
    var uri = Uri.parse(c_url);
    var response = await http.get(uri, headers: connectedHeaders);
    if (response.statusCode == 200) {
      var wallets = (json.decode(response.body) as List);
      var walletsList = wallets.map((res) => Wallet.fromJson(res)).toList();
      return walletsList;
    } else {
      return List.empty();
    }
  }

  //Buy
  Future<String> buy(String cryptoId, num number, num currentValue) async {
    var body =
        '{"CryptoId":"${cryptoId}", "Number":${number}, "CurrentValue": ${currentValue}, "Type" : "B"}';
    var c_url = url + '/Transaction';
    var uri = Uri.parse(c_url);
    var response = await http.post(uri, headers: connectedHeaders, body: body);
    if (response.statusCode == 200) {
      return "Ok ";
    } else {
      return "Une erreur s'est produite";
    }
  }

  //Sell
  Future<String> sell(String cryptoId, num number, num currentValue) async {
    var body =
        '{"CryptoId":"${cryptoId}",  "Number":${number}, "CurrentValue": ${currentValue}, "Type" : "S"}';
    var c_url = url + '/Transaction';
    var uri = Uri.parse(c_url);
    var response = await http.post(uri, headers: connectedHeaders, body: body);
    if (response.statusCode == 200) {
      return "Ok ";
    } else {
      return "Une erreur s'est produite";
    }
  }

  //Send Message
  Future<String> sendMessage(String cryptoId, String message) async {
    var body = '{"Message":"${message}", "CryptoId":${cryptoId}}';
    var c_url = url + '/Messages';
    var uri = Uri.parse(c_url);
    var response = await http.post(uri, headers: connectedHeaders, body: body);
    if (response.statusCode == 200) {
      return "Ok ";
    } else {
      return "Une erreur s'est produite";
    }
  }

  //Supprimmer notifications
  Future<bool> deleteNotification(String notificationId) async {
    var c_url = url + '/Notifications/${notificationId}';
    var uri = Uri.parse(c_url);
    var response = await http.delete(uri, headers: connectedHeaders);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
