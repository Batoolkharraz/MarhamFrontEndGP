import 'package:flutter_application_4/Auth/resetpass/alert.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:convert' as convert;
 void update(context,String password) async{
  var url = Uri.parse("https://marham-backend.onrender.com/updatePassword/User");
    try {
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: convert.jsonEncode({
        "password":password ,
      }),
    );
     if (response.statusCode == 200) {
      // Password updated successfully
      final jsonResponse = jsonDecode(response.body);
      print(jsonResponse['message']);
      showalertt(context);
    } else if (response.statusCode == 404) {
      // User not found
      final jsonResponse = jsonDecode(response.body);
      print(jsonResponse['message']);
    } else {
      // Handle other HTTP response statuses
      print('HTTP Request Error: ${response.statusCode}');
    }
 }
 catch (e) {
    print('An exception occurred: $e');
    return null; // Return null for any exceptions
  }
 }