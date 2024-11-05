import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_demo/controller/hive_services.dart';

@pragma('vm:entry-point')
Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('Background Message Title: ${message.notification?.title}');
  print("Body: ${message.notification?.body}");
  print('Payload: ${message.data}');
}

class FirebaseNotification {
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  void handleMesage(RemoteMessage? message) {
    if (message == null) return;
  }

  Future<void> initNotification() async {
    await firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    final fCMToken = await firebaseMessaging.getToken();
    print('Token $fCMToken');

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received a foreground message');
      print('Message data: ${message.data}');
      print('Message notification: ${message.notification?.title}');
      print("Message notification body: ${message.notification?.body}");
      addNotification(
        message.notification?.title ?? '',
        message.notification?.body ?? '',
      );
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Notification caused app to open');
    });

    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }
}
