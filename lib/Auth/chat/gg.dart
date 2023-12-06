import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_4/Auth/chat/chatpage.dart';

add(String? email) async {
    try {
      String? toke2 = await storage.read(key: 'email');
      print(toke2);

      // Ensure firestore is of type FirebaseFirestore
       FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Get the current user
  
        // Use the update method to add a new field without removing existing data
         await firestore
             .collection('sender-reciver')
             .doc("${email}_${toke2}")
             .set({'email09':toke2});
      
     } catch (e) {
       print('Error: $e');
     }
   }