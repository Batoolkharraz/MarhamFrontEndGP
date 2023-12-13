// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
// final FirebaseFirestore firestore = FirebaseFirestore.instance;

// class signupFire extends StatefulWidget {
//   const signupFire({super.key});

//   @override
//   State<signupFire> createState() => _signupFireState();
// }

// class _signupFireState extends State<signupFire> {
//   List doctors = [];

//   Future<List<dynamic>> getDoctors() async {
//     var url = "https://marham-backend.onrender.com/doctor/";

//     var response = await http.get(Uri.parse(url));
//     if (response.statusCode == 200) {
//       var responceBody = response.body.toString();
//       responceBody = responceBody.trim();
//       responceBody = responceBody.substring(11, responceBody.length - 1);
//       var doc = jsonDecode(responceBody);
//       setState(() {
//         doctors.addAll(doc);  
//       });
   

//   }
    
//     return []; // Return an empty list if there's an error
//   }

// void signnn() async {
//   for (final doctor in doctors) {
//     final email = doctor['email']; // Replace with the email property of the doctor object
//     print(email);
//     String password = "12345678"; // Set a secure password or use a better method

//     try {
//       final credential = await FirebaseAuth.instance
//           .createUserWithEmailAndPassword(email: email, password: password);

//       final user = credential.user;
//       if (user != null) {
//         print(user.email);

//         // Adjust the path or structure according to your Firestore schema.
//         await FirebaseFirestore.instance
//             .collection('users')
//             .doc(user.uid)
//             .set({'uid': user.uid, 'email': email});
//       }
//     } catch (e) {
//       print('Error creating user: $e');
//       // Handle the error as needed (e.g., duplicate emails, weak passwords, etc.).
//     }
//   }
// }


//   @override
//   void initState() {
//     super.initState();
//     getDoctors();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body:
//       ElevatedButton(onPressed: (){

//     signnn();
//       }, child: Text('onPressed')),
//     );
//   }
// }


