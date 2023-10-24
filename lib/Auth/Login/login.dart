import 'package:flutter/material.dart';
import 'package:flutter_application_4/Auth/Login/ValidateForm.dart';
import 'package:flutter_application_4/Auth/Login/onpresseButton.dart';
import 'package:flutter_application_4/Auth/resetpass/reset.dart';
import 'package:flutter_application_4/Auth/signup/signup.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset(
            "assets/Sign_Up_bg.svg",
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 2),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.fromLTRB(10, 300, 10, 200),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Sign in",
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                    Row(
                      children: [
                        Text(
                          "Don't have an account?",
                          style: TextStyle(fontSize: 25),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return Signup();
                              },
                            ));
                          },
                          child: Text(
                            "Sign Up!",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          style: ButtonStyle(
                            mouseCursor: MaterialStateMouseCursor.textable,
                          ),
                        ),
                      ],
                    ),
                    // SizedBox(height: 30.0),
                    Form(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            controller: _usernameController,
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return "Please fill in your username";
                              }
                              return null;
                            },
                            style: TextStyle(fontSize: 25),
                            decoration: InputDecoration(
                              labelText: 'Username',
                              labelStyle: TextStyle(fontSize: 25),
                            ),
                          ),
                          SizedBox(height: 20.0),
                          TextFormField(
                            controller: _passwordController,
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return "Please fill in your password";
                              }
                              return null;
                            },
                            obscureText: true,
                            style: TextStyle(fontSize: 25),
                            decoration: InputDecoration(
                              labelText: 'Password',
                              hintText: 'Enter your password',
                              labelStyle: TextStyle(fontSize: 25),
                            ),
                          ),
                          SizedBox(height: 20.0),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                onButtonPressed(
                                    context,
                                    _usernameController.text,
                                    _passwordController.text);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Please fill in both username and password',
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
                              "Sign In",
                              style: TextStyle(
                                fontSize: 25,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(600, 60),
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            child: InkWell(
                              child: Text(
                                "Forgot your password?",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Salsa',
                                ),
                              ),
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) {
                                    return ResetPassword();
                                  },
                                ));
                              },
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
