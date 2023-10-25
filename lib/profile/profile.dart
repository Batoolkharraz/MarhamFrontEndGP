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
    var url =
        "https://marham-backend.onrender.com/doctor/651c58f32cd651e7a27ac12f";
    var response = await http.get(Uri.parse(url));
    var responceBody = response.body.toString();
    responceBody = responceBody.trim();
    responceBody = responceBody.substring(10, responceBody.length - 1);
    var doc = jsonDecode(responceBody);

    return doc['name'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE8EEFA),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 30, 0),
            child: IconButton(
              icon: Icon(
                Icons.edit_note_sharp,
                color: Colors.grey[600],
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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 20, 30, 30),
        child: Column(
          children: [
            //head
            User.isEmpty||User==null?
            Container(
              height: 200,
              child: Center(
                child:
                 CircularProgressIndicator(),
              ),
            )
            :
            Container(
              height: 200,
              child: Row(
                children: [
                  //img
                  Container(
                    child: User['image'] != null
                        ? CircleAvatar(
                          backgroundColor: Colors.transparent,
                            backgroundImage:
                                NetworkImage(User['image']['secure_url']),
                            radius: 100,
                          )
                        : CircleAvatar(
                            // Provide a default image or a placeholder
                            backgroundImage:
                                AssetImage('assets/5bbc3519d674c.jpg'),
                            radius: 100,
                          ),
                  ),

                  SizedBox(
                    width: 20,
                  ),
                  //user info
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 20, 0, 50),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //name
                          Text(
                            User['username'] ?? 'userName',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Salsa',
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),

                          //email
                          Row(
                            children: [
                              Icon(
                                Icons.email,
                                color: Colors.grey[600],
                                size: 30,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                User['email'] ?? 'email not found',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Salsa',
                                ),
                              ),
                            ],
                          ),

                          //phone
                          Row(
                            children: [
                              Icon(
                                Icons.phone,
                                color: Colors.grey[600],
                                size: 30,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                User['phone'] ?? 'Phone not found',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Salsa',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 30,
            ),

            //my appointment
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //title
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'My appointment',
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'salsa',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'see all',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 20,
                          fontFamily: 'salsa',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 10,
                  ),

                  //appointment
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      //  final appointment = appointmentList[index];
                      return Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: appointmentList(
                            doctor: 'doctor',
                            category: 'category',
                            date: 'date',
                            time: 'time',
                            state: 'state'),
                      );
                    },
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 30,
            ),

            //my medicine
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //title
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'My medicine',
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'salsa',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'see all',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 20,
                          fontFamily: 'salsa',
                          fontWeight: FontWeight.bold,
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
                                  fontFamily: 'salsa',
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        )
                      : SizedBox(
                          height: 10,
                        ),

                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: prescriptions.length,
                    itemBuilder: (context, index) {
                      return FutureBuilder(
                        future:
                            getDoctor('${prescriptions[index]['writtenBy']}'),
                        builder: (context, categorySnapshot) {
                          if (categorySnapshot.hasError) {
                            return Text('Error: ${categorySnapshot.error}');
                          } else {
                            return Container(
                              child: medicineList(
                                  diagnosis: prescriptions[index]['diagnosis'],
                                  from: prescriptions[index]['dateFrom'],
                                  to: prescriptions[index]['dateTo'],
                                  writtenBy: categorySnapshot.data.toString(),
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => medicineSchedule(
                                            medicines: prescriptions[index]
                                                ['medicines']),
                                      ),
                                    );
                                  }),
                            );
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
