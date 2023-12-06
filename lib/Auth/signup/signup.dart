import 'package:flutter/material.dart';
import 'package:flutter_application_4/Auth/Login/ValidateForm.dart';
import 'package:flutter_application_4/Auth/Login/login.dart';
import 'package:flutter_application_4/Auth/signup/onPressed.dart';
import 'package:flutter_svg/flutter_svg.dart';
class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final GlobalKey<FormState> signstate = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  var username, phone, email, password, cpassword;
  bool isChecked = false;
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
                margin: const EdgeInsets.fromLTRB(15, 240, 15, 0),
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Create Account",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        const Text(
                          "Already have an account?",
                          style: TextStyle(fontSize: 25),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return const Login();
                              },
                            ));
                          },
                          style: const ButtonStyle(
                            mouseCursor: MaterialStateMouseCursor.textable,
                          ),
                          child: const Text(
                            "LogIn!",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 50.0),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    Form(
                      key: signstate,
                      child: Column(
                        children: [
                          TextFormField(
                            onSaved: (text) {
                              username = text;
                            },
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return "please fill all information";
                              } else {
                                if (text.length < 3 || text.length > 20) {
                                  return "invalid username";
                                }
                                final RegExp regex = RegExp(r'^[a-zA-Z0-9_]+$');
                                if (!regex.hasMatch(text)) {
                                  return "invalid username";
                                }
                              }
                              return null;

                              // Check if the username contains only alphanumeric characters and underscores.
                            },
                            decoration: const InputDecoration(
                              labelText: 'Username',
                              labelStyle: TextStyle(
                                fontSize: 25,
                              ),
                            ),
                            style: const TextStyle(
                              // Set the style for the entered text
                              fontSize: 25,
                            ),
                          ),
                          const SizedBox(height: 16.0),
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
                            decoration: const InputDecoration(
                              hintText: "test@email.com",
                              labelText: "Email",
                              labelStyle: TextStyle(
                                fontSize: 25,
                              ),
                              hintStyle: TextStyle(
                                fontSize: 25,
                              ),
                            ),
                            style: const TextStyle(
                              // Set the style for the entered text
                              fontSize: 25,
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            onSaved: (text) {
                              phone = text;
                            },
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return "please fill all information";
                              return null;
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              labelText: 'Phone Number',
                              hintText: '+972',
                              labelStyle: TextStyle(
                                fontSize: 25,
                              ),
                              hintStyle: TextStyle(
                                fontSize: 25,
                              ),
                            ),
                            style: const TextStyle(
                              // Set the style for the entered text
                              fontSize: 25,
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _passwordController,
                            onSaved: (text) {
                              password = text;
                            },
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return "please fill all information";
                              } else if (text.length < 8) {
                                return "Password sholud be at least 8 characters";
                              }
                              return null;
                            },
                            obscureText: true,
                            decoration: const InputDecoration(
                              labelText: "Password",
                              hintText: "*************",
                              labelStyle: TextStyle(
                                fontSize: 25,
                              ),
                              hintStyle: TextStyle(
                                fontSize: 25,
                              ),
                            ),
                            style: const TextStyle(
                              // Set the style for the entered text
                              fontSize: 25,
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _confirmPasswordController,
                            onSaved: (text) {
                              cpassword = text;
                            },
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return "please fill all information";
                              }
                              if (text != _passwordController.text) {
                                return 'Passwords do not match.';
                              }
                              return null;
                            },
                            obscureText: true,
                            decoration: const InputDecoration(
                              labelText: "Confirm password",
                              hintText: "*************",
                              labelStyle: TextStyle(
                                fontSize: 25,
                              ),
                              hintStyle: TextStyle(
                                fontSize: 25,
                              ),
                            ),
                            style: const TextStyle(
                              // Set the style for the entered text
                              fontSize: 25,
                              // Adjust the font size as per your preference
                            ),
                          ),
                          const SizedBox(height: 40.0),
                          
                          ElevatedButton(
                            onPressed: () {
                              if (validateForm(signstate)) {
                                onPressed(
                                    context, username, email, phone, password);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
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
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0561DD),
                              fixedSize: const Size(600, 60),
                            ).copyWith(
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                  side: const BorderSide(
                                      color: Color(0xFF0561DD), width: 2.0),
                                ),
                              ),
                            ),
                            child: const Text(
                              "Sign Up",
                              style: TextStyle(fontSize: 25),
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
