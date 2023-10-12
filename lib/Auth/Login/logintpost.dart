import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'dart:convert';
Future<bool> postLogin(String username, String password) async {
  var url = Uri.parse("http://10.0.2.2:8000/in/signin");
  var response = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({
      "username": username,
      "password": password,
    }),
  );

  if (response.statusCode == 200) {
    var responseBody = response.body;
     final responseData = jsonDecode(response.body);
    if (responseData==false) {
      return false; // Return false for invalid data
    }
    else
   { print(responseData);
    return true; }// Return true for successful response
  } else {
    print('A network error occurred');
    return false; // Return false for network error
  }
}
