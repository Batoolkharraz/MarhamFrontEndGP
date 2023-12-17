import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
Future<void> initNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('app_icon');

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: onSelectNotification);
}

Future<void> onSelectNotification(String? payload) async {
  // Handle the notification click here
  print('Notification clicked! Payload: $payload');
}

  // bool isAllowedToSendNotification =
  //     await AwesomeNotifications().isNotificationAllowed();
  // if (isAllowedToSendNotification ) {
  //   // Difference is one hour or more

  //   AwesomeNotifications().createNotification(
  //     content: NotificationContent(
  //       id: 1,
  //       channelKey: "basic_channel",
  //       title: "Marham",
  //       body: "Don't Forget your today Appointment on $time",
  //       displayOnForeground:
  //           true, // Display the notification even when the app is in the foreground
  //       displayOnBackground: true,
  //       color: Colors.blue,
  //     ),
  //   );
   
  // }

  


