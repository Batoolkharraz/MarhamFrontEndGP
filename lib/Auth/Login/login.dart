import 'package:flutter/material.dart';
import 'package:flutter_application_4/Auth/Login/onpresseButton.dart';
import 'package:flutter_application_4/Auth/resetpass/reset.dart';
import 'package:flutter_application_4/Auth/signup/signup.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
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
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 2),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.fromLTRB(10, 300, 10, 200),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Sign in",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                    Row(
                      children: [
                        const Text(
                          "Don't have an account?",
                          style: TextStyle(fontSize: 25),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return const Signup();
                              },
                            ));
                          },
                          style: const ButtonStyle(
                            mouseCursor: MaterialStateMouseCursor.textable,
                          ),
                          child: const Text(
                            "Sign Up!",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
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
                                return "Please fill in your Email";
                              }
                              return null;
                            },
                            style: const TextStyle(fontSize: 25),
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              labelStyle: TextStyle(fontSize: 25),
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          TextFormField(
                            controller: _passwordController,
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return "Please fill in your password";
                              }
                              return null;
                            },
                            obscureText: true,
                            style: const TextStyle(fontSize: 25),
                            decoration: const InputDecoration(
                              labelText: 'Password',
                              hintText: 'Enter your password',
                              labelStyle: TextStyle(fontSize: 25),
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                onButtonPressed(
                                    context,
                                    _usernameController.text,
                                    _passwordController.text);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Please fill in both Email and password',
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
                              "Sign In",
                              style: TextStyle(
                                fontSize: 25,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            child: InkWell(
                              child: const Text(
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
                                    return const ResetPassword();
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
