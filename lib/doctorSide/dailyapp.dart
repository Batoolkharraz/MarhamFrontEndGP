import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_4/doctorSide/cancle.dart';
import 'package:flutter_application_4/doctorSide/complete.dart';
import 'package:flutter_application_4/doctorSide/today.dart';
import 'package:flutter_application_4/doctorSide/upcoming.dart';
import 'package:flutter_application_4/doctorSide/userProfile.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({Key? key}) : super(key: key);

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  final storage = const FlutterSecureStorage();
  List allAppointment = [];
  List doneAppointment = [];
  List cancelAppointment = [];
  List todayAppointment = [];
  List appointment = [];
  String docid = '';
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

  Future<String> getDoctorId() async {
    String Id = await getTokenFromStorage();
    var url = "https://marham-backend.onrender.com/doctor/findId/$Id";
    var response = await http.get(Uri.parse(url));
    var responceBody = response.body.toString();
    responceBody = responceBody.trim();
    var id = jsonDecode(responceBody);

    return id;
  }

  Future<void> getAllAppointment() async {
    try {
      docid = await getDoctorId();
      var url =
          "https://marham-backend.onrender.com/schedule/byDoctor/all/$docid";

      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var responseBody = response.body.toString();
        responseBody = responseBody.trim();
        responseBody = responseBody.substring(12, responseBody.length - 1);
        var allApp = jsonDecode(responseBody);
        print(allApp);
        if (mounted) {
          setState(() {
            allAppointment.clear();
            allAppointment.addAll(allApp);
            print(allAppointment);
          });
        }
      }
    } catch (error) {
      print("Error fetching appointments: $error");
      // Handle the error accordingly
    }
  }

  Future<void> getDoneAppointment() async {
    try {
      docid = await getDoctorId();
      var url =
          "https://marham-backend.onrender.com/schedule/byDoctor/done/$docid";

      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var responseBody = response.body.toString();
        responseBody = responseBody.trim();
        responseBody = responseBody.substring(19, responseBody.length - 1);
        var allApp = jsonDecode(responseBody);
        if (mounted) {
          setState(() {
            doneAppointment.clear();
            doneAppointment.addAll(allApp);
          });
        }
      }
    } catch (error) {
      print("Error fetching done appointments: $error");
      // Handle the error accordingly
    }
  }

  Future<void> getcancelAppointment() async {
    try {
      docid = await getDoctorId();
      var url =
          "https://marham-backend.onrender.com/schedule/byDoctor/cancel/$docid";

      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var responseBody = response.body.toString();
        responseBody = responseBody.trim();
        responseBody = responseBody.substring(19, responseBody.length - 1);
        var allApp = jsonDecode(responseBody);
        if (mounted) {
          setState(() {
            cancelAppointment.clear();
            cancelAppointment.addAll(allApp);
          });
        }
      }
    } catch (error) {
      print("Error fetching cancel appointments: $error");
      // Handle the error accordingly
    }
  }

  Future<void> getTodayAppointment() async {
    try {
      docid = await getDoctorId();
      var url =
          "https://marham-backend.onrender.com/schedule/byDoctor/today/$docid";

      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var responseBody = response.body.toString();
        responseBody = responseBody.trim();
        responseBody = responseBody.substring(12, responseBody.length - 1);
        var allApp = jsonDecode(responseBody);
        if (mounted) {
          setState(() {
            todayAppointment.clear();
            todayAppointment.addAll(allApp);
          });
        }
      }
    } catch (error) {
      print("Error fetching today appointments: $error");
      // Handle the error accordingly
    }
  }

  Future<Map<String, String>> getAppInfo(String appId, String userId) async {
    var url =
        "https://marham-backend.onrender.com/schedule/doctorAppointment/$appId/$userId";
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
        String time = app['scheduleByDay']['timeSlots']
            ['time']; // Use index to access timeSlots
        String userName = responseData['userName'];

        return {'date': date, 'time': time, 'userName': userName};
      } else {
        print("No data found for the given appointment ID");
        return {};
      }
    } else {
      print("Failed to load appointment info");
      return {};
    }
  }

  Future<Map<String, dynamic>> getUser(String id) async {
    var url = "https://marham-backend.onrender.com/giveme/getUser/$id";

    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var responseBody = response.body.toString();
        responseBody = responseBody.trim();
        var user = jsonDecode(responseBody);

        // Return the user as a Map<String, dynamic>
        return user;
      } else {
        print("Failed to load user. Status code: ${response.statusCode}");
        // Return an empty map if there's an error
        return {};
      }
    } catch (error) {
      print("Error loading user: $error");
      // Return an empty map if there's an error
      return {};
    }
  }

  @override
  void initState() {
    super.initState();
    getAllAppointment();
    getDoneAppointment();
    getcancelAppointment();
    getTodayAppointment();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        backgroundColor: const Color(0xFF0561DD),
        elevation: 1,
        title: const Center(
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
        length: 4,
        child: Column(
          children: [
            Material(
              child: Container(
                height: 70,
                color: Colors.white,
                child: TabBar(
                  physics: const ClampingScrollPhysics(),
                  padding: const EdgeInsets.only(
                      top: 10, left: 10, right: 10, bottom: 10),
                  unselectedLabelColor: const Color(0xFF0561DD),
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: const Color(0xFF0561DD)),
                  tabs: [
                    Tab(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                                color: const Color(0xFF0561DD), width: 1)),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            "today",
                            style: TextStyle(
                              fontSize: 20,
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
                            border: Border.all(
                                color: const Color(0xFF0561DD), width: 1)),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            "upcoming",
                            style: TextStyle(
                              fontSize: 20,
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
                            border: Border.all(
                                color: const Color(0xFF0561DD), width: 1)),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            "complete",
                            style: TextStyle(
                              fontSize: 20,
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
                            border: Border.all(
                                color: const Color(0xFF0561DD), width: 1)),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            "cancle",
                            style: TextStyle(
                              fontSize: 20,
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
                  //today appointment
                  todayAppointment.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(top: 200),
                          child: Column(
                            children: [
                              Container(
                                child: Image.asset('assets/appointment.png'),
                              ),
                            ],
                          ),
                        )
                      :
                      //today appointment
                      Container(
                          child: ListView.builder(
                            itemBuilder: (context, int i) {
                              if (todayAppointment.isNotEmpty) {
                                var appointments = todayAppointment[i];
                                if (appointments != null) {
                                  return Column(
                                    children: [
                                      FutureBuilder<Map<String, String>>(
                                        future: getAppInfo(
                                          appointments['bookId'],
                                          appointments['userId'],
                                        ),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                                  ConnectionState.done &&
                                              snapshot.hasData) {
                                            String docName =
                                                snapshot.data!['userName'] ??
                                                    '';
                                            String date =
                                                snapshot.data!['date'] ?? '';
                                            String time =
                                                snapshot.data!['time'] ?? '';
                                            return today(
                                              bookId: appointments['bookId'],
                                              userName: docName,
                                              date: date,
                                              time: time,
                                              userId: appointments['userId'],
                                              onTap: () async {
                                                Map<String, dynamic> userData =
                                                    (await getUser(appointments[
                                                        'userId']));
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        userProfile(
                                                            user: userData),
                                                  ),
                                                );
                                              },
                                            );
                                          } else if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            // While the future is not complete, you can return a loading indicator or placeholder
                                            return const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                            // Replace with your loading indicator
                                          } else if (snapshot.data == null) {
                                            // Once the delay is complete, display the image and text
                                            return Container();
                                          } else {
                                            return Container();
                                          }
                                        },
                                      ),
                                    ],
                                  );
                                } else {
                                  // Handle the case where appointments is not a List
                                  return Container();
                                }
                              } else {
                                // Handle the case where todayAppointment[i] is null or empty
                                return Container();
                              }
                            },
                            itemCount: todayAppointment.length ?? 1,
                            scrollDirection: Axis.vertical,
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.all(8),
                          ),
                        ),

                  //all appointment
                  allAppointment.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(top: 200),
                          child: Column(
                            children: [
                              Container(
                                child: Image.asset('assets/appointment.png'),
                              ),
                            ],
                          ),
                        )
                      :
                      //all appointment
                      Container(
                          child: ListView.builder(
                            itemBuilder: (context, int i) {
                              if (allAppointment.isNotEmpty) {
                                var appointments = allAppointment[i];
                                if (appointments != null) {
                                  return Column(
                                    children: [
                                      FutureBuilder<Map<String, String>>(
                                        future: getAppInfo(
                                          appointments['bookId'],
                                          appointments['userId'],
                                        ),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                                  ConnectionState.done &&
                                              snapshot.hasData) {
                                            String docName =
                                                snapshot.data!['userName'] ??
                                                    '';
                                            String date =
                                                snapshot.data!['date'] ?? '';
                                            String time =
                                                snapshot.data!['time'] ?? '';
                                            return schedual(
                                              bookId: appointments['bookId'],
                                              userId: appointments['userId'],
                                              userName: docName,
                                              date: date,
                                              time: time,
                                              doctorId: docid,
                                            );
                                          } else if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            // While the future is not complete, you can return a loading indicator or placeholder
                                            return const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                            // Replace with your loading indicator
                                          } else if (snapshot.data == null) {
                                            // Once the delay is complete, display the image and text
                                            return Container();
                                          } else {
                                            return Container();
                                          }
                                        },
                                      ),
                                    ],
                                  );
                                } else {
                                  // Handle the case where appointments is not a List
                                  return Container();
                                }
                              } else {
                                // Handle the case where todayAppointment[i] is null or empty
                                return Container();
                              }
                            },
                            itemCount: allAppointment.length ?? 1,
                            scrollDirection: Axis.vertical,
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.all(8),
                          ),
                        ),

                  doneAppointment.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(top: 200),
                          child: Column(
                            children: [
                              Container(
                                child: Image.asset('assets/appointment.png'),
                              ),
                            ],
                          ),
                        )
                      :
                      //done appointment
                      Container(
                          child: ListView.builder(
                            itemBuilder: (context, int i) {
                              if (doneAppointment[i] != null) {
                                List<dynamic> appointmentInfo =
                                    doneAppointment[i];
                                return Column(
                                  children: [
                                    for (var j = 0;
                                        j < appointmentInfo.length;
                                        j++)
                                      FutureBuilder<Map<String, String>>(
                                        future: getAppInfo(
                                            appointmentInfo[j]['bookId'],
                                            appointmentInfo[j]['userId']),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                                  ConnectionState.done &&
                                              snapshot.hasData) {
                                            String userName =
                                                snapshot.data!['userName'] ??
                                                    '';
                                            String date =
                                                snapshot.data!['date'] ?? '';
                                            String time =
                                                snapshot.data!['time'] ?? '';

                                            return complete(
                                              Id: appointmentInfo[j]['bookId'],
                                              userName: userName,
                                              date: date,
                                              time: time,
                                            );
                                          } else if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            // While the future is not complete, you can return a loading indicator or placeholder
                                            return const Center(
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
                                                            EdgeInsets.only(
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
                                        child: Image.asset(
                                            'assets/appointment.png'),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                            itemCount: doneAppointment.length ?? 1,
                            scrollDirection: Axis.vertical,
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.all(8),
                          ),
                        ),

                  cancelAppointment.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(top: 200),
                          child: Column(
                            children: [
                              Container(
                                child: Image.asset('assets/appointment.png'),
                              ),
                            ],
                          ),
                        )
                      :
                      //cancel appointment
                      Container(
                          child: ListView.builder(
                            itemBuilder: (context, int i) {
                              if (cancelAppointment.isNotEmpty) {
                                var appointments = cancelAppointment[i];
                                if (appointments != null) {
                                  return Column(
                                    children: [
                                      FutureBuilder<Map<String, String>>(
                                        future: getAppInfo(
                                          appointments['bookId'],
                                          appointments['userId'],
                                        ),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                                  ConnectionState.done &&
                                              snapshot.hasData) {
                                            String docName =
                                                snapshot.data!['userName'] ??
                                                    '';
                                            String date =
                                                snapshot.data!['date'] ?? '';
                                            String time =
                                                snapshot.data!['time'] ?? '';
                                            return cancle(
                                              Id: appointments['bookId'],userName: docName,
                                              date: date,
                                              time: time,
                                            );
                                          } else if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            // While the future is not complete, you can return a loading indicator or placeholder
                                            return const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                            // Replace with your loading indicator
                                          } else if (snapshot.data == null) {
                                            // Once the delay is complete, display the image and text
                                            return Container();
                                          } else {
                                            return Container();
                                          }
                                        },
                                      ),
                                    ],
                                  );
                                } else {
                                  // Handle the case where appointments is not a List
                                  return Container();
                                }
                              } else {
                                // Handle the case where todayAppointment[i] is null or empty
                                return Container();
                              }
                            },
                            itemCount: cancelAppointment.length ?? 1,
                            scrollDirection: Axis.vertical,
                            physics: const BouncingScrollPhysics(),
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
