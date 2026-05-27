import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> sendRideNotification() async {

  String serverKey =
      'YOUR_FIREBASE_SERVER_KEY';

  String driverToken = 'DRIVER_FCM_TOKEN';

  await http.post(
    Uri.parse('https://fcm.googleapis.com/fcm/send'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'key=$serverKey',
    },
    body: jsonEncode({
      'notification': {
        'title': 'New Ride Request 🚖',
        'body': 'Passenger nearby you',
      },
      'priority': 'high',
      'to': driverToken,
    }),
  );

  print("Ride Notification Sent");
}