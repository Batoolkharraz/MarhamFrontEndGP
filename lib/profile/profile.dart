import 'dart:convert';
import 'package:flutter_application_4/Auth/updateinformation/edit.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_application_4/medicine/medicineSchedule.dart';
import 'package:flutter_application_4/unit/medicineList.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  List prescriptions = [];
  Map<String, dynamic> User = {};
  final storage = const FlutterSecureStorage();
  String userId = '';

  @override
  void initState() {
    super.initState();
    getPrescription();
    getUserInfo();
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

Future<void> getPrescription() async {
  try {
    String id = await getTokenFromStorage();
    var url = "https://marham-backend.onrender.com/prescription/forUser/$id";
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var responseBody = response.body.toString();
      responseBody = responseBody.trim();
      responseBody = responseBody.substring(17, responseBody.length - 1);
      var pre = jsonDecode(responseBody);

      // Convert date strings to DateTime and sort by dateFrom in descending order
      pre.sort((a, b) {
        DateTime dateA = DateFormat('MM/dd/yyyy').parse(a['dateFrom']);
        DateTime dateB = DateFormat('MM/dd/yyyy').parse(b['dateFrom']);
        return dateB.compareTo(dateA);
      });

      // Format the sorted date as dd/mm/yyyy
      DateFormat fromFormat = DateFormat('dd/MM/yyyy');
      for (var prescription in pre) {
        prescription['dateFrom'] = fromFormat
            .format(DateFormat('MM/dd/yyyy').parse(prescription['dateFrom']));
        prescription['dateTo'] = fromFormat
            .format(DateFormat('MM/dd/yyyy').parse(prescription['dateTo']));
      }

      // Check if the widget is still mounted before calling setState
      if (mounted) {
        setState(() {
          prescriptions.clear();
          prescriptions.addAll(pre);
        });
      }
    }
  } catch (e) {
    // Handle the error, e.g., print or log it
    print('Error fetching prescriptions: $e');
  }
}


Future getUserInfo() async {
  String userid = await getTokenFromStorage();
  var url = "https://marham-backend.onrender.com/giveme/getUser/$userid";
  
  try {
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var responceBody = response.body.toString();
      responceBody = responceBody.trim();
      var user = jsonDecode(responceBody);

      // Check if the widget is still mounted before calling setState
      if (mounted) {
        setState(() {
          User.addAll(user);
        });
      }
    }
  } catch (e) {
    // Handle the error, e.g., print or log it
    print('Error fetching user info: $e');
  }
}


  Future<String> getDoctor(String docId) async {
    var url =
        "https://marham-backend.onrender.com/doctor/651c58f32cd651e7a27ac12f";
    var response = await http.get(Uri.parse(url));
    var responceBody = response.body.toString();
    responceBody = responceBody.trim();
    responceBody = responceBody.substring(10, responceBody.length - 1);
    var doc = jsonDecode(responceBody);

    return doc['name'];
  }

Future getAppointment() async {
    String id = await getTokenFromStorage();
    var url = "https://marham-backend.onrender.com/prescription/forUser/$id";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var responceBody = response.body.toString();
      responceBody = responceBody.trim();
      responceBody = responceBody.substring(17, responceBody.length - 1);
      var pre = jsonDecode(responceBody);

      // Convert date strings to DateTime and sort by dateFrom in descending order
      pre.sort((a, b) {
        DateTime dateA = DateFormat('MM/dd/yyyy').parse(a['dateFrom']);
        DateTime dateB = DateFormat('MM/dd/yyyy').parse(b['dateFrom']);
        return dateB.compareTo(dateA);
      });

      // Format the sorted date as dd/mm/yyyy
      DateFormat fromFormat = DateFormat('dd/MM/yyyy');
      for (var prescription in pre) {
        prescription['dateFrom'] = fromFormat
            .format(DateFormat('MM/dd/yyyy').parse(prescription['dateFrom']));
        prescription['dateTo'] = fromFormat
            .format(DateFormat('MM/dd/yyyy').parse(prescription['dateTo']));
      }

      setState(() {
        prescriptions.clear();
        prescriptions.addAll(pre);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: const Color.fromARGB(255, 231, 233, 237),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
            child: IconButton(
              icon: const Icon(
                Icons.edit_note_sharp,
                color: Color(0xFF0561DD),
                size: 40,
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const EditUser(),
                  ),
                );
              },
            ),
          )
        ],
      ),
      body: Column(
        children: [
          //head
          User.isEmpty
              ? const SizedBox(
                  height: 270,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : SizedBox(
                  height: 270,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
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
                          child: User['image'] != null
                              ? CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  backgroundImage:
                                      NetworkImage(User['image']['secure_url']),
                                  radius: 90,
                                )
                              : const CircleAvatar(
                                  backgroundImage:
                                      AssetImage('assets/5bbc3519d674c.jpg'),
                                  radius: 90,
                                ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        User['username'] ?? 'userName',
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Salsa',
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        User['email'] ?? 'email not found',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Salsa',
                        ),
                      ),
                    ],
                  ),
                ),

          const SizedBox(
            height: 20,
          ),

          //my appointment
          Container(
            height: 655,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50.0),
                topRight: Radius.circular(50.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 40),
              child: Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //title
                     
                          const Text(
                            'Personal Information',
                            style: TextStyle(
                              color: Color(0xFF0561DD),
                              fontSize: 28,
                              fontFamily: 'salsa',
                            ),
                          ),
                          
                      

                      const SizedBox(
                        height: 10,
                      ),

                      //appointment
                      User.isEmpty
              ? const SizedBox(
                  height: 270,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ):
                      SizedBox(
                        height:
                            210, // Set a fixed height or use a different value based on your design
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            //  final appointment = appointmentList[index];
                            return Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child:Container(
                                
                                height: 200,
                                decoration: BoxDecoration(
                                  border: Border.all(
                            width: 2,
                            color: const Color(0xFF0561DD),
                          ),
                          borderRadius: BorderRadius.circular(10),
                                ),
                                
                                child: Column(
                                  children: [
                                    const SizedBox(height: 25,),
                                    Row(
                                      children: [
                                        const SizedBox(width: 25,),
                                        const FaIcon(FontAwesomeIcons.user,
                                  color: Colors.blue, size: 30.0),
                                   const SizedBox(width: 10,),
                                  Text(User['username']?? 'not found',
                                  style: const TextStyle(
                               color: Colors.black,
                                fontSize: 26,
                                fontFamily: 'salsa',
                              ),
                                  )
                                      ],
                                    ),
                                    const SizedBox(height: 15,),
                                    Row(
                                      children: [
                                        const SizedBox(width: 25,),
                                        const FaIcon(FontAwesomeIcons.locationDot,
                                  color: Colors.blue, size: 30.0),
                                   const SizedBox(width: 10,),
                                  Text('nablus',
                                  style: const TextStyle(
                                color: Colors.black,
                                fontSize: 26,
                                fontFamily: 'salsa',
                              ),
                                  )
                                      ],
                                    ),
                                     const SizedBox(height:15,),
                                    Row(
                                      children: [
                                        const SizedBox(width: 25,),
                                        const FaIcon(FontAwesomeIcons.mobileScreen,
                                  color: Colors.blue, size: 30.0),
                                   const SizedBox(width: 10,),
                                  Text(User['phone'] ?? 'not found',
                                  style: const TextStyle(
                                color: Colors.black,
                                fontSize: 26,
                                fontFamily: 'salsa',
                              ),
                                  )
                                      ],
                                    ),
                                    
                                  ],
                                ),
                              )
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //title
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Your medicine',
                              style: TextStyle(
                                color: Color(0xFF0561DD),
                                fontSize: 30,
                                fontFamily: 'salsa',
                              ),
                            ),
                            Text(
                              'see all',
                              style: TextStyle(
                                color: Color(0xFF0561DD),
                                fontSize: 20,
                                fontFamily: 'salsa',
                              ),
                            ),
                          ],
                        ),

                        prescriptions.isEmpty
                            ? Center(
                                child: Column(
                                  children: [
                                    Container(
                                      child: Image.asset('assets/medicine.png'),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'No Prescription written for You Yet!',
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontFamily: 'salsa',
                                        fontSize: 25,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            :
                             SizedBox(
                                height: 250,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: prescriptions.length,
                                  itemBuilder: (context, index) {
                                    return FutureBuilder(
                                      future: getDoctor(
                                          '${prescriptions[index]['writtenBy']}'),
                                      builder: (context, categorySnapshot) {
                                        if (categorySnapshot.hasError) {
                                          return Text(
                                              'Error: ${categorySnapshot.error}');
                                        } else {
                                          return Container(
                                            child: medicineList(
                                              diagnosis: prescriptions[index]
                                                  ['diagnosis'],
                                              from: prescriptions[index]
                                                  ['dateFrom'],
                                              to: prescriptions[index]
                                                  ['dateTo'],
                                              writtenBy: categorySnapshot.data
                                                  .toString(),
                                              onTap: () {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        medicineSchedule(
                                                      medicines:
                                                          prescriptions[index]
                                                              ['medicines'],
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          );
                                        }
                                      },
                                    );
                                  },
                                  physics: const BouncingScrollPhysics(),
                                ),
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
