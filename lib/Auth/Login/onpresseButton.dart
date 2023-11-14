import 'package:flutter/material.dart';
import 'package:flutter_application_4/Auth/Login/logintpost.dart';
import 'package:flutter_application_4/doctorSide/doctorHome.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
    final storage = FlutterSecureStorage();
  bool loginSuccessful = await postLogin(username, password);
  print("fromm post  $loginSuccessful");
  if (loginSuccessful) {
    print("username: $username");
    print("Password: $password");
  String? roleofuser = await storage.read(key: 'role');
  print("role is + roleofuser");
  print(roleofuser);
  if(roleofuser == "user")
  { Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) {
          return homePage(); // Navigate to the home page
        },
      ),
    );}
    if(roleofuser=="doctor;")
    {
      Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) {
          return doctorHome(); // Navigate to the home page
        },
      ),
    );
    }
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

