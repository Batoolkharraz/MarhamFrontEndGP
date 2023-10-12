import 'package:flutter/material.dart';
import 'package:flutter_application_4/Auth/Login/ValidateForm.dart';
import 'package:flutter_application_4/Auth/Login/login.dart';
import 'package:flutter_application_4/Auth/signup/onPressed.dart';
import 'package:flutter_application_4/Auth/signup/signuppost.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final GlobalKey<FormState> signstate = GlobalKey<FormState>();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  var username, phone, email, password, cpassword;

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset(
            "assets/Sign_Up_bg.svg",
            fit: BoxFit.cover,
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.fromLTRB(15, 240, 15, 0),
                padding: EdgeInsets.fromLTRB(10,0, 10,0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Create Account",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "Already have an account?",
                          style: TextStyle(fontSize: 25),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return Login();
                              },
                            ));
                          },
                          child: Text(
                            "LogIn!",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          style: ButtonStyle(
                            mouseCursor: MaterialStateMouseCursor.textable,
                          ),
                        ),
                        SizedBox(height: 50.0),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    Form(
                      key: signstate,
                      child: Column(
                        children: [
                          TextFormField(
                            onSaved: (text) {
                              username = text;
                            },
                            validator: (text){
                              if(text ==null)
                              {
                                return "please fill all information";
                              }
                              else

                              {if (text.length < 3 || text.length > 20) {
                                return "invalid username";
                              }
                               final RegExp regex = RegExp(r'^[a-zA-Z0-9_]+$');
                              if (!regex.hasMatch(text)) {
                                return "invalid username";
                              }}

                              // Check if the username contains only alphanumeric characters and underscores.
                             

                            },
                            decoration: InputDecoration(
                              labelText: 'Username',
                              labelStyle: TextStyle(
                                fontSize: 25,
                              ),
                            ),
                            style: TextStyle(
                              // Set the style for the entered text
                              fontSize: 25,
                            ),
                          ),
                          SizedBox(height: 16.0),
                          TextFormField(
                            onSaved: (text) {
                              email = text;
                            },
                           validator: (value) {
                              final RegExp emailRegex = RegExp(
                                r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                              );

                              if (value == null || value.isEmpty) {
                                return 'Please enter an email address.';
                              }

                              if (!emailRegex.hasMatch(value)) {
                                return 'Invalid email address format.';
                              }

                              return null; // Return null for no validation errors
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: "test@email.com",
                              labelText: "Email",
                              labelStyle: TextStyle(
                                fontSize: 25,
                              ),
                              hintStyle: TextStyle(
                                fontSize: 25,
                              ),
                            ),
                            style: TextStyle(
                              // Set the style for the entered text
                              fontSize: 25,
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            onSaved: (text) {
                              phone = text;
                            },
                            validator: (text){
                              if(text ==null)
                              return "please fill all information";
                               final RegExp phoneRegex = RegExp(r'^\d{10}$');
                              if (!phoneRegex.hasMatch(text)) {
                                return 'Invalid phone number';
                              }
                            },
                            decoration: InputDecoration(
                              labelText: 'Phone Number',
                              hintText: '+972',
                              labelStyle: TextStyle(
                                fontSize: 25,
                              ),
                              hintStyle: TextStyle(
                                fontSize: 25,
                              ),
                            ),
                            style: TextStyle(
                              // Set the style for the entered text
                              fontSize: 25,
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(controller: _passwordController,
                            onSaved: (text) {
                              password = text;
                            },
                            validator:(text)
                            {
                              if(text ==null)
                              return"please fill all information";
                              else if(text.length<8)
                              {
                                return "Password sholud be at least 8 characters";
                              }

                            },
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: "Password",
                              hintText: "*************",
                              labelStyle: TextStyle(
                                fontSize: 25,
                              ),
                              hintStyle: TextStyle(
                                fontSize: 25,
                              ),
                            ),
                            style: TextStyle(
                              // Set the style for the entered text
                              fontSize: 25,
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField( controller: _confirmPasswordController,
                            onSaved: (text) {
                              cpassword = text;
                            },
                            validator: (text)
                            {
                              if(text ==null)
                              {
                                return "please fill all information";
                              }
                               if (text != _passwordController.text) {
                                return 'Passwords do not match.';
                              }
                              
                              
                            },
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: "Confirm password",
                              hintText: "*************",
                              labelStyle: TextStyle(
                                fontSize: 25,
                              ),
                              hintStyle: TextStyle(
                                fontSize: 25,
                              ),
                            ),
                            style: TextStyle(
                              // Set the style for the entered text
                              fontSize: 25,
                              // Adjust the font size as per your preference
                            ),
                          ),
                          SizedBox(height: 40.0),
                          ElevatedButton(
                           onPressed: () {
                              if(validateForm(signstate))
                              {
                              onPressed(context, username, email, phone, password, cpassword);
                              }
                              else
                              {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Incorrect Data',
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontFamily: 'Helvetica',
                                      ),
                                    ),
                                    backgroundColor:
                                        Color.fromARGB(221, 252, 57, 43),
                                    duration: Duration(seconds: 3),
                                  ),
                                );
                              }
                            },
                            child: Text(
                              "Sign Up",
                              style: TextStyle(fontSize: 25),
                            ),
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(600, 60),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
