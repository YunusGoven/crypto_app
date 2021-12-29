// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:mvvm/Model/models/crypto.dart';
import 'package:mvvm/Model/models/history.dart';
import 'package:mvvm/Model/models/notification.dart';
import 'package:mvvm/Model/models/user.dart';
import 'package:mvvm/Model/models/wallet.dart';
import 'package:mvvm/Services/api_response.dart';
import 'package:mvvm/Services/firebase_authentification.dart';
import 'package:mvvm/Services/userinfo_service.dart';
import 'package:mvvm/locator.dart';

class ApiService {
  final _auth = locator<Auth>();
  final FirebaseAuthentification _firebaseAuthentification =
      FirebaseAuthentification();
  // final url = "http://127.0.0.1:44336/api";
  // final url = "http://10.0.2.2:44336/api";
  final url = "https://porthos-intra.cg.helmo.be/grGU/api";
  final Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'text/plain',
  };

  Map<String, String> connectedHeaders = {
    'Content-type': 'application/json',
    'Accept': 'text/plain',
    'Authorization':
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVc2VySWQiOiIzZmE4NWY2NC01NzE3LTQ1NjItYjNmYy0yYzk2M2Y2NmFmYTYiLCJVc2VyTmFtZSI6Inl1bnVzIiwiVXNlclN1cm5hbWUiOiJnb3ZlbiIsIlVzZXJQc2V1ZG8iOiJzdHJpbmciLCJVc2VyTWFpbCI6InlzQGdtYWlsLmNvbSIsIlVzZXJTb2xkZSI6Ijk1MDAiLCJuYmYiOjE2MzgxODk1NjMsImV4cCI6MTYzODE5MzE2MywiaWF0IjoxNjM4MTg5NTYzfQ.LEe0t8x2ILS8qiqgGYVLk7cvxt9gJI_vdZmYMdgHVKA'
  };
  //Wallet
  Future<List<Wallet>> getWallet() async {
    try {
      var c_url = url + '/Wallets';
      var uri = Uri.parse(c_url);
      connectedHeaders = {
        'Content-type': 'application/json',
        'Accept': 'text/plain',
        'Authorization': 'Bearer ${await _auth.token()}'
      };
      var response = await http.get(uri, headers: connectedHeaders);
      if (response.statusCode == 200) {
        var wallets = (json.decode(response.body) as List);
        var walletsList = wallets.map((res) => Wallet.fromJson(res)).toList();
        return walletsList;
      } else {
        return List.empty();
      }
    } on Exception {
      return null;
    }
  }

  //All crypto
  Future<List<Crypto>> getAllCryptos(int number) async {
    try {
      var c_url = url + "/Crypto";
      List<Crypto> cryptos = List.empty();
      var uri = Uri.parse(c_url);
      var response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        var crypto = (json.decode(response.body) as List);
        cryptos = crypto.map((apod) {
          return Crypto.fromJson(apod);
        }).toList();
        return number == -1 ? cryptos : cryptos.take(number).toList();
      } else {
        return List.empty();
      }
    } on SocketException {
      throw const SocketException('No Internet connection');
    } on TimeoutException {
      throw TimeoutException('Delai dépassé');
    } on Exception {
      return null;
    }
  }

  Future<List<User>> getAllUsers() async {
    try {
      var c_url = url + '/Users';
      var uri = Uri.parse(c_url);
      connectedHeaders = {
        'Content-type': 'application/json',
        'Accept': 'text/plain',
        'Authorization': 'Bearer ${await _auth.token()}'
      };
      var response = await http.get(uri, headers: connectedHeaders);
      if (response.statusCode == 200) {
        var users = (json.decode(response.body) as List);
        var usersList = users.map((res) => User.fromJson(res)).toList();
        return usersList;
      } else {
        return List.empty();
      }
    } on Exception {
      return List.empty();
    }
  }

  //Detail crypto
  Future<Crypto> getCrypto(String cryptoId) async {
    var c_url = url + '/Crypto/$cryptoId';
    Crypto cryptoM;
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

  Future<ApiResponse> connectiongoogle() async {
    try {
      var googleToken = await _firebaseAuthentification.signInWithGoogle();
      //var identifier = await FirebaseMessaging.instance.getToken();

      var identifier = FirebaseMessaging.instance;
      var notsett = await identifier.getNotificationSettings();
      String body;
      if (notsett.authorizationStatus == AuthorizationStatus.authorized) {
        var token = await identifier.getToken();
        print(token);
        body = '{"deviceId": "${token}", "googleToken" :"${googleToken}" }';
      } else {
        body = '{"googleToken" :"${googleToken}" }';
      }

      var c_url = url + '/Users/SignIn';
      var uri = Uri.parse(c_url);
      var response = await http.post(uri, headers: headers, body: body);
      if (response.statusCode == 200) {
        //await _firebaseAuthentification.signOut();
        //await _firebaseAuthentification.signInAnonymously();
        ConnectedUser user = ConnectedUser.fromJson(jsonDecode(response.body));
        _auth.addToLocal(jsonDecode(response.body));
        connectedHeaders = {
          'Content-type': 'application/json',
          'Accept': 'text/plain',
          'Authorization': 'Bearer ${user.token}'
        };
      }
      return ApiResponse(code: response.statusCode, value: response.body);
    } catch (exception) {
      return const ApiResponse(
          code: 404, value: "Une erreur est survenu lors de l'identification");
    }
  }

  //Connexion
  Future<ApiResponse> connection(String username, String password) async {
    try {
      var identifier = FirebaseMessaging.instance;
      var notsett = await identifier.getNotificationSettings();
      String body;
      if (notsett.authorizationStatus == AuthorizationStatus.authorized) {
        var token = await identifier.getToken();
        print(token);
        body =
            '{"pseudo" : "${username}", "password": "${password}" ,"deviceId": "$token" }';
      } else {
        body = '{"pseudo" : "${username}", "password": "${password}" }';
      }
      var c_url = url + '/Users/SignIn';
      var uri = Uri.parse(c_url);
      var response = await http.post(uri, headers: headers, body: body);
      if (response.statusCode == 200) {
        print(response.statusCode);
        await _firebaseAuthentification.signOut();
        ConnectedUser user = ConnectedUser.fromJson(jsonDecode(response.body));
        _auth.addToLocal(jsonDecode(response.body));

        var userCo = await _auth.getUser();

        var co = await _firebaseAuthentification.signInWithEmailAndPass(
            userCo.mail, password);
        connectedHeaders = {
          'Content-type': 'application/json',
          'Accept': 'text/plain',
          'Authorization': 'Bearer ${user.token}'
        };
      }
      return ApiResponse(code: response.statusCode, value: response.body);
    } catch (exception) {
      print(exception.toString());
      return const ApiResponse(
          code: 404, value: "Une erreur est survenu lors de la connection");
    }
  }

  //Register
  Future<ApiResponse> register(String username, String password, String mail,
      String firstname, String surname) async {
    var hashmdp = password;
    RegisterUser um = RegisterUser(firstname, surname, mail, username, hashmdp);
    var c_url = url + '/Users/Register';
    var uri = Uri.parse(c_url);
    var response =
        await http.post(uri, headers: headers, body: jsonEncode(um.toJson()));
    return ApiResponse(code: response.statusCode, value: response.body);
  }

  Future<ApiResponse> creationGoogle() async {
    try {
      var googleToken = await _firebaseAuthentification.signInWithGoogle();
      _firebaseAuthentification.signOut();

      String body = '{"googleToken" :"${googleToken}" }';
      var c_url = url + '/Users/Register';
      var uri = Uri.parse(c_url);
      var response = await http.post(uri, headers: headers, body: body);

      return ApiResponse(code: response.statusCode, value: response.body);
    } catch (exception) {
      return const ApiResponse(
          code: 404,
          value: "Une erreur est survenu lors de la creation de votre compte");
    }
  }

  //Ranking
  Future<List<ClassementUser>> getRanking() async {
    var c_url = url + '/Users/Ranking';
    var uri = Uri.parse(c_url);
    connectedHeaders = {
      'Content-type': 'application/json',
      'Accept': 'text/plain',
      'Authorization': 'Bearer ${await _auth.token()}'
    };
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
    var c_url = url + '/Transaction';
    var uri = Uri.parse(c_url);
    connectedHeaders = {
      'Content-type': 'application/json',
      'Accept': 'text/plain',
      'Authorization': 'Bearer ${await _auth.token()}'
    };
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
    try {
      var c_url = url + '/Notifications';
      var uri = Uri.parse(c_url);
      connectedHeaders = {
        'Content-type': 'application/json',
        'Accept': 'text/plain',
        'Authorization': 'Bearer ${await _auth.token()}'
      };
      var response = await http.get(uri, headers: connectedHeaders);
      if (response.statusCode == 200) {
        var notifications = (json.decode(response.body) as List);
        var notificationsList = notifications
            .map((res) => NotificationModel.fromJson(res))
            .toList();
        return notificationsList;
      } else {
        return List.empty();
      }
    } on Error {
      return null;
    }
  }

  //Buy
  Future<ApiResponse> buy(
      String cryptoId, num number, num currentValue, num total) async {
    var body =
        '{"CryptoId":"${cryptoId}", "Number":${number}, "CurrentValue": ${currentValue}, "Type" : "B"}';
    var c_url = url + '/Transaction';
    connectedHeaders = {
      'Content-type': 'application/json',
      'Accept': 'text/plain',
      'Authorization': 'Bearer ${await _auth.token()}'
    };
    var uri = Uri.parse(c_url);
    var response = await http.post(uri, headers: connectedHeaders, body: body);
    if (response.statusCode == 200) {
      locator<Auth>().setUserSolde(-number);
      await locator<Auth>().updateWallet(cryptoId, total);
    }
    return ApiResponse(code: response.statusCode, value: response.body);
  }

  //Sell
  Future<ApiResponse> sell(
      String cryptoId, num number, num currentValue, num dollarTotal) async {
    var body =
        '{"CryptoId":"${cryptoId}",  "Number":${number}, "CurrentValue": ${currentValue}, "Type" : "S"}';
    var c_url = url + '/Transaction';
    connectedHeaders = {
      'Content-type': 'application/json',
      'Accept': 'text/plain',
      'Authorization': 'Bearer ${await _auth.token()}'
    };
    var uri = Uri.parse(c_url);
    var response = await http.post(uri, headers: connectedHeaders, body: body);
    if (response.statusCode == 200) {
      locator<Auth>().setUserSolde(dollarTotal);
      locator<Auth>().updateWallet(cryptoId, -number);
    }
    return ApiResponse(code: response.statusCode, value: response.body);
  }

  //Send Message
  Future<ApiResponse> sendMessage(String cryptoId, String message) async {
    var body = '{"message":"${message}", "cryptoId":"${cryptoId}"}';
    var c_url = url + '/Messages';
    connectedHeaders = {
      'Content-type': 'application/json',
      'Accept': 'text/plain',
      'Authorization': 'Bearer ${await _auth.token()}'
    };
    var uri = Uri.parse(c_url);
    var response = await http.post(uri, headers: connectedHeaders, body: body);
    return ApiResponse(code: response.statusCode, value: response.body);
  }

  //Supprimmer notifications
  Future<ApiResponse> deleteNotification(String notificationId) async {
    var c_url = url + '/Notifications/${notificationId}';
    var uri = Uri.parse(c_url);
    connectedHeaders = {
      'Content-type': 'application/json',
      'Accept': 'text/plain',
      'Authorization': 'Bearer ${await _auth.token()}'
    };
    var response = await http.delete(uri, headers: connectedHeaders);
    return ApiResponse(code: response.statusCode, value: response.body);
  }

  Future<ApiResponse> sendMail(String name, String email, String subject,
      String text, bool isCopy) async {
    var c_url = url + '/Mail';
    var body =
        '{"fromName": "$name","fromEmail": "$email","subject": "$subject", "text": "$text", "copy": $isCopy}';
    var uri = Uri.parse(c_url);
    connectedHeaders = {
      'Content-type': 'application/json',
      'Accept': 'text/plain'
    };
    var response = await http.post(uri, headers: connectedHeaders, body: body);

    return ApiResponse(code: response.statusCode, value: response.body);
  }

  //Disable Notification
  Future<ApiResponse> disableNotification(String crytpoId) async {
    var body = '"${crytpoId}"';
    var c_url = url + '/Wallets/DisableNotification';
    connectedHeaders = {
      'Content-type': 'application/json',
      'Accept': 'text/plain',
      'Authorization': 'Bearer ${await _auth.token()}'
    };
    var uri = Uri.parse(c_url);
    var response = await http.post(uri, headers: connectedHeaders, body: body);
    return ApiResponse(code: response.statusCode, value: response.body);
  }

  Future<ApiResponse> blockUser(String userid) async {
    var c_url = url + '/Users/$userid';
    connectedHeaders = {
      'Content-type': 'application/json',
      'Accept': 'text/plain',
      'Authorization': 'Bearer ${await _auth.token()}'
    };
    var uri = Uri.parse(c_url);
    var response = await http.put(uri, headers: connectedHeaders);
    return ApiResponse(code: response.statusCode, value: response.body);
  }

  Future<ApiResponse> deleteUser(String userid) async {
    var c_url = url + '/Users/$userid';
    connectedHeaders = {
      'Content-type': 'application/json',
      'Accept': 'text/plain',
      'Authorization': 'Bearer ${await _auth.token()}'
    };
    var uri = Uri.parse(c_url);
    var response = await http.delete(uri, headers: connectedHeaders);
    return ApiResponse(code: response.statusCode, value: response.body);
  }

  Future<ApiResponse> addNewCrypto(String cryptoId) async {
    var c_url = url + '/Crypto/$cryptoId';
    connectedHeaders = {
      'Content-type': 'application/json',
      'Accept': 'text/plain',
      'Authorization': 'Bearer ${await _auth.token()}'
    };
    var uri = Uri.parse(c_url);
    var response = await http.post(uri, headers: connectedHeaders);
    return ApiResponse(code: response.statusCode, value: response.body);
  }
}
