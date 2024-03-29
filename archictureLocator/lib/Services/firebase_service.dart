import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mvvm/Model/message.dart';

class FirebaseApi {
  static Future sendMessage(
      String cryptoId, String message, String userId) async {
    final ref =
        FirebaseFirestore.instance.collection('chats/$cryptoId/messages');
    final finalmessage = Message(
        userId: userId,
        message: message,
        time: DateTime.now(),
        cryptoId: cryptoId);
    await ref.add(finalmessage.toJson());
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getMessages(
      String cryptoId) {
    return FirebaseFirestore.instance
        .collection('chats/$cryptoId/messages')
        .orderBy("createdAt", descending: true)
        .snapshots();
  }
}
