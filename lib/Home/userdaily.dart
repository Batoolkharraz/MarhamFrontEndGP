import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_application_4/Home/cancleuser.dart';
import 'package:flutter_application_4/Home/completeuser.dart';
import 'package:flutter_application_4/Home/upcompleteuser.dart';
import 'package:flutter_application_4/doctorSide/cancle.dart';
import 'package:flutter_application_4/doctorSide/complete.dart';
import 'package:flutter_application_4/doctorSide/upcoming.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;

class UserDaily extends StatefulWidget {
  const UserDaily({Key? key}) : super(key: key);

  @override
  State<UserDaily> createState() => _UserDailyState();
}

class _UserDailyState extends State<UserDaily> {
  final storage = FlutterSecureStorage();
  List allAppointment = [];
  List doneAppointment = [];
  List cancelAppointment = [];
  List appointment = [];

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

  Future<void> getAllAppointment() async {
    try {
      String Id = await getTokenFromStorage();
      var url = "https://marham-backend.onrender.com/schedule/byUser/all/${Id}";

      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var responseBody = response.body.toString();
        responseBody = responseBody.trim();
        responseBody = responseBody.substring(12, responseBody.length - 1);
        var allApp = jsonDecode(responseBody);

        setState(() {
          allAppointment.clear();
          allAppointment.addAll(allApp);
        });
      }
    } catch (error) {
      print("Error fetching appointments: $error");
      // Handle the error accordingly
    }
  }

  Future<void> getDoneAppointment() async {
    try {
      String Id = await getTokenFromStorage();
      var url =
          "https://marham-backend.onrender.com/schedule/byUser/done/${Id}";

      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var responseBody = response.body.toString();
        responseBody = responseBody.trim();
        responseBody = responseBody.substring(19, responseBody.length - 1);
        var allApp = jsonDecode(responseBody);

        setState(() {
          doneAppointment.clear();
          doneAppointment.addAll(allApp);
        });
      }
    } catch (error) {
      print("Error fetching done appointments: $error");
      // Handle the error accordingly
    }
  }

  Future<void> getcancelAppointment() async {
    try {
      String Id = await getTokenFromStorage();
      var url =
          "https://marham-backend.onrender.com/schedule/byUser/cancel/${Id}";

      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var responseBody = response.body.toString();
        responseBody = responseBody.trim();
        responseBody = responseBody.substring(19, responseBody.length - 1);
        var allApp = jsonDecode(responseBody);

        setState(() {
          cancelAppointment.clear();
          cancelAppointment.addAll(allApp);
        });
      }
    } catch (error) {
      print("Error fetching cancel appointments: $error");
      // Handle the error accordingly
    }
  }

  Future<Map<String, String>> getAppInfo(String appId, String docId) async {
    var url =
        "https://marham-backend.onrender.com/schedule/appointment/$appId/$docId";
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var responseBody = response.body.toString();
      var responseData = jsonDecode(responseBody);

      // Check if the "apps" field is present and not empty
      if (responseData.containsKey("apps") &&
          responseData["apps"] is List &&
          responseData["apps"].isNotEmpty) {
        var app = responseData["apps"][0];

        // Extract date and time from the response
        String date = app['scheduleByDay']['date'];
        String time = app['scheduleByDay']['timeSlots']['time'];

        // Extract doctor name from the response
        String docName = responseData['docName'];
        return {'date': date, 'time': time, 'docName': docName};
      } else {
        print("No data found for the given appointment ID");
        return {};
      }
    } else {
      print("Failed to load appointment info");
      return {};
    }
  }

  @override
  void initState() {
    super.initState();
    getAllAppointment();
    getDoneAppointment();
    getcancelAppointment();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        backgroundColor: Color(0xFF0561DD),
        elevation: 1,
        title: Center(
          child: Text(
            "Appointment",
            style: TextStyle(
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'Salsa',
            ),
          ),
        ),
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            Material(
              child: Container(
                height: 70,
                color: Colors.white,
                child: TabBar(
                  physics: const ClampingScrollPhysics(),
                  padding:
                      EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
                  unselectedLabelColor: Color(0xFF0561DD),
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Color(0xFF0561DD)),
                  tabs: [
                    Tab(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border:
                                Border.all(color: Color(0xFF0561DD), width: 1)),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "upcoming",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Salsa',
                            ),
                          ),
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border:
                                Border.all(color: Color(0xFF0561DD), width: 1)),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "complete",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Salsa',
                            ),
                          ),
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border:
                                Border.all(color: Color(0xFF0561DD), width: 1)),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "cancel",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Salsa',
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  //all appointment
                  Container(
                    child: ListView.builder(
                      itemBuilder: (context, int i) {
                        if (allAppointment[i] != null) {
                          List<dynamic> appointmentInfo = allAppointment[i];
                          return Column(
                            children: [
                              for (var j = 0; j < appointmentInfo.length; j++)
                                FutureBuilder<Map<String, String>>(
                                  future: getAppInfo(
                                      appointmentInfo[j]['bookId'],
                                      appointmentInfo[j]['doctorId']),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                            ConnectionState.done &&
                                        snapshot.hasData) {
                                      String doctorName =
                                          snapshot.data!['docName'] ?? '';
                                      String date =
                                          snapshot.data!['date'] ?? '';
                                      String time =
                                          snapshot.data!['time'] ?? '';
                                      return schedualupcomplete(
                                        userId:appointmentInfo[j]['bookId'],
                                        doctorId:appointmentInfo[j]['doctorId'],
                                        doctorName: doctorName,
                                        date: date,
                                        time: time,
                                      );
                                    } else if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      // While the future is not complete, you can return a loading indicator or placeholder
                                      return Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 25),
                                                  child: SizedBox(
                                                    width: 70,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width:
                                                      40, // Adjust the width as needed
                                                  height:
                                                      40, // Adjust the height as needed
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                      // Replace with your loading indicator
                                    } else if (snapshot.data == null) {
                                      // Once the delay is complete, display the image and text
                                      return Column(
                                        children: [
                                          Container(
                                            child: Image.asset(
                                                'assets/appointment.png'),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            'There is no appointment for you yet.',
                                            style: TextStyle(
                                              fontFamily: 'salsa',
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      );
                                    } else {
                                      return Container();
                                    }
                                  },
                                ),
                            ],
                          );
                        } else {
                          // Handle the case where allAppointment[i] is not a List<dynamic>
                          return Padding(
                            padding: const EdgeInsets.only(top: 150),
                            child: Column(
                              children: [
                                Container(
                                  child: Image.asset('assets/appointment.png'),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'There is no appointment for you yet.',
                                  style: TextStyle(
                                    fontFamily: 'salsa',
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                      itemCount: allAppointment?.length ?? 1,
                      scrollDirection: Axis.vertical,
                      physics: BouncingScrollPhysics(),
                      padding: const EdgeInsets.all(8),
                    ),
                  ),

                  //done appointment
                  Container(
                    child: ListView.builder(
                      itemBuilder: (context, int i) {
                        if (doneAppointment[i] != null) {
                          List<dynamic> appointmentInfo = doneAppointment[i];
                          return Column(
                            children: [
                              for (var j = 0; j < appointmentInfo.length; j++)
                                FutureBuilder<Map<String, String>>(
                                  future: getAppInfo(
                                      appointmentInfo[j]['bookId'],
                                      appointmentInfo[j]['doctorId']),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                            ConnectionState.done &&
                                        snapshot.hasData) {
                                      String doctorName =
                                          snapshot.data!['docName'] ?? '';
                                      String date =
                                          snapshot.data!['date'] ?? '';
                                      String time =
                                          snapshot.data!['time'] ?? '';

                                      return completeuser(
                                        id:appointmentInfo[j]['bookId'],
                                        doctorName: doctorName,
                                        date: date,
                                        time: time,
                                      );
                                    } else if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      // While the future is not complete, you can return a loading indicator or placeholder
                                      return Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 25),
                                                  child: SizedBox(
                                                    width: 70,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width:
                                                      40, // Adjust the width as needed
                                                  height:
                                                      40, // Adjust the height as needed
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                      // Replace with your loading indicator
                                    } else if (snapshot.data == null) {
                                      // Once the delay is complete, display the image and text
                                      return Column(
                                        children: [
                                          Container(
                                            child: Image.asset(
                                                'assets/appointment.png'),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            'There is no Done appointment for you yet.',
                                            style: TextStyle(
                                              fontFamily: 'salsa',
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      );
                                    } else {
                                      return Container();
                                    }
                                  },
                                ),
                            ],
                          );
                        } else {
                          // Handle the case where allAppointment[i] is not a List<dynamic>
                          return Padding(
                            padding: const EdgeInsets.only(top: 150),
                            child: Column(
                              children: [
                                Container(
                                  child: Image.asset('assets/appointment.png'),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'There is no Done appointment for you yet.',
                                  style: TextStyle(
                                    fontFamily: 'salsa',
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                      itemCount: doneAppointment?.length ?? 1,
                      scrollDirection: Axis.vertical,
                      physics: BouncingScrollPhysics(),
                      padding: const EdgeInsets.all(8),
                    ),
                  ),

                  //cancel appointment
                 Container(
                    child: ListView.builder(
                      itemBuilder: (context, int i) {
                        if (cancelAppointment[i] != null) {
                          List<dynamic> appointmentInfo = cancelAppointment[i];
                          return Column(
                            children: [
                              for (var j = 0; j < appointmentInfo.length; j++)
                                FutureBuilder<Map<String, String>>(
                                  future: getAppInfo(
                                      appointmentInfo[j]['bookId'],
                                      appointmentInfo[j]['doctorId']),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                            ConnectionState.done &&
                                        snapshot.hasData) {
                                      String doctorName =
                                          snapshot.data!['docName'] ?? '';
                                      String date =
                                          snapshot.data!['date'] ?? '';
                                      String time =
                                          snapshot.data!['time'] ?? '';

                                      return cancleuser(
                                        Id:appointmentInfo[j]['bookId'],
                                        doctorName: doctorName,
                                        date: date,
                                        time: time,
                                      );
                                    } else if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      // While the future is not complete, you can return a loading indicator or placeholder
                                      return Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 25),
                                                  child: SizedBox(
                                                    width: 70,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width:
                                                      40, // Adjust the width as needed
                                                  height:
                                                      40, // Adjust the height as needed
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                      // Replace with your loading indicator
                                    } else if (snapshot.data == null) {
                                      // Once the delay is complete, display the image and text
                                      return Column(
                                        children: [
                                          Container(
                                            child: Image.asset(
                                                'assets/appointment.png'),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            'There is no cancel appointment for you yet.',
                                            style: TextStyle(
                                              fontFamily: 'salsa',
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      );
                                    } else {
                                      return Container();
                                    }
                                  },
                                ),
                            ],
                          );
                        } else {
                          // Handle the case where allAppointment[i] is not a List<dynamic>
                          return Padding(
                            padding: const EdgeInsets.only(top: 150),
                            child: Column(
                              children: [
                                Container(
                                  child: Image.asset('assets/appointment.png'),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'There is no cancel appointment for you yet.',
                                  style: TextStyle(
                                    fontFamily: 'salsa',
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                      itemCount: cancelAppointment?.length ?? 1,
                      scrollDirection: Axis.vertical,
                      physics: BouncingScrollPhysics(),
                      padding: const EdgeInsets.all(8),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
