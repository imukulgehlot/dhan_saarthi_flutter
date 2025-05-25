// import 'package:shareclube_user/generated/json/base/json_field.dart';
// import 'package:shareclube_user/generated/json/push_notification_entity.g.dart';
import 'dart:convert';

// Note Create you own model here
class PushNotificationEntity {
  int? badge;
  String? sound;
  String? body;
  int? type;
  int? title;

  int? senderId;

  PushNotificationEntity();

  factory PushNotificationEntity.fromJson(Map<String, dynamic> json) =>
      PushNotificationEntity();

  Map<String, dynamic> toJson() => {};

  @override
  String toString() {
    return jsonEncode(this);
  }
}
