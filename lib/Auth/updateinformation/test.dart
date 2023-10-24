import 'package:flutter/material.dart';
import 'package:flutter_application_4/Auth/Login/ValidateForm.dart'; 
import 'package:flutter_application_4/Auth/updateinformation/updatenow.dart';
 Future<void> showTextDialog(BuildContext context) async {
 var username;// Store the text input value
  final GlobalKey<FormState> signstate = GlobalKey<FormState>();
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Enter Your Name',
        style: TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontFamily: 'Salsa',
            ),),
        content:Container(
         
          width: 300, // Set the width as desired
    height:80, 
          child: Form(
                        key: signstate,
                        child:TextFormField(
                            decoration: InputDecoration(
                          labelText: 'UserName',
                          labelStyle: TextStyle(
                            fontSize: 28,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                          style: TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontFamily: 'Salsa',
            ),
            onSaved: (text) {
                                username = text;
                              },
                              validator: (text){
                                if (text == null || text.isEmpty)
                                {
                                  return "invalid username";
                                }
                                else
                                {
                                  if (text.length < 4 || text.length > 20) {
                                  return "invalid username";
                                }
                                 final RegExp regex = RegExp(r'^[a-zA-Z0-9_]+$');
                                if (!regex.hasMatch(text)) {
                                  return "invalid username";
                                }}
                              }
               
          ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 25,
              fontFamily: 'Salsa',
            ),),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
          TextButton(
            child: Text('OK',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 25,
              fontFamily: 'Salsa',
            ),),
            onPressed: () {
              if(validateForm(signstate))
              {
                updateinformation(username,"username");
              print('Entered text: $username');
                Navigator.of(context).pop(); 
              }
              else{
                print('invalis');
              }
            // Close the dialog
            },
          ),
        ],
      );
    },
  );
}
