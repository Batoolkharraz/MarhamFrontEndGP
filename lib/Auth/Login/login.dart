import 'package:flutter/material.dart';
import 'package:flutter_application_4/Auth/Login/ValidateForm.dart';
import 'package:flutter_application_4/Auth/Login/onpresseButton.dart';
import 'package:flutter_application_4/Auth/signup/signup.dart';
import 'package:flutter_application_4/Home/homePage.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var username;
    var password;

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
                        SizedBox(height: 50.0),
                      ],
                    ),
                    // SizedBox(height: 30.0),
                    Form(
                      key: formstate,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            style: TextStyle(
                        fontSize: 25,
                            ),
                        
                            onSaved: (text) {
                              username = text;
                            },
                            decoration: InputDecoration(
                              
                                labelText: 'username',
                                //hintText: 'test@email.com',

                                labelStyle: TextStyle(fontSize: 25),
                                hintStyle: TextStyle(fontSize: 25)),
                          ),
                          SizedBox(height: 50.0),
                          TextFormField(
                            onSaved: (text) {
                              password = text;
                            },
                            obscureText: true,
                            style: TextStyle(
                        fontSize: 25,
                            ),
                            decoration: InputDecoration(
                                labelText: 'Password',
                                hintText: 'Enter your password',
                                labelStyle: TextStyle(fontSize: 25),
                                hintStyle: TextStyle(fontSize: 25)),
                          ),
                          SizedBox(height: 50.0),
                          ElevatedButton(
                           onPressed: () => {
                             if (validateForm(formstate)) 
                            {showDialog(context: context, 
                            builder: (context){
                              return Center(child: CircularProgressIndicator());
                            }),
                              onButtonPressed(context, username, password),
                                  Future.delayed(Duration(seconds: 2), () {
                                    Navigator.of(context)
                                        .pop(); // Close the loading dialog
                                    onButtonPressed(context, username,
                                        password); // Call your function
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return homePage(); // Navigate to the home page
                                        },
                                      ),
                                    );
                                  })
                                }
                              
                            
                            else
                                {
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
                                  )
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
