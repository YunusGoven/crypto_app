import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Message {
  final String message;
  final DateTime time;
  final String cryptoId;
  final String userId;

  const Message(
      {@required this.userId,
      @required this.message,
      @required this.time,
      @required this.cryptoId});

  static Message fromJson(Map<String, dynamic> json) => Message(
        userId: json['idUser'],
        cryptoId: json['cryptoId'],
        message: json['message'],
        time: ((json['createdAt']) as Timestamp).toDate(),
      );

  Map<String, dynamic> toJson() => {
        'idUser': userId,
        'cryptoId': cryptoId,
        'message': message,
        'createdAt': time.toUtc(),
      };
}
