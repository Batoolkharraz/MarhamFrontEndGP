import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_4/Auth/chat/chatnumber.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

const storage = FlutterSecureStorage();
final FirebaseFirestore firestore = FirebaseFirestore.instance;
List<String> userDocumentIds = [];
List<String> second = [];
List<String> Doctor = [];

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late User signedinuser;

  Future<Map<String, dynamic>> getDoctorInfo(String email) async {
    final Email = {
      "email": email,
    };

    final response = await http.post(
      Uri.parse('https://marham-backend.onrender.com/doctor/getDocByEmail/12'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(Email),
    );

    if (response.statusCode == 200) {
      var responseBody = response.body.toString();
      responseBody = responseBody.trim();
      var user = jsonDecode(responseBody);
      print(user);
      return user;
    } else {
      print('no doctor info found');
      // You may want to throw an exception or handle the error accordingly
      throw Exception('Failed to load doctor info');
    }
  }

  @override
  void initState() {
    super.initState();
    getcurrentUser();
    _fetchUserDocumentIds();
  }

  Future<void> getcurrentUser() async {
    try {
      var user = FirebaseAuth.instance.currentUser;
      print(user?.email);
      if (user != null) {
        setState(() {
          signedinuser = user;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 140,
        backgroundColor: Colors.white,
        title: const Row(
          children: [
            SizedBox(width: 170),
            Text(
              "Chat",
              style: TextStyle(
                fontSize: 37,
                color: Color(0xFF0561DD),
                fontFamily: 'Salsa',
              ),
            ),
            SizedBox(width: 160),
            FaIcon(
              FontAwesomeIcons.comments,
              size: 35,
              color: Colors.blue,
            ),
          ],
        ),
        leading: BackButton(
          color: Colors.black,
          onPressed: () => {Navigator.of(context).pop()},
        ),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: second.length,
          itemBuilder: (context, index) {
            var reversedIndex = second.length - 1 - index;

            return FutureBuilder<Map<String, dynamic>>(
              future: getDoctorInfo(second[reversedIndex]),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // You can return a loading indicator while data is being fetched
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  // Handle errors
                  return Text('');
                } else {
                  var doctorInfo = snapshot.data!;
                  // If data is successfully fetched, build the PersonChat
                  
                  return PersonChat(
                      email: doctorInfo['email'],
                      image: doctorInfo['image']['secure_url'],
                      name:doctorInfo['name']); // Replace with the actual property you need
                }
              },
            );
          },
        ),
      ),
    );
  }

/*ListView.builder(
          // Set reverse to true
          itemCount: second.length,
          itemBuilder: (context, index) {
            final reversedIndex = second.length - 1 - index;
            return PersonChat(email: second[reversedIndex]);
          },
        ), */
  Future<List<String>> getAllUsers() async {
    List<String> documentIds = [];

    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('sender-reciver').get();

      if (querySnapshot.docs.isNotEmpty) {
        // Iterate through all documents in the collection
        for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
          // Access the document ID and data of each document
          String documentId = documentSnapshot.id;
          Map<String, dynamic> userData =
              documentSnapshot.data() as Map<String, dynamic>;
          // Add the document ID to the list
          documentIds.add(documentId);
        }
      } else {
        print('No users found in the collection.');
      }
    } catch (e) {
      print('Error retrieving users: $e');
    }

    // Return the list of document IDs
    print('all Document IDa: $documentIds');
    return documentIds;
  }

  Future<void> _fetchUserDocumentIds() async {
    List<String> secondParts = [];
    List<String> ids = await getAllUsers();
    List<String> sos =
        ids.where((str) => str.startsWith(signedinuser.email!)).toList();
    for (String email in sos) {
      // Split each email at the underscore character
      List<String> parts = email.split('_');

      // Check if there is a second part before printing
      if (parts.length > 1) {
        secondParts.add(parts[1]);
      } else {
        print('Not enough parts after split for $email.');
      }
    }
    print(' $secondParts');
    setState(() {
      second = secondParts;
    });
  }
}
