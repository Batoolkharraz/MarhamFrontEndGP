import 'package:flutter/material.dart';
import 'package:flutter_application_4/Auth/Login/ValidateForm.dart';
import 'package:flutter_application_4/Auth/updateinformation/updatenow.dart';
 Future<void> showpasswordDialog(BuildContext context) async {
 var  password ;// Store the text input value
  final GlobalKey<FormState> signstate = GlobalKey<FormState>();
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Enter Your New Password',
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
                          keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                          labelText: 'Password',
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
                         obscureText: true,
                          style: TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontFamily: 'Salsa',
            ),
          onSaved: (text) {
                              password = text;
                            },
                            validator:(text)
                            {
                              if (text == null || text.isEmpty)
                              return"please fill all information";
                              else if(text.length<8)
                              {
                                return "Password sholud be at least 8 characters";
                              }

                            },
               
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
                updateinformation(password,"password");
              print('Entered text: $password ');
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
