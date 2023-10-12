import 'package:flutter/material.dart';
import 'package:flutter_application_4/Auth/Login/login.dart';
import 'package:flutter_application_4/Auth/signup/signuppost.dart';
void onPressed(BuildContext context, String username, String   email, String   phone, String   password,  String  cpassword) async {
    String loginSuccessful = await addPOST(username,  email,  phone,  password,  cpassword);
    if (loginSuccessful=="false1") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'This username is already used',
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
    else if(loginSuccessful =="false2")
    {
        ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'This email is already used',
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
    else{
              ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Success',
            style: TextStyle(
              fontSize: 25,
              fontFamily: 'Helvetica',
            ),
          ),
          backgroundColor: Color.fromARGB(255, 25, 150, 212),
          duration: Duration(seconds: 3),
        ),
      );
       Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );
    }
  
}