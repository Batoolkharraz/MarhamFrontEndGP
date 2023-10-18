import 'package:flutter/material.dart';
import 'package:flutter_application_4/Auth/Login/ValidateForm.dart';
import 'package:flutter_application_4/Auth/Login/login.dart';
import 'package:flutter_application_4/Auth/resetpass/alert.dart';
import 'package:flutter_application_4/Auth/resetpass/update.dart';
class NewPassword extends StatefulWidget {
  NewPassword({Key? key}) : super(key: key);

  @override
  _NewPasswordState createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  var Password;
  var cPassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 25),
                child: Container(
                  child: Image.asset("assets/image (16).png"),
                  width:
                      600.0, // Set the width and height to make it a perfect circle
                  height: 600.0,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Center(
                  child: Text("Set Your New Password !",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 37,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Salsa')),
                ),
              ),
              Form(
                  key: formState,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 65, right: 60),
                    child: Column(
                      children: [
                        TextFormField(
                          controller:_passwordController,
                          obscureText: true,
                          style: TextStyle(
                            // Set the style for the entered text
                            fontSize: 25,
                            // Adjust the font size as per your preference
                          ),
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
                          validator: (value) {
                            if (value == null)
                              return "please fill all information";
                            else if (value.length < 8) {
                              return "Password sholud be at least 8 characters";
                            }
                          },
                          onSaved: (value) {
                            Password = value;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _confirmPasswordController,
                          onSaved: (text) {
                            cPassword = text;
                          },
                          validator: (text) {
                            if (text == null) {
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
                        SizedBox(
                          height: 45,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF0561DD),
                            fixedSize: Size(600, 80),
                          ).copyWith(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                                side: BorderSide(
                                    color: Color(0xFF0561DD), width: 2.0),
                              ),
                            ),
                          ),
                          onPressed: () {
                            if (validateForm(formState)) {
                              // Process the form data (e.g., submit to a server)
                             update(context,Password);
                             
                            } else {
                              print('Invalid');
                            }
                          },
                          child: Text('Confirm',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Salsa')),
                        ),
                        Container(
                            padding: EdgeInsets.only(top: 20, left: 80),
                            child: InkWell(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.arrow_back,
                                    size: 30,
                                  ),
                                  Text("Return to Login page",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 25,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Salsa')),
                                ],
                              ),
                              onTap: () => {
                                 Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return Login();
                              },
                            ))//
                              },
                            ))
                      ],
                    ),
                  )),
            ]),
          ),
        ));
  }
}
