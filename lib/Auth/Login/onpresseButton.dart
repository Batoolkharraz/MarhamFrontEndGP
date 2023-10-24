import 'package:flutter/material.dart';
import 'package:flutter_application_4/Auth/Login/logintpost.dart';
import 'package:flutter_application_4/Auth/updateinformation/edit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_application_4/Home/homePage.dart';


void onButtonPressed(
    BuildContext context, String username, String password) async {
  if (username == null || username.isEmpty || password == null || password.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Please fill in both username and password',
          style: TextStyle(
            fontSize: 25,
            fontFamily: 'Helvetica',
          ),
        ),
        backgroundColor: Color.fromARGB(221, 252, 57, 43),
        duration: Duration(seconds: 3),
      ),
    );
    return;
  }

  bool loginSuccessful = await postLogin(username, password);
  print("fromm post  $loginSuccessful");
  if (loginSuccessful) {
    print("username: $username");
    print("Password: $password");
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return homePage(); // Navigate to the home page
        },
      ),
    );
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

