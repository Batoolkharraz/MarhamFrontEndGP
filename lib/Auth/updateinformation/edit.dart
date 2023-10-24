import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_application_4/Auth/updateinformation/upmail.dart';
import 'package:flutter_application_4/Auth/updateinformation/test.dart';
import 'package:flutter_application_4/Auth/updateinformation/uploadimage.dart';
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
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      image = img;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Container(
                  padding: EdgeInsets.only(left: 30),
                  alignment: Alignment.centerLeft,
                  width: 600,
                  height: 50,
                  child: Row(
                    children: [
                      InkWell(
                        child: Icon(
                          Icons.arrow_back,
                          size: 30,
                        ),
                        onTap: () => {
                          Navigator.of(context).pop()
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 150),
                        child: Text(
                          "Edit Profile",
                          style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      
                    ],
                  ),
                ),
              ),
              Container(
                width: 600,
                height: 250,
                color: Color.fromARGB(209, 126, 126, 123),
                child: Stack(
                  children: [
                    image != null
                        ? Padding(
                            padding: const EdgeInsets.only(top: 50, left: 180),
                            child: CircleAvatar(
                              radius: 90,
                              backgroundImage: MemoryImage(image!),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(top: 50, left: 200),
                            child: CircleAvatar(
                              radius: 90,
                              backgroundImage:
                                  AssetImage("assets/5bbc3519d674c.jpg"),
                            ),
                          ),
                    Positioned(
                        child: IconButton(
                          onPressed: selectImage,
                          icon: Icon(
                            Icons.add_a_photo,
                            size: 28,
                            color: Colors.blue,
                          ),
                        ),
                        bottom:30,
                        left:320),
                  ],
                ),
              ),
              
          
              Padding(
                padding: const EdgeInsets.only(top: 50, left: 40, right: 40),
                child: Form(
                  child: Column(
                    children: [
                        Container( width: 460,
              child: Text("Personal Infromation",
                style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontFamily: 'Salsa',
                          fontSize: 30, // Adjust the font size as needed
                        ),
              ),),
              SizedBox(height: 30,),
                        ElevatedButton( style: ElevatedButton.styleFrom(
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
                          child: Text("UserName",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Salsa',
                          fontSize: 30, // Adjust the font size as needed
                        ),
                        ),

                        onPressed: () => {
                          showTextDialog(context),
                          print("username")
                        },
                      ),
                      SizedBox(height: 30,),
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
                        child: Text("Email",
                         style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Salsa',
                          fontSize: 30, // Adjust the font size as needed
                        ),),
                        onPressed: () => {
                          showemailDialog(context),
                          print("Email")
                        },
                      ),
                      SizedBox(height: 30,),
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
                        child: Text("Phone",
                         style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Salsa',
                          fontSize: 30, // Adjust the font size as needed
                        ),),
                        onPressed: () => {
                          showPhoneDialog(context),
                          print("Phone")
                        },
                      ),
                      SizedBox(height: 30,),
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
                        child: Text("Password",
                         style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Salsa',
                          fontSize: 30, // Adjust the font size as needed
                        ),),
                        onPressed: () => {
                          showpasswordDialog(context),
                          print("Password")
                        },
                      ),
                    ],
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
