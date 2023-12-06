import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_4/Auth/Login/logintpost.dart';
import 'package:flutter_application_4/doctorSide/doctorHome.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_application_4/Home/homePage.dart';

void onButtonPressed(
    BuildContext context, String email, String password) async {
  try {
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
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

    const storage = FlutterSecureStorage();
    bool loginSuccessful = await postLogin(email, password);

    print("fromm post  $loginSuccessful");

    if (loginSuccessful) {
      print("username: $email");
      print("Password: $password");
      final UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
      String? roleofuser = await storage.read(key: 'role');

      print("role is + roleofuser");
      print(roleofuser);

      if (roleofuser == "user") {
        showDialog(
  context: context,
  builder: (BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  },
);

Future.delayed(const Duration(seconds: 2), () {
  Navigator.pop(context); // Close the loading dialog
  Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) {
              return WillPopScope(
                onWillPop: () async => false, // Disable back button
                child: const homePage(), // Navigate to the home page
              );}
          )
        );
});

        

      }

      if (roleofuser == "doctor;") {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) {
              return const doctorHome(); // Navigate to the home page
            },
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
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
  } catch (e) {
    if (e is FirebaseAuthException) {
      print('FirebaseAuthException: ${e.code}');
      // Handle specific Firebase authentication errors
    } 
    print('Error during user login: ${e.toString()}');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'An error occurred during login. Please try again later.',
          style: TextStyle(
            fontSize: 25,
            fontFamily: 'Helvetica',
          ),
        ),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      ),
    );
  }
}
