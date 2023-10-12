import 'package:flutter/material.dart';
import 'package:flutter_application_4/Auth/Login/logintpost.dart';
import 'package:flutter_svg/flutter_svg.dart';
void onButtonPressed(BuildContext context, String username, String password) async {
    bool loginSuccessful = await postLogin(username, password);
    if (loginSuccessful) {
      print("Email: $username");
      print("Password: $password");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Incorrect username or password',
            style: TextStyle(
              fontSize: 25,
              fontFamily: 'Helvetica',
            ),
          ),
          backgroundColor: Color.fromARGB(221, 252, 57, 43),
          duration: Duration(seconds: 3),
        ),
      );
    }
  
}
