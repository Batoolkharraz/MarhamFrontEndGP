import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_application_4/Auth/updateinformation/upmail.dart';
import 'package:flutter_application_4/Auth/updateinformation/test.dart';
import 'package:flutter_application_4/Auth/updateinformation/uploadimage.dart';
import 'package:flutter_application_4/profile/profile.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_application_4/Auth/updateinformation/upphone.dart';
import 'package:flutter_application_4/Auth/updateinformation/uppass.dart';

class EditUser extends StatefulWidget {
  const EditUser({Key? key}) : super(key: key);

  @override
  _EditUserState createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  final myController = TextEditingController();
  bool _isUsernameEditing = false;
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
      SnackBar(
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
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xFF0561DD),
          toolbarHeight: 90,
          elevation: 0,
          centerTitle: true,
          title: Text(
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
              icon: Icon(
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
                icon: Icon(
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
              Container(
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
                                  color: Color(0xFF0561DD), // Blue border color
                                  width: 3, // Adjust the border width as needed
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFF0561DD)
                                        .withOpacity(0.3), // Shadow color
                                    offset: Offset(0, 4), // Shadow position
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
                                    color: Color(0xFF0561DD)
                                        .withOpacity(0.3), // Shadow color
                                    offset: Offset(0, 4), // Shadow position
                                    blurRadius: 15, // Shadow blur radius
                                  ),
                                ],
                              ),
                              child: CircleAvatar(
                                radius: 90,
                                backgroundImage:
                                    AssetImage("assets/5bbc3519d674c.jpg"),
                              ),
                            ),
                          ),
                    Positioned(
                        child: IconButton(
                          onPressed: selectImage,
                          icon: Icon(
                            Icons.add_a_photo,
                            size: 35,
                            color: Color(0xFF0561DD),
                          ),
                        ),
                        bottom: 30,
                        left: 325),
                  ],
                ),
              ),
              SizedBox(
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
                        offset: Offset(0, 4), // Shadow position
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
                          Container(
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
                          SizedBox(
                            height: 30,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              fixedSize: Size(600, 80),
                            ).copyWith(
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                  side: BorderSide(
                                      color: Colors.grey, width: 2.0),
                                ),
                              ),
                            ),
                            child: Text(
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
                          SizedBox(
                            height: 30,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              fixedSize: Size(600, 80),
                            ).copyWith(
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                  side: BorderSide(
                                      color: Colors.grey, width: 2.0),
                                ),
                              ),
                            ),
                            child: Text(
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
                          SizedBox(
                            height: 30,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              fixedSize: Size(600, 80),
                            ).copyWith(
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                  side: BorderSide(
                                      color: Colors.grey, width: 2.0),
                                ),
                              ),
                            ),
                            child: Text(
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
                          SizedBox(
                            height: 30,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              fixedSize: Size(600, 80),
                            ).copyWith(
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                  side: BorderSide(
                                      color: Colors.grey, width: 2.0),
                                ),
                              ),
                            ),
                            child: Text(
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
                          SizedBox(
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
