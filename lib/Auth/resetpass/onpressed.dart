import 'package:flutter/material.dart';
import 'package:flutter_application_4/Auth/resetpass/checkemail.dart';
import 'package:flutter_application_4/Auth/resetpass/codepage.dart';

Future<void> pressedButton(BuildContext context, String email) async {
  String? message = await checkEmail(email);
  print("pressed:");
  print(message);
  
  if (message ==false ) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'This User Is Not Found',
          style: TextStyle(
            fontSize: 25,
            fontFamily: 'Helvetica',
          ),
        ),
        backgroundColor: Color.fromARGB(221, 252, 57, 43),
        duration: Duration(seconds: 3),
      )
    );
  } else {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return const CodePage();
        },
        settings: RouteSettings(
          arguments: message,
        ),
      )
    );
  }
}
