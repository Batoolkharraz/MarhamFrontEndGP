import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'dart:convert';
Future<String> addPOST(String username, String email, String phone, String password, String cpassword) async {
  var url = Uri.parse("http://10.0.2.2:8000/route/signup");
  var response = await http.post(url, headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  },
    body: jsonEncode({
      "username": username,
      "email": email,
      "phone": phone,
      "password": password,
      "cpassword": cpassword,
    }),
  );

  if (response.statusCode == 200) {
    var responseBody = response.body.toString(); // Convert response body to String
    responseBody = responseBody.trim();
    responseBody = responseBody.replaceAll('"', '');

    if (responseBody == "false1") {
      return "false1";
    } else if (responseBody == "false2") {
      return "false2";
    } else {
      return "true";
    }
  } else {
    // In case of a network error, you can return a default value or throw an exception
    print('A network error occurred');
    return "error"; // Return a default value
  }
}
