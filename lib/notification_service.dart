import 'package:firebase_messaging/firebase_messaging.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> setupNotifications() async {

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {

    RemoteNotification? notification = message.notification;

    if (notification != null) {

      flutterLocalNotificationsPlugin.show(
        0,
        notification.title,
        notification.body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'moveapp_channel',
            'MoveApp Notifications',
            importance: Importance.max,
            priority: Priority.high,
          ),
        ),
      );
    }
  });
}
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
