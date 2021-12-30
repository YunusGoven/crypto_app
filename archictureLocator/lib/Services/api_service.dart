// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:mvvm/Model/crypto.dart';
import 'package:mvvm/Model/history.dart';
import 'package:mvvm/Model/notification.dart';
import 'package:mvvm/Model/user.dart';
import 'package:mvvm/Model/wallet.dart';
import 'package:mvvm/Services/api_response.dart';
import 'package:mvvm/Services/firebase_authentification.dart';
import 'package:mvvm/Services/userinfo_service.dart';
import 'package:mvvm/locator.dart';

class ApiService {
  final _auth = locator<Auth>();
  final FirebaseAuthentification _firebaseAuthentification =
      FirebaseAuthentification();
  //final url = "http://127.0.0.1:44336/api";
  // final url = "http://10.0.2.2:44336/api";
  final url = "https://porthos-intra.cg.helmo.be/grGU/api";
  final Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'text/plain',
  };

  Map<String, String> connectedHeaders = {
    'Content-type': 'application/json',
    'Accept': 'text/plain',
  };
  //Wallet
  Future<List<Wallet>> getWallet() async {
    try {
      var uri = Uri.parse('$url/Wallets');
      _verifyTokenHeaders();
      var response = await http.get(uri, headers: connectedHeaders);
      if (response.statusCode == 200) {
        var wallets = (json.decode(response.body) as List);
        return wallets.map((wallet) => Wallet.fromJson(wallet)).toList();
      }
      return <Wallet>[];
    } catch (ex) {
      return <Wallet>[];
    }
  }

  //All crypto
  Future<List<Crypto>> getAllCryptos(int number) async {
    try {
      var uri = Uri.parse('$url/Crypto');
      var response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        var cryptoResponse = (json.decode(response.body) as List);
        var cryptos = cryptoResponse.map((crypto) {
          return Crypto.fromJson(crypto);
        }).toList();
        return number == -1 ? cryptos : cryptos.take(number).toList();
      }
      return <Crypto>[];
    } catch (ex) {
      return <Crypto>[];
    }
  }

  Future<List<User>> getAllUsers() async {
    try {
      var uri = Uri.parse('$url/Users');
      _verifyTokenHeaders();
      var response = await http.get(uri, headers: connectedHeaders);
      if (response.statusCode == 200) {
        var users = (json.decode(response.body) as List);
        return users.map((res) => User.fromJson(res)).toList();
      }
      return <User>[];
    } catch (ex) {
      return <User>[];
    }
  }

  //Detail crypto
  Future<Crypto> getCrypto(String cryptoId) async {
    try {
      var uri = Uri.parse('$url/Crypto/$cryptoId');
      var response = await http.get(uri);
      if (response.statusCode == 200) {
        var crypto = json.decode(response.body);
        return Crypto.fromJson(crypto);
      }
      return null;
    } catch (ex) {
      return null;
    }
  }

  //connection google
  Future<ApiResponse> connectiongoogle() async {
    try {
      var googleToken = await _firebaseAuthentification.signInWithGoogle();
      var bodymap = <String, dynamic>{"googleToken": googleToken};
      var identifier = FirebaseMessaging.instance;
      var notsett = await identifier.getNotificationSettings();
      if (notsett.authorizationStatus == AuthorizationStatus.authorized) {
        var token = await identifier.getToken();
        bodymap.putIfAbsent("deviceId", () => token);
      }

      return await _connect(bodymap);
    } catch (exception) {
      return const ApiResponse(
          code: 404, value: "Une erreur est survenu lors de l'identification");
    }
  }

  Future<ApiResponse> _connect(Map<String, dynamic> bodymap) async {
    var isAlreadyConnected = await _auth.isAuthenticate();
    if (isAlreadyConnected) {
      return const ApiResponse(
          code: 409, value: "Veuillez vous déconnecter avant");
    }
    try {
      var uri = Uri.parse('$url/Users/SignIn');
      var response =
          await http.post(uri, headers: headers, body: jsonEncode(bodymap));
      if (response.statusCode == 200) {
        ConnectedUser user = ConnectedUser.fromJson(jsonDecode(response.body));
        _auth.addToLocal(jsonDecode(response.body));
      } else {
        _firebaseAuthentification.signOut();
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
      var bodymap = <String, dynamic>{"pseudo": username, "password": password};
      var identifier = FirebaseMessaging.instance;
      var notsett = await identifier.getNotificationSettings();
      if (notsett.authorizationStatus == AuthorizationStatus.authorized) {
        var token = await identifier.getToken();
        bodymap.putIfAbsent("deviceId", () => token);
      }
      var connect = await _connect(bodymap);
      if (connect.code == 200) {
        await _firebaseAuthentification.signOut();
        var userCo = await _auth.getUser();
        await _firebaseAuthentification.signInWithEmailAndPass(
            userCo.mail, password);
      }
      return connect;
    } catch (exception) {
      return const ApiResponse(
          code: 404, value: "Une erreur est survenu lors de la connection");
    }
  }

  //Register
  Future<ApiResponse> register(String username, String password, String mail,
      String firstname, String surname) async {
    try {
      RegisterUser um =
          RegisterUser(firstname, surname, mail, username, password);
      var uri = Uri.parse('$url/Users/Register');
      var response =
          await http.post(uri, headers: headers, body: jsonEncode(um.toJson()));
      return ApiResponse(code: response.statusCode, value: response.body);
    } catch (ex) {
      return const ApiResponse(
          code: 404,
          value: "Une erreur est survenu lors de la création de votre compte");
    }
  }

  //register google
  Future<ApiResponse> creationGoogle() async {
    try {
      var googleToken = await _firebaseAuthentification.signInWithGoogle();
      _firebaseAuthentification.signOut();
      var bodymap = <String, dynamic>{"googleToken": googleToken};
      var uri = Uri.parse('$url/Users/Register');
      var response =
          await http.post(uri, headers: headers, body: jsonEncode(bodymap));

      return ApiResponse(code: response.statusCode, value: response.body);
    } catch (exception) {
      return const ApiResponse(
          code: 404,
          value: "Une erreur est survenu lors de la creation de votre compte");
    }
  }

  //Ranking
  Future<List<ClassementUser>> getRanking() async {
    try {
      var uri = Uri.parse('$url/Users/Ranking');
      _verifyTokenHeaders();
      var response = await http.get(uri, headers: connectedHeaders);
      if (response.statusCode == 200) {
        var users = (json.decode(response.body) as List);
        return users.map((user) => ClassementUser.fromJson(user)).toList();
      }
      return <ClassementUser>[];
    } catch (ex) {
      return <ClassementUser>[];
    }
  }

  //History
  Future<List<History>> getHistory() async {
    try {
      var uri = Uri.parse('$url/Transaction');
      _verifyTokenHeaders();
      var response = await http.get(uri, headers: connectedHeaders);
      if (response.statusCode == 200) {
        var historys = (json.decode(response.body) as List);
        return historys.map((history) => History.fromJson(history)).toList();
      }
      return <History>[];
    } catch (ex) {
      return <History>[];
    }
  }

  Future<void> _verifyTokenHeaders() async {
    var token = await _auth.token();
    connectedHeaders.putIfAbsent('Authorization', () => 'Bearer $token');
  }

  //Notification
  Future<List<NotificationModel>> getNotification() async {
    try {
      var uri = Uri.parse('$url/Notifications');
      _verifyTokenHeaders();
      var response = await http.get(uri, headers: connectedHeaders);
      if (response.statusCode == 200) {
        var notifications = (json.decode(response.body) as List);
        return notifications
            .map((res) => NotificationModel.fromJson(res))
            .toList();
      }
      return <NotificationModel>[];
    } catch (ex) {
      return <NotificationModel>[];
    }
  }

  //Buy
  Future<ApiResponse> buy(
      String cryptoId, num number, num currentValue, num total) async {
    try {
      var bodymap = <String, dynamic>{
        "CryptoId": cryptoId,
        "Number": number,
        "CurrentValue": currentValue,
        "Type": "B"
      };
      _verifyTokenHeaders();
      var uri = Uri.parse('$url/Transaction');
      var response = await http.post(uri,
          headers: connectedHeaders, body: jsonEncode(bodymap));
      if (response.statusCode == 200) {
        locator<Auth>().setUserSolde(-number);
        await locator<Auth>().updateWallet(cryptoId, total);
      }
      return ApiResponse(code: response.statusCode, value: response.body);
    } catch (ex) {
      return const ApiResponse(
          code: 404, value: "Une erreur est survenu lors de votre transaction");
    }
  }

  //Sell
  Future<ApiResponse> sell(
      String cryptoId, num number, num currentValue, num dollarTotal) async {
    try {
      var bodymap = <String, dynamic>{
        "CryptoId": cryptoId,
        "Number": number,
        "CurrentValue": currentValue,
        "Type": "S"
      };
      _verifyTokenHeaders();
      var uri = Uri.parse('$url/Transaction');
      var response = await http.post(uri,
          headers: connectedHeaders, body: jsonEncode(bodymap));
      if (response.statusCode == 200) {
        locator<Auth>().setUserSolde(dollarTotal);
        locator<Auth>().updateWallet(cryptoId, -number);
      }
      return ApiResponse(code: response.statusCode, value: response.body);
    } catch (ex) {
      return const ApiResponse(
          code: 404, value: "Une erreur est survenu lors de votre transaction");
    }
  }

  //Supprimmer notifications
  Future<ApiResponse> deleteNotification(String notificationId) async {
    try {
      _verifyTokenHeaders();
      var uri = Uri.parse('$url/Notifications/$notificationId');
      var response = await http.delete(uri, headers: connectedHeaders);
      return ApiResponse(code: response.statusCode, value: response.body);
    } catch (ex) {
      return const ApiResponse(
          code: 404,
          value: "Une erreur est survenu lors de la suppression de la notif");
    }
  }

  Future<ApiResponse> sendMail(String name, String email, String subject,
      String text, bool isCopy) async {
    try {
      var bodymap = <String, dynamic>{
        "fromName": name,
        "fromEmail": email,
        "subject": subject,
        "text": text,
        "copy": isCopy,
      };
      var uri = Uri.parse('$url/Mail');
      var response =
          await http.post(uri, headers: headers, body: jsonEncode(bodymap));

      return ApiResponse(code: response.statusCode, value: response.body);
    } catch (ex) {
      return const ApiResponse(
          code: 404, value: "Une erreur est survenu lors de l'envoi du mail");
    }
  }

  //Disable Notification
  Future<ApiResponse> disableNotification(String crytpoId) async {
    try {
      var body = '"${crytpoId}"';
      _verifyTokenHeaders();
      var uri = Uri.parse('$url/Wallets/DisableNotification');
      var response =
          await http.post(uri, headers: connectedHeaders, body: body);
      return ApiResponse(code: response.statusCode, value: response.body);
    } catch (ex) {
      return const ApiResponse(
          code: 404,
          value: "Une erreur est survenu lors du changement de notification");
    }
  }

  Future<ApiResponse> blockUser(String userid) async {
    try {
      _verifyTokenHeaders();
      var uri = Uri.parse('$url/Users/$userid');
      var response = await http.put(uri, headers: connectedHeaders);
      return ApiResponse(code: response.statusCode, value: response.body);
    } catch (ex) {
      return const ApiResponse(
          code: 404, value: "Une erreur est survenu lors du blocage ");
    }
  }

  Future<ApiResponse> deleteUser(String userid) async {
    try {
      _verifyTokenHeaders();
      var uri = Uri.parse('$url/Users/$userid');
      var response = await http.delete(uri, headers: connectedHeaders);
      return ApiResponse(code: response.statusCode, value: response.body);
    } catch (ex) {
      return const ApiResponse(
          code: 404,
          value:
              "Une erreur est survenu lors de la suppression de l'utilisateur");
    }
  }

  Future<ApiResponse> addNewCrypto(String cryptoId) async {
    try {
      _verifyTokenHeaders();
      var uri = Uri.parse('$url/Crypto/$cryptoId');
      var response = await http.post(uri, headers: connectedHeaders);
      return ApiResponse(code: response.statusCode, value: response.body);
    } catch (ex) {
      return const ApiResponse(
          code: 404,
          value: "Une erreur est survenu lors de l'ajout de la crypto");
    }
  }
}
