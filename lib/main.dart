import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_4/Auth/Login/login.dart';
import 'package:flutter_application_4/firebase_options.dart';
import 'package:flutter_application_4/unit/print.dart';
// import 'package:flutter_application_4/notification.dart';

void  main() async {
  WidgetsFlutterBinding.ensureInitialized();
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

  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
printing();
    return MaterialApp(
      debugShowCheckedModeBanner: false,//عند الدراور
      home:Login(),
    );
}

}
