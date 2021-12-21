import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mvvm/Services/api_service.dart';
import 'package:mvvm/Services/firebase_service.dart';
import 'package:mvvm/locator.dart';

class MessageViewModel {
  final _api = locator<ApiService>();

  void sendMessage(String cryptoid, String message) async {
    await _api.sendMessage(cryptoid, message);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages(String cryptoId) {
    return FirebaseApi.getMessages(cryptoId);
  }
}
