import 'package:flutter/material.dart';
import 'package:flutter_application_4/Auth/Login/login.dart';
import 'package:flutter_application_4/Auth/signup/signuppost.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

void onPressed(BuildContext context, String username, String email,
    String phone, String password) async {
  try {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    String loginSuccessful = await addPOST(username, email, phone, password);

    if (loginSuccessful == "false1") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
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
    } else if (loginSuccessful == "false2") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
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
    } else {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      final user = credential.user;
      if (user != null) {
  print(user.email);
  firestore
      .collection('users')
      .doc(user.uid)
      .set({'uid': user.uid, 'email': email});
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const Login()),
  );
}
else print("user is null");
    }
  } catch (e) {
    print('Error during user registration: ${e.toString()}');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'An error occurred. Please try again later.',
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
