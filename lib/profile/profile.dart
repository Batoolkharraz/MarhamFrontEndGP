import 'dart:convert';
import 'package:flutter_application_4/Auth/updateinformation/edit.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_application_4/medicine/medicineSchedule.dart';
import 'package:flutter_application_4/unit/appointmentList.dart';
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
  final storage = FlutterSecureStorage();
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
      await Future.delayed(Duration(seconds: 2));
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

  Future getPrescription() async {
    String id = await getTokenFromStorage();
    var url = "https://marham-backend.onrender.com/prescription/forUser/${id}";
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

  Future getUserInfo() async {
    String userid = await getTokenFromStorage();
    var url = "https://marham-backend.onrender.com/giveme/getUser/${userid}";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var responceBody = response.body.toString();
      responceBody = responceBody.trim();
      var user = jsonDecode(responceBody);
      setState(() {
        User = user;
      });
    }
  }

  Future<String> getDoctor(String docId) async {
    try {
      var url = "https://marham-backend.onrender.com/doctor/$docId";
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Parse the response body
        var doc = jsonDecode(response.body);

        // Check if the 'name' key is present in the response
        if (doc.containsKey('name')) {
          return doc['name'];
        } else {
          print("Name not found in the response");
          return "";
        }
      } else {
        print("Failed to load doctor: ${response.statusCode}");
        return "";
      }
    } catch (error) {
      // Handle any errors that occurred during the HTTP request
      print("Error in getDoctor: $error");
      return "";
    }
  }

  Future getAppointment() async {
    String id = await getTokenFromStorage();
    var url = "https://marham-backend.onrender.com/prescription/forUser/${id}";
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
      backgroundColor: Color.fromARGB(255, 231, 233, 237),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
            child: IconButton(
              icon: Icon(
                Icons.edit_note_sharp,
                color: Color(0xFF0561DD),
                size: 40,
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => EditUser(),
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
          User.isEmpty || User == null
              ? Container(
                  height: 270,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Container(
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
                          child: User['image'] != null
                              ? CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  backgroundImage:
                                      NetworkImage(User['image']['secure_url']),
                                  radius: 90,
                                )
                              : CircleAvatar(
                                  backgroundImage:
                                      AssetImage('assets/5bbc3519d674c.jpg'),
                                  radius: 100,
                                ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        User['username'] ?? 'userName',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Salsa',
                        ),
                      ),
                      SizedBox(
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

          SizedBox(
            height: 20,
          ),

          //my appointment
          Container(
            height: 655,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50.0),
                topRight: Radius.circular(50.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 40),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //title
                    Row(
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

                    prescriptions == null || prescriptions.isEmpty
                        ? Center(
                            child: Column(
                              children: [
                                Container(
                                  child: Image.asset('assets/medicine.png'),
                                ),
                                SizedBox(
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
                        : Container(
                            height: 500,
                            child: ListView.builder(
                              physics: BouncingScrollPhysics(),
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
                                          to: prescriptions[index]['dateTo'],
                                          writtenBy:
                                              categorySnapshot.data.toString(),
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
