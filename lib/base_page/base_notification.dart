import 'package:flutter/material.dart';
enum BaseNotificationIdentify{
  refreshAmount ,
  withdrawRefreshAmount ,
}
class BaseNotification extends Notification {
  String identify;
  BaseNotification(this.identify);
}