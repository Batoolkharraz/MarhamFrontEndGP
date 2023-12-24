// import 'dart:convert';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:jwt_decoder/jwt_decoder.dart';
// import 'package:http/http.dart' as http;
// import 'dart:async';
// import 'package:firebase_auth/firebase_auth.dart';

// class MyClass {
//   // Private variable
//   List<String> _myPrivateVariable = [];
//   final storage = FlutterSecureStorage();
//   List<String> dates = [];
//   List appointment = [];
//   List<dynamic> allAppointment = [];

//   // Getter for the private variable
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

//   Future<String> getTokenFromStorage() async {
//     final token = await storage.read(key: 'jwt');
//     if (token != null) {
//       final String userId = getUserIdFromToken(token);
//       await Future.delayed(const Duration(seconds: 2));
//       return userId;
//     } else {
//       print('Token not found in local storage.');
//       return '';
//     }
//   }

//   Future<void> getAllAppointment() async {
//     try {
//       String Id = await getTokenFromStorage();
//       var url = "https://marham-backend.onrender.com/schedule/byUser/all/$Id";

//       var response = await http.get(Uri.parse(url));
//       if (response.statusCode == 200) {
//         var responseBody = response.body.toString();
//         responseBody = responseBody.trim();
//         responseBody = responseBody.substring(12, responseBody.length - 1);
//         var allApp = jsonDecode(responseBody);
//         allAppointment.addAll(allApp);
//       }
//     } catch (error) {
//       print("Error fetching appointments: $error");
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

//         //  checktime();
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

//   void printing() async {
//     print("am in");
//     List<String>times=[];
//   FirebaseFirestore firestore = FirebaseFirestore.instance;
//   var user = FirebaseAuth.instance.currentUser;
//     await getAllAppointment();
//     for (final app in allAppointment) {
//       Map<String, String> appInfo =
//           await getAppInfo(app['bookId'], app['doctorId']);
//       if (appInfo.isNotEmpty) {
//         String date = appInfo['date']!;
//         String time = appInfo['time']!;
//         // if (dates.contains(date))
//         //   print('$date is present in the list.');
//         // else if (!dates.contains(date)) {
//           dates.add(date);
//           times.add(time);
        
//       }
//     }
//     if ((user != null)) {
//             await firestore
//                 .collection('AppointmentsDates')
//                 .doc("${user?.email}")
//                 .set({'Appointments':dates});
//                 await firestore
//                 .collection('Appointmentstimes')
//                 .doc("${user?.email}")
//                 .set({'times':times});
//           }
//   }
// //   void getlist()async

// //   {if (user != null) {
// //   DocumentSnapshot<Map<String, dynamic>> snapshot = await firestore
// //       .collection('AppointmentsDates')
// //       .doc("${user?.email}")
// //       .get();

// //   if (snapshot.exists) {
// //     Map<String, dynamic>? data = snapshot.data();
    
// //     if (data != null && data.containsKey('Appointments')) {
// //       List<dynamic> dates = data['Appointments'];
// //       List<String> dateList = dates.map((date) => date.toString()).toList();
      
// //       print('Dates in Firestore: $dateList');
// //     } else {
// //       print('Appointments field not found in Firestore document.');
// //     }
// //   } else {
// //     print('Firestore document not found.');
// //   }
// // }
// // }

// }

