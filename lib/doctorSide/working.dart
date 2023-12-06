import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class Workingdoctor extends StatefulWidget {
  const Workingdoctor({Key? key}) : super(key: key);

  @override
  _WorkingdoctorState createState() => _WorkingdoctorState();
}

class _WorkingdoctorState extends State<Workingdoctor> {
  DateTime dateTime = DateTime(2023, 10, 30, 8, 00);
  DateTime dateTime2 = DateTime(2023, 10, 30, 8, 00);
  final durationController = TextEditingController();
  final storage = const FlutterSecureStorage();
  String userId = '';

  Future<TimeOfDay?> pickTime() => showTimePicker(
      context: context, initialTime: const TimeOfDay(hour: 12, minute: 00));

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

  void createSchedule() async {
    var date = DateTime(dateTime.year, dateTime.month, dateTime.day);
    var startTime = TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
    var endTime = TimeOfDay(hour: dateTime2.hour, minute: dateTime2.minute);
    var duration = int.tryParse(durationController.text) ?? 15;

    //String id = await getTokenFromStorage();

    String id = '652080079045ad81c357024f';

    // Convert TimeOfDay to DateTime
    DateTime start = DateTime(
        date.year, date.month, date.day, startTime.hour, startTime.minute);
    DateTime end =
        DateTime(date.year, date.month, date.day, endTime.hour, endTime.minute);

    if (end.isBefore(start)) {
      // Show an alert if endTime is before startTime
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(40), 
            title: const Text(
              'Invalid Time Selection',
              style: TextStyle(
                  fontSize: 25,
                  fontFamily: 'salsa',
                  fontWeight: FontWeight.bold),
            ),
            content: const Text(
              'End time cannot be before start time.',
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'salsa',
                  fontWeight: FontWeight.bold),
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF0561DD), // Change the background color as needed
                    borderRadius: BorderRadius.circular(
                        20), // Adjust the border radius for circular shape
                  ),
                  child: TextButton(
                    child: const Text(
                      'OK',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'salsa',
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Text color
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              )
            ],
          );
        },
      );
    } else {
      final date = '${dateTime.year}/${dateTime.month}/${dateTime.day}';
      final startTime = '${dateTime.hour}:${dateTime.minute}';
      final endTime = '${dateTime2.hour}:${dateTime2.minute}';
      final schedule = {
        "date": date,
        "startTime": startTime,
        "endTime": endTime,
        "duration": duration,
      };

      final response = await http.post(
        Uri.parse(
            'https://marham-backend.onrender.com/schedule/$id'), // Replace with your server URL
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(schedule),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Color(0xFF0561DD),
            content: Center(
              child: Text(
                "Your Schedule has been saved",
                style: TextStyle(
                  fontFamily: 'salsa',
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            duration: Duration(seconds: 1), // The duration it will be displayed
          ),
        );
      } else {
        print('Failed to send schedule');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final starthour = dateTime.hour.toString().padLeft(2, '0');
    final startminutes = dateTime.minute.toString().padLeft(2, '0');

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        backgroundColor:  const Color(0xFF0561DD),
        elevation: 1,
        
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          height: 1200,
          color: const Color(0xFF0561DD),
          child: Column(
            children: [
              //img
              SizedBox(
                width: 500,
                height: 400,
                child: Image.asset("assets/Doctors-bro.png"),
              ),

              //schedule
              Container(
                width: 600,
                height: 800,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 50),
                      width: 500,
                      child: const Column(
                        children: [
                          Row(
                            children: [
                              FaIcon(FontAwesomeIcons.calendarDays,
                                  color: Colors.blue, size: 30.0),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Make your schedule",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 111, 110, 110),
                                  fontSize: 30,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Salsa',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Container(
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Text(
                                  '${dateTime.year}/${dateTime.month}/${dateTime.day}',
                                  style: const TextStyle(
                                    color: Colors.blue,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Salsa',
                                  ),
                                ),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF0561DD),
                                      fixedSize: const Size(200, 60),
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
                                    onPressed: () async {
                                      DateTime? newDate = await showDatePicker(
                                        context: context,
                                        initialDate: dateTime,
                                        firstDate: DateTime(2023),
                                        lastDate: DateTime(2024),
                                        builder: (BuildContext context,
                                            Widget? child) {
                                          return Theme(
                                            data: ThemeData.light().copyWith(
                                              textTheme: const TextTheme(
                                                bodySmall: TextStyle(
                                                    fontSize:
                                                        24), // Adjust the font size
                                              ),
                                            ),
                                            child: child!,
                                          );
                                        },
                                      );
                                      if (newDate == null) return;
                                      setState(() => dateTime = newDate);
                                    },
                                    child: const Text(
                                      "Select Date",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Salsa',
                                      ),
                                    )),
                                Row(
                                  children: [
                                    Container(
                                      padding:
                                          const EdgeInsets.only(left: 20, bottom: 70),
                                      child: const Text(
                                        "Duration ",
                                        style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 111, 110, 110),
                                          fontSize: 30,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Salsa',
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding:
                                          const EdgeInsets.only(left: 10, top: 30),
                                      width: 80,
                                      height: 200,
                                      child: TextField(
                                        controller: durationController,
                                        keyboardType: TextInputType.number,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(fontSize: 30),
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            // Adjust the border radius as needed
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 40,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 70),
                              child: Column(
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF0561DD),
                                      fixedSize: const Size(200, 60),
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
                                    onPressed: () async {
                                      final time = await pickTime();
                                      if (time == null) return;
                                      final newDate = DateTime(
                                        dateTime.year,
                                        dateTime.month,
                                        dateTime.day,
                                        time.hour,
                                        time.minute,
                                      );
                                      setState(() => dateTime = newDate);
                                    },
                                    child: const Text(
                                      "Start Time",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Salsa',
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF0561DD),
                                      fixedSize: const Size(200, 60),
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
                                    onPressed: () async {
                                      final time2 = await pickTime();
                                      if (time2 == null) return;
                                      final newDate = DateTime(
                                        dateTime2.year,
                                        dateTime2.month,
                                        dateTime2.day,
                                        time2.hour,
                                        time2.minute,
                                      );
                                      setState(() => dateTime2 = newDate);
                                    },
                                    child: const Text(
                                      " End  Time ",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Salsa',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0561DD),
                        fixedSize: const Size(500, 60),
                      ).copyWith(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                            side: const BorderSide(
                                color: Color(0xFF0561DD), width: 2.0),
                          ),
                        ),
                      ),
                      onPressed: () {
                        createSchedule();
                      },
                      child: const Text(
                        "Save",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Salsa',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
