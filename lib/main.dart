import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_4/Auth/Login/login.dart';
import 'package:flutter_application_4/firebase_options.dart';
import 'package:flutter_application_4/notification/local_notifications.dart';
import 'package:flutter_application_4/payment/wallet/points.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


    void  main() async {
 
  WidgetsFlutterBinding.ensureInitialized();
    await LocalNotifications.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);


  // await AwesomeNotifications().initialize(null, [
  //   NotificationChannel(
  //     channelGroupKey: "basic_channel_group",
  //     channelKey: "basic_channel",
  //     channelName: "Basic Notification",
  //     channelDescription: "Basic notifications channel",
  //   )
  // ], channelGroups: [
  //   NotificationChannelGroup(
  //     channelGroupKey: "basic_channel_group",
  //     channelGroupName: "Basic Group",
  //   )
  // ]
  // );
  
  // bool isAllowedToSendNotification =
  //     await AwesomeNotifications().isNotificationAllowed();
  // if (!isAllowedToSendNotification) {
  //   AwesomeNotifications().requestPermissionToSendNotifications();
  // }

  runApp(const MyApp());
  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
// printing();
    return MaterialApp(
      debugShowCheckedModeBanner: false,//عند الدراور
      home:Login(),
    );
}

}