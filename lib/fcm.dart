import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> getToken() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  await messaging.requestPermission();

  String? token = await messaging.getToken();

  print("FCM TOKEN: $token");
}