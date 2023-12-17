import 'package:flutter/material.dart';
import 'package:flutter_application_4/unit/checktime.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;

final storage = FlutterSecureStorage();
List todayAppointment = [];
List appointment = [];

Future<String> getToken() async {
  final token = await storage.read(key: 'jwt');
  if (token != null) {
    final String userId = getUserId(token);
    await Future.delayed(Duration(seconds: 2));
    return userId;
  } else {
    print('Token not found in local storage.');
    return '';
  }
}

String getUserId(String token) {
  try {
    final Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    final String userId = decodedToken['id'];
    return userId;
  } catch (e) {
    print('Error decoding token: $e');
    return '';
  }
}

Future<void> TodayAppointment() async {
  try {
    String Id = await getToken();
    var url = "https://marham-backend.onrender.com/schedule/byUser/today/${Id}";

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var responseBody = response.body.toString();
      responseBody = responseBody.trim();
      responseBody = responseBody.substring(12, responseBody.length - 1);
      var allApp = jsonDecode(responseBody);
     todayAppointment.addAll(allApp);
    
    }
  } catch (error) {
    print("Error fetching today appointments: $error");
    // Handle the error accordingly
  }
}

Future<Map<String, String>> AppInfo(String appId, String docId) async {
  var url =
      "https://marham-backend.onrender.com/schedule/appointment/$appId/$docId";
  var response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    var responseBody = response.body.toString();
    var responseData = jsonDecode(responseBody);

    // Check if the "apps" field is present and not empty
    if (responseData.containsKey("apps") &&
        responseData["apps"] is List &&
        responseData["apps"].isNotEmpty) {
      var app = responseData["apps"][0];

      // Extract date and time from the response
      String date = app['scheduleByDay']['date'];
      String time = app['scheduleByDay']['timeSlots']['time'];

      //  checktime();
      // Extract doctor name from the response
      return {'date': date, 'time': time};
    } else {
      print("No data found for the given appointment ID");
      return {};
    }
  } else {
    print("Failed to load appointment info");
    return {};
  }
}
void printing()async{
   List<String> times=[];
 await TodayAppointment();
  for (final app in todayAppointment) {
    print(app);
    Map<String, String> appInfo = await AppInfo(app['bookId'], app['doctorId']);
    if (appInfo.isNotEmpty) {
      String date = appInfo['date']!;
      String time = appInfo['time']!;
      times.add(time);
  //  print(times);
   
    }
  }
  printbatool(times);
 
}
void printbatool(List <String> uu)
{
print("time list : $uu");
}