import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotification {
  PushNotification._() {
    init();
  }

  static final PushNotification _instance = PushNotification._();
  static PushNotification get instance => _instance;

  final FlutterLocalNotificationsPlugin _pushNotification =
      FlutterLocalNotificationsPlugin();

  FlutterLocalNotificationsPlugin get pn => _pushNotification;

  void init() {
    _pushNotification.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('ic_launcher'),
      ),
      onDidReceiveNotificationResponse: (details) {
        log('foreground: $details');
      },
    );
  }
}
