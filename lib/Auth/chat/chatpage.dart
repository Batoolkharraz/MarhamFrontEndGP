import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_4/Auth/chat/chatnumber.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const storage = FlutterSecureStorage();
final FirebaseFirestore firestore = FirebaseFirestore.instance;
 List<String> userDocumentIds = [];
 List<String> second=[];
class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late User signedinuser;

  @override
  void initState() {
    super.initState();
    getcurrentUser();
    _fetchUserDocumentIds();
  }

  Future<void> getcurrentUser() async {
    try {
      var user = await FirebaseAuth.instance.currentUser;
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
      body: 
       Container(
  child: ListView.builder(
     // Set reverse to true
    itemCount: second.length,
    itemBuilder: (context, index) {
      final reversedIndex = second.length - 1 - index;
      return PersonChat(email: second[reversedIndex]);
    },
  ),
),

    );
  }

Future<List<String>> getAllUsers() async {
  List<String> documentIds = [];

  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('sender-reciver').get();

    if (querySnapshot.docs.isNotEmpty) {
      // Iterate through all documents in the collection
      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        // Access the document ID and data of each document
        String documentId = documentSnapshot.id;
        Map<String, dynamic> userData = documentSnapshot.data() as Map<String, dynamic>;
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
    List<String> sos = ids.where((str) => str.startsWith(signedinuser.email!)).toList();
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