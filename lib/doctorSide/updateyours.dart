import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_application_4/Auth/updateinformation/upmail.dart';
import 'package:flutter_application_4/Auth/updateinformation/test.dart';
import 'package:flutter_application_4/Auth/updateinformation/uploadimage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_application_4/Auth/updateinformation/upphone.dart';
import 'package:flutter_application_4/Auth/updateinformation/uppass.dart';

class EditDoctor extends StatefulWidget {
  const EditDoctor({Key? key}) : super(key: key);

  @override
  _EditDoctorState createState() => _EditDoctorState();
}

class _EditDoctorState extends State<EditDoctor> {
  final myController = TextEditingController();
  final bool _isUsernameEditing = false;
  var username, phone, email, password, cpassword;
  Uint8List? image;
  final GlobalKey<FormState> signstate = GlobalKey<FormState>();
  void selectImage() async {
    XFile? file = await fileImage(ImageSource.gallery);
    Uint8List img = await pickImage(ImageSource.gallery);
    updateUserInformation(file);
    setState(() {
      image = img;
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void saveData() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Color(0xFF0561DD),
        content: 
        Center(
          child: Text("The data has been saved",
          style: TextStyle(
            fontFamily: 'salsa',
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),),
        ),
        duration: Duration(seconds: 1), // The duration it will be displayed
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xFF0561DD),
          toolbarHeight: 90,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Edit Profile',
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Salsa',
            ),
          ),
          leading: Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 25,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 25,top: 5),
              child: IconButton(
                icon: const Icon(
                  Icons.save,
                  color: Colors.white,
                  size: 40,
                ),
                onPressed: () {
                  saveData();
                },
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                width: 600,
                height: 250,
                child: Stack(
                  children: [
                    image != null
                        ? Padding(
                            padding: const EdgeInsets.only(top: 50, left: 180),
                            child: Container(
                              width:
                                  180, // Width and height to accommodate the border
                              height: 180,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: const Color(0xFF0561DD), // Blue border color
                                  width: 3, // Adjust the border width as needed
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF0561DD)
                                        .withOpacity(0.3), // Shadow color
                                    offset: const Offset(0, 4), // Shadow position
                                    blurRadius: 15, // Shadow blur radius
                                  ),
                                ],
                              ),
                              child: CircleAvatar(
                                radius: 90,
                                backgroundImage: MemoryImage(image!),
                              ),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(top: 50, left: 200),
                            child: Container(
                              width:
                                  180, // Width and height to accommodate the border
                              height: 180,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.blue, // Blue border color
                                  width: 3, // Adjust the border width as needed
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF0561DD)
                                        .withOpacity(0.3), // Shadow color
                                    offset: const Offset(0, 4), // Shadow position
                                    blurRadius: 15, // Shadow blur radius
                                  ),
                                ],
                              ),
                              child: const CircleAvatar(
                                radius: 90,
                                backgroundImage:
                                    AssetImage("assets/5bbc3519d674c.jpg"),
                              ),
                            ),
                          ),
                    Positioned(
                        bottom: 30,
                        left: 325,
                        child: IconButton(
                          onPressed: selectImage,
                          icon: const Icon(
                            Icons.add_a_photo,
                            size: 35,
                            color: Color(0xFF0561DD),
                          ),
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3), // Shadow color
                        offset: const Offset(0, 4), // Shadow position
                        blurRadius: 20, // Shadow blur radius
                      ),
                    ],
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 40, left: 40, right: 40),
                    child: Form(
                      child: Column(
                        children: [
                          const SizedBox(
                            width: 460,
                            child: Text(
                              "Personal Infromation",
                              style: TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontFamily: 'Salsa',
                                fontSize: 30, // Adjust the font size as needed
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              fixedSize: const Size(600, 80),
                            ).copyWith(
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                  side: const BorderSide(
                                      color: Colors.grey, width: 2.0),
                                ),
                              ),
                            ),
                            child: const Text(
                              "User Name",
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Salsa',
                                fontSize: 30, // Adjust the font size as needed
                              ),
                            ),
                            onPressed: () =>
                                {showTextDialog(context), print("username")},
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              fixedSize: const Size(600, 80),
                            ).copyWith(
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                  side: const BorderSide(
                                      color: Colors.grey, width: 2.0),
                                ),
                              ),
                            ),
                            child: const Text(
                              "Email",
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Salsa',
                                fontSize: 30, // Adjust the font size as needed
                              ),
                            ),
                            onPressed: () =>
                                {showemailDialog(context), print("Email")},
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              fixedSize: const Size(600, 80),
                            ).copyWith(
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                  side: const BorderSide(
                                      color: Colors.grey, width: 2.0),
                                ),
                              ),
                            ),
                            child: const Text(
                              "Phone Number",
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Salsa',
                                fontSize: 30, // Adjust the font size as needed
                              ),
                            ),
                            onPressed: () =>
                                {showPhoneDialog(context), print("Phone")},
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              fixedSize: const Size(600, 80),
                            ).copyWith(
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                  side: const BorderSide(
                                      color: Colors.grey, width: 2.0),
                                ),
                              ),
                            ),
                            child: const Text(
                              "Password",
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Salsa',
                                fontSize: 30, // Adjust the font size as needed
                              ),
                            ),
                            onPressed: () => {
                              showpasswordDialog(context),
                              print("Password")
                            },
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
