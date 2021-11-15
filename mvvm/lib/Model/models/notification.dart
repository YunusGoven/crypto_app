import 'crypto.dart';

class NotificationModel {
  final String message;
  final Crypto crypto;
  final bool isUp;

  NotificationModel(this.message, this.isUp, this.crypto);

  static fromJson(res) {}
}
