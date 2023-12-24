
import 'package:flutter/material.dart';
import 'package:flutter_application_4/notification/local_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
void getlist() async {
  try
 { FirebaseFirestore firestore = FirebaseFirestore.instance;
  var user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await firestore.collection('AppointmentsDates').doc("${user.email}").get();
    DocumentSnapshot<Map<String, dynamic>> snapshot2 =
        await firestore.collection('Appointmentstimes').doc("${user.email}").get();

    if (snapshot.exists && snapshot2.exists) {
      Map<String, dynamic>? data = snapshot.data();
      Map<String, dynamic>? data2 = snapshot2.data();

      if (data != null && data.containsKey('Appointments') && data2 != null && data2.containsKey('times')) {
        // Ensure 'Appointments' and 'times' are List<dynamic> before accessing them
        List<dynamic>? dates = data['Appointments'];
        List<dynamic>? times = data2['times'];

        if (dates != null && times != null) {
          List<String> dateList = dates.map((date) => date.toString()).toList();
          List<String> timesList = times.map((date) => date.toString()).toList();
          

          DateTime now = DateTime.now();
          DateTime after = now.add(Duration(days: 1));
          String formattedDate = DateFormat('yyyy/MM/dd').format(after);
          for (int i = 0; i < dateList.length; i++) {
            if (formattedDate == dateList[i]) {
                TimeOfDay currentTime = TimeOfDay.now();
              TimeOfDay time = convertStringToTimeOfDay(timesList[i]);
            if (currentTime.hour < time.hour || (currentTime.hour == time.hour && currentTime.minute < time.minute)) 
             { LocalNotifications.showScheduleNotification(
                title: "Marham",
                body: "Don't forget your appointment Tomorrow",
                payload: "This is schedule data",
                 time: TimeOfDay(hour: time.hour,minute:time.minute)
              );}
            }
          }
        } else {
          print("'Appointments' or 'times' field is null in Firestore document.");
        }
      } else {
        print("'Appointments' or 'times' field not found in Firestore document.");
      }
    } else {
      print('Firestore document not found.');
    }
  }}
  catch(e, stackTrace){
print('Error fetching data: $e\n$stackTrace');
  }
  
}
TimeOfDay convertStringToTimeOfDay(String timeString) {
  // Split the time string into hours and minutes
  List<String> parts = timeString.split(":");
  
  // Parse the hours and minutes as integers
  int hours = int.parse(parts[0]);
  int minutes = int.parse(parts[1]);

  // Create and return a TimeOfDay object
  return TimeOfDay(hour: hours, minute: minutes);
}
