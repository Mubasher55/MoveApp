import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {

sion();FirebaseMessaging messaging = FirebaseMessaging.instance;

void initNotifications() async {
  await messaging.requestPermission();

  FirebaseMessaging.onMessage.listen((message) {
    print("New Notification: ${message.notification?.title}");
  });
}
    
    String? token =
    await messaging.getToken();

    print("FCM TOKEN: $token");
  }
}