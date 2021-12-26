import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mvvm/Services/api_service.dart';
import 'package:mvvm/Services/firebase_service.dart';
import 'package:mvvm/locator.dart';

class MessageViewModel {
  void sendMessage(String cryptoid, String message, String userId) async {
    FirebaseApi.sendMessage(cryptoid, message, userId);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages(String cryptoId) {
    return FirebaseApi.getMessages(cryptoId);
  }
}
