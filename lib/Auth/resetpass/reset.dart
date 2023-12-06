import 'package:flutter/material.dart';
import 'package:flutter_application_4/Auth/Login/ValidateForm.dart';
import 'package:flutter_application_4/Auth/Login/login.dart';
import 'package:flutter_application_4/Auth/resetpass/onpressed.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  var email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top:10,left: 25),
              child: 
              SizedBox(
                width:600.0, // Set the width and height to make it a perfect circle
                height: 600.0,
                child:Image.asset("assets/image (14).png"),
              ),
            ),
            const SizedBox(height:10,),
            Container(
              child: const Center(
                child: Text("Forgot your Password ?",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 37,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Salsa')),
              ),
            ),
            const SizedBox(
              width: 398,
              child: Text("Enter Your email to reset it!",
                  style: TextStyle(
                      color: Color.fromARGB(255, 110, 106, 106),
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Salsa')),
            ),
            Form(
                key: formState,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 65, right: 60),
                  child: Column(
                    children: [
                      TextFormField(
                        style: const TextStyle(
                            // Set the style for the entered text
                            fontSize: 25,
                            // Adjust the font size as per your preference
                          ),
                        decoration: const InputDecoration(
                            labelText: 'E-mail',
                            hintText: 'test@email.com',
                            labelStyle: TextStyle(fontSize: 25),
                            hintStyle: TextStyle(fontSize: 25)),
                        validator: (value) {
                             final RegExp emailRegex = RegExp(
                                r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                              );

                              if (value == null || value.isEmpty) {
                                return 'Please enter your email address.';
                              }

                              if (!emailRegex.hasMatch(value)) {
                                return 'Invalid email address format.';
                              }

                             
                          return null;
                        },
                        onSaved: (value) {
                          email = value;
                        },
                      ),
                      const SizedBox(height: 45,),
                      ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0561DD),
    fixedSize: const Size(600, 80),
  ).copyWith(
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100),
        side: const BorderSide(color: Color(0xFF0561DD), width: 2.0),
      ),
    ),
  ),
              onPressed: ()  {
                if (validateForm(formState)) {
                  // Process the form data (e.g., submit to a server)
                 pressedButton(context, email);
                }
                else{
                  ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Somthing is wrong',
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
              },
              child: const Text('Confirm',
               style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Salsa')),
              
            ),
                    ],
                  ),
                )),
                Container(
                  padding: const EdgeInsets.only(top:50,left: 140),
                  child: InkWell(
                    child: const Row(
                    children: [
                      Icon(Icons.arrow_back,size: 30,),
                      Text("Return to Login page"
                      ,style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 25,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Salsa')
                      
                      ),
                    ],
                  ),
                  onTap: () => {
                     Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return const Login();
                              },
                            ))//
                  },
                  )
                )
          ],
        ),
        
      )),
    );
  }
}
