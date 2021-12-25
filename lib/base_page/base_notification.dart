import 'package:flutter/material.dart';
enum BaseNotificationIdentify{
  refreshAmount ,
}
class BaseNotification extends Notification {
  String identify;
  BaseNotification(this.identify);
}