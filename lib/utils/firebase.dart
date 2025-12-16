import 'package:dzevent/main.dart';
import 'package:dzevent/presentation/screens/event_feed.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<bool> initFirebaseMessaging() async {
  await firebaseRequestPermission();
  initLocalPlugin();

  final token = await FirebaseMessaging.instance.getToken();
  print("Firebase token is : $token");
  final topic = "events";
  await FirebaseMessaging.instance.subscribeToTopic(topic);
  print("Subscribed to topic $topic");

  const channel = AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    importance: Importance.high,
  );
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin
      >()
      ?.createNotificationChannel(channel);
  print("Channel created");

  FirebaseMessaging.onBackgroundMessage(_handleBgMessage);
  FirebaseMessaging.onMessage.listen(_handleMessageFg);

  // When clicking on the notification
  FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageOpen);
  return true;
}

Future<bool> _handleMessageOpen(RemoteMessage message) async {
  print("\n\n\n#####Calling FireMessage Opening Handler...\n\n\n");
  Map<String, dynamic> data = Map.of(message.data);
  print("\n\n\n#####data : ${data.toString()}...\n\n\n");
  Navigator.of(navigatorKey.currentContext!).push(EventFeed.route());
  return true;
}

Future<void> _handleMessageFg(RemoteMessage message) async {
  print("Recieved fg message");
  final notification = message.notification;
  if (notification == null) return;

  const androidDetails = AndroidNotificationDetails(
    'high_importance_channel',
    'High Importance Notifications',
    importance: Importance.max,
    priority: Priority.high,
    icon: '@mipmap/ic_launcher',
  );

  const details = NotificationDetails(android: androidDetails);

  await flutterLocalNotificationsPlugin.show(
    0,
    notification.title,
    notification.body,
    details,
  );
}

@pragma('vm:entry-point')
Future<bool> _handleBgMessage(RemoteMessage message) async {
  print("Running Background Message>>>");
  print(
    "Recevied Background message ${message.messageId} -  ${message.toMap().toString()}",
  );
  return true;
}

Future<bool> firebaseRequestPermission() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print("User garnted permission");
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print("User garnted provisional permission");
  } else {
    print("User declined or has not accepted permission");
  }
  return true;
}

void initLocalPlugin() {
  const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');

  const settings = InitializationSettings(android: androidSettings);

  flutterLocalNotificationsPlugin.initialize(
    settings,
    onDidReceiveNotificationResponse: (_) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        navigatorKey.currentState?.push(
          MaterialPageRoute(builder: (_) => EventFeed()),
        );
      });
    },
  );
}
