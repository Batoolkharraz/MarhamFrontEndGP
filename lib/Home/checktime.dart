import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
void checktime() async {
  String time = "14:52";
  DateTime currentTime = DateTime.now();
  String formattedTime = "${currentTime.hour}:${currentTime.minute}";

  TimeOfDay timeOfDay = convertStringToTime(time);
  TimeOfDay current = convertStringToTime(formattedTime);

  // Convert TimeOfDay to minutes for easier comparison
  int appointmentMinutes = timeOfDay.hour * 60 + timeOfDay.minute;
  int currentMinutes = current.hour * 60 + current.minute;

  int timeDifference = appointmentMinutes - currentMinutes;

  print("Converted Time: $timeOfDay");
  print(timeDifference);



  bool isAllowedToSendNotification =
      await AwesomeNotifications().isNotificationAllowed();

  if (isAllowedToSendNotification && (timeDifference == -60 || timeDifference == -24 || timeDifference == 0)) {
    // Difference is one hour or more
    
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: "basic_channel",
        title: "Marham",
        body: "Don't Forget your today Appointment on $time",
      displayOnForeground: true, // Display the notification even when the app is in the foreground
      displayOnBackground: true,
       color: Colors.blue,
       
      ),
    );
  } else {
    print("formattedTime + $formattedTime");
  }
}


TimeOfDay convertStringToTime(String timeString) {
  List<String> parts = timeString.split(':');
  int hour = int.parse(parts[0]);
  int minute = int.parse(parts[1]);

  return TimeOfDay(hour: hour, minute: minute);
}
