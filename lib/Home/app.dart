//   import 'dart:convert';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:jwt_decoder/jwt_decoder.dart';
// import 'package:http/http.dart' as http;

//   final storage = FlutterSecureStorage();
//   List todayAppointment = [];
//   List appointment = [];

//   Future<String> getTokenFromStorage() async {
//     final token = await storage.read(key: 'jwt');
//     if (token != null) {
//       final String userId = getUserIdFromToken(token);
//       await Future.delayed(Duration(seconds: 2));
//       return userId;
//     } else {
//       print('Token not found in local storage.');
//       return '';
//     }
//   }

//   String getUserIdFromToken(String token) {
//     try {
//       final Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
//       final String userId = decodedToken['id'];
//       return userId;
//     } catch (e) {
//       print('Error decoding token: $e');
//       return '';
//     }
//   }

//   Future<void> getTodayAppointment() async {
//     try {
//       String Id = await getTokenFromStorage();
//       var url =
//           "https://marham-backend.onrender.com/schedule/byUser/today/${Id}";

//       var response = await http.get(Uri.parse(url));
//       if (response.statusCode == 200) {
//         var responseBody = response.body.toString();
//         responseBody = responseBody.trim();
//         responseBody = responseBody.substring(12, responseBody.length - 1);
//         var allApp = jsonDecode(responseBody);
//           todayAppointment.clear();
//           todayAppointment.addAll(allApp);
//       }
//     } catch (error) {
//       print("Error fetching today appointments: $error");
//       // Handle the error accordingly
//     }
//   }

//   Future<Map<String, String>> getAppInfo(String appId, String docId) async {
//     var url =
//         "https://marham-backend.onrender.com/schedule/appointment/$appId/$docId";
//     var response = await http.get(Uri.parse(url));

//     if (response.statusCode == 200) {
//       var responseBody = response.body.toString();
//       var responseData = jsonDecode(responseBody);

//       // Check if the "apps" field is present and not empty
//       if (responseData.containsKey("apps") &&
//           responseData["apps"] is List &&
//           responseData["apps"].isNotEmpty) {
//         var app = responseData["apps"][0];

//         // Extract date and time from the response
//         String date = app['scheduleByDay']['date'];
//         String time = app['scheduleByDay']['timeSlots']['time'];
//         print("time is: + $time");
        
//       //  checktime();
//         // Extract doctor name from the response
//         String docName = responseData['docName'];
//         return {'date': date, 'time': time, 'docName': docName};
//       } else {
//         print("No data found for the given appointment ID");
//         return {};
//       }
//     } else {
//       print("Failed to load appointment info");
//       return {};
//     }
//   }
