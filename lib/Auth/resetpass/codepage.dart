import 'package:flutter/material.dart';
import 'package:flutter_application_4/Auth/Login/ValidateForm.dart';
import 'package:flutter_application_4/Auth/resetpass/setNewpass.dart';

class CodePage extends StatefulWidget {
  const CodePage({Key? key}) : super(key: key);

  @override
  State<CodePage> createState() => _CodePageState();
}

class _CodePageState extends State<CodePage> {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  var codefromtext;
  var codeis;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Access the passed data from the ModalRoute settings
    final routeArguments = ModalRoute.of(context)!.settings.arguments;
    if (routeArguments != null) {
      codeis = routeArguments as String;
      print("from codepage: " + codeis);
      // Cast to the appropriate data type
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.only(top: 80),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 25),
                      child: SizedBox(
                        width:
                            600.0, // Set the width and height to make it a perfect circle
                        height: 500.0,
                        child: Image.asset(
                          "assets/image (17).png",
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: const Center(
                        child: Text("Enter Your Code now !",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 37,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Salsa')),
                      ),
                    ),
                    const SizedBox(
                      width: 340,
                      child: Text("We send email to you !",
                          style: TextStyle(
                              color: Color.fromARGB(255, 110, 106, 106),
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Salsa')),
                    ),
                    Form(
                        key: formState,
                        child: Padding(
                            padding: const EdgeInsets.only(
                                top: 20, left: 65, right: 60),
                            child: Column(
                              children: [
                                TextFormField(
                                    onSaved: (text) {
                                      codefromtext = text;
                                    },
                                    style: const TextStyle(
                                      // Set the style for the entered text
                                      fontSize: 25,
                                      // Adjust the font size as per your preference
                                    )),
                                const SizedBox(
                                  height: 30,
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF0561DD),
                                    fixedSize: const Size(600, 80),
                                  ).copyWith(
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        side: const BorderSide(
                                            color: Color(0xFF0561DD),
                                            width: 2.0),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    if (validateForm(formState)) {
                                      if (codeis == codefromtext) {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return const NewPassword(); // Pass successful to the constructor
                                            },
                                          ),
                                        );
                                      }
                                      else{
                                        ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Code is Not Correct',
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
                                    }
                                   
                                  },
                                  child: const Text('Confirm',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 30,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Salsa')),
                                )
                              ],
                            ))),
                  ],
                ))));
  }
}
