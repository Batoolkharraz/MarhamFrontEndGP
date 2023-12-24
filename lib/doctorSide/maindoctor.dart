import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_4/Auth/chatotheside/chatlist.dart';
import 'package:flutter_application_4/doctorSide/dailyapp.dart';
import 'package:flutter_application_4/doctorSide/doctorHome.dart';
import 'package:flutter_application_4/doctorSide/searchUser.dart';
import 'package:flutter_application_4/doctorSide/working.dart';
import 'dart:typed_data';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_application_4/Auth/updateinformation/uploadimage.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

class mainDoctorpage extends StatefulWidget {
  const mainDoctorpage({super.key});

  @override
  State<mainDoctorpage> createState() => _mainDoctorpageState();
}

  
class _mainDoctorpageState extends State<mainDoctorpage> {
  
  final storage = const FlutterSecureStorage();
  Map<String, dynamic> Doctor = {};
  Uint8List? image;
 // final GlobalKey<FormState> signstate = GlobalKey<FormState>();


  void selectImage() async {
    XFile? file = await fileImage(ImageSource.gallery);
    Uint8List img = await pickImage(ImageSource.gallery);
    updateUserInformation(file);
    setState(() {
      image = img;
    });
  }


  Future<String> getTokenFromStorage() async {
    final token = await storage.read(key: 'jwt');
    if (token != null) {
      final String userId = getUserIdFromToken(token);
      await Future.delayed(const Duration(seconds: 2));
      return userId;
    } else {
      print('Token not found in local storage.');
      return '';
    }
  }

  String getUserIdFromToken(String token) {
    try {
      final Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      final String userId = decodedToken['id'];
      return userId;
    } catch (e) {
      print('Error decoding token: $e');
      return '';
    }
  }

  Future getDoctorrInfo() async {
    String id = await getTokenFromStorage();
    var url = "https://marham-backend.onrender.com/doctor/find/${id}";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var responceBody = response.body.toString();
      responceBody = responceBody.trim();
      var user = jsonDecode(responceBody);
      setState(() {
        Doctor.addAll(user);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getDoctorrInfo();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top:35,bottom: 20),
              child: Container(
                 decoration: const BoxDecoration(
                                    shape: BoxShape.rectangle, // This makes the container circular
                                  color: Color.fromARGB(203, 255, 255, 255),
                                   border: Border(
        bottom: BorderSide(
          color: Colors.blue,  // Choose the color you want
          width: 5.0,           // Choose the border width
        ),
                                   )
                                  
                                    // You can change the background color
                                  ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      
                      Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.blue, width: 3),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF0561DD).withOpacity(0.3),
                                  offset: const Offset(0, 4),
                                  blurRadius: 15,
                                ),
                              ],
                            ),
                            child: Doctor['image'] != null
                                      ? InkWell(child:
                                      CircleAvatar(
                                          backgroundColor: Colors.transparent,
                                          backgroundImage: NetworkImage(
                                              Doctor['image']['secure_url']),
                                          radius: 40,
                                        ),
                                        onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const doctorHome(),
                          ),
                        );
                      },
                                      )
                                      : 
                                      InkWell(child: CircleAvatar(
                                          backgroundImage: AssetImage(
                                              'assets/5bbc3519d674c.jpg'),
                                          radius: 40,
                                        ),
                                           onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const doctorHome(),
                          ),
                        );
                      },
                                       ),
                                       
                      ),
                                       SizedBox(width: 20,),
                                         Container(
                                          width: 350,
                                           child: Text(
                                                             Doctor['name'] == null ? '' : Doctor['name'],
                                                             style: TextStyle(
                                                               fontSize: 30,
                                                               color: Colors.black,
                                                               fontWeight: FontWeight.bold,
                                                               fontFamily: 'Salsa',
                                                             ),
                                                           ),
                                         ),
                  IconButton(
                icon: const Icon(
                  Icons.comment,
                  color: Color(0xFF0561DD),
                  size: 40,
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ChatPage2(),
                    ),
                  );
                },
              ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20,left:20,right: 20),
              child: InkWell
              (child:
              Container(
                height: 200,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
      color: Colors.grey, // Set the color of the border
      width: 2.0, // Set the width of the border
    ),
                          borderRadius: BorderRadius.all(
                             Radius.circular(50.0),
                            
                          )),
                          child: Row(
                            children: [
                               Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10,left: 20),
                              child: SizedBox(
                                width: 150,
                                child: Image.asset('assets/calendar_3483794.png'),
                              ),
                            ),
                            SizedBox(width: 20
                            ,),
                              const Text(
                              'Daily Appointment',
                              style: TextStyle(
                                color: Color.fromARGB(255, 64, 63, 63),
                                fontSize: 27,
                                fontFamily: 'salsa',
                              ),
                            ),
                            ],
                          ),
                          
              ),
                onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const AppointmentPage(),
                          ),
                        );
                      },
              )
            ),

            Padding(
              padding: const EdgeInsets.only(top: 20,left:20,right: 20),
              child:InkWell
              (child:
               Container(
                height: 200,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
      color: Colors.grey, // Set the color of the border
      width: 2.0, // Set the width of the border
    ),
                          borderRadius: BorderRadius.all(
                             Radius.circular(50.0),
                            
                          )),
                          child: Row(
                            children: [
                               Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10,left: 20),
                              child: SizedBox(
                                width: 150,
                                child: Image.asset('assets/searching_5918993.png'),
                              ),
                            ),
                            SizedBox(width: 20
                            ,),
                              const Text(
                              'search for patient',
                              style: TextStyle(
                                color: Color.fromARGB(255, 64, 63, 63),
                                fontSize: 27,
                                fontFamily: 'salsa',
                              ),
                            ),
                            ],
                          ),
                          
              ),
              onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const searchUser(),
                          ),
                        );
                      },
              )
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20,left:20,right: 20),
              child:InkWell(child:
               Container(
                height: 200,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
      color: Colors.grey, // Set the color of the border
      width: 2.0, // Set the width of the border
    ),
                          borderRadius: BorderRadius.all(
                             Radius.circular(50.0),
                            
                          )),
                          child: Row(
                            children: [
                               Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10,left: 20),
                              child: SizedBox(
                                width: 150,
                                child: Image.asset('assets/time_3504970.png'),
                              ),
                            ),
                            SizedBox(width: 20
                            ,),
                              const Text(
                             'Make Your Schedule',
                              style: TextStyle(
                                color: Color.fromARGB(255, 64, 63, 63),
                                fontSize: 27,
                                fontFamily: 'salsa',
                              ),
                            ),
                            ],
                          ),
                          
              ),
               onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const Workingdoctor(),
                          ),
                        );
                      },
              )
            ),
          ],
        ),
      ),
    );
  }
}