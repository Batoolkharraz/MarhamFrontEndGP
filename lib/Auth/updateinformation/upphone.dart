import 'package:flutter/material.dart';
import 'package:flutter_application_4/Auth/Login/ValidateForm.dart';
import 'package:flutter_application_4/Auth/updateinformation/updatenow.dart';
 Future<void> showPhoneDialog(BuildContext context) async {
 var phone;// Store the text input value
  final GlobalKey<FormState> signstate = GlobalKey<FormState>();
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Enter Your Phone Number',
        style: TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontFamily: 'Salsa',
            ),),
        content:SizedBox(
         
          width: 300, // Set the width as desired
    height:80, 
          child: Form(
                        key: signstate,
                        child:TextFormField(
                          keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                          labelText: 'Phone Number',
                          labelStyle: const TextStyle(
                            fontSize: 28,
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                          style: const TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontFamily: 'Salsa',
            ),
             onSaved: (text) {
                              phone = text;
                            },
                            validator: (text){
                              if (text == null || text.isEmpty) {
                                return "please fill all information";
                              }
                               final RegExp phoneRegex = RegExp(r'^\d{10}$');
                              if (!phoneRegex.hasMatch(text)) {
                                return 'Invalid phone number';
                              }
                              return null;
                            },
               
          ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel',
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
            child: const Text('OK',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 25,
              fontFamily: 'Salsa',
            ),),
            onPressed: () {
              if(validateForm(signstate))
              {
                updateinformation(phone,"phone");
              print('Entered text: $phone');
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
