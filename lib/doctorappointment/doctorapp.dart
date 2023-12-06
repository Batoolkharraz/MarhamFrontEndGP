import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_4/doctorappointment/appTime.dart';
import 'package:flutter_application_4/unit/appOfDate.dart';
import 'package:flutter_application_4/doctorappointment/workinghour.dart';
import 'package:flutter_application_4/unit/doctor.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class appointment extends StatefulWidget {
  final Map<String, dynamic> doctor;

  appointment({required this.doctor});
  @override
  _appointmentState createState() => _appointmentState();
}

class _appointmentState extends State<appointment> {
  List apps = [];
  List<String> appointmentDates = [];
  Map<String, List<Map<String, dynamic>>> dateToTimeSlots = {};
Future getApps() async {
  var url = "https://marham-backend.onrender.com/schedule/${widget.doctor['_id']}";
  var response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    var responceBody = response.body.toString();
    responceBody = responceBody.trim();
    responceBody = responceBody.substring(13, responceBody.length - 1);
    var app = jsonDecode(responceBody);
    final dateFormatter = DateFormat("yyyy/MM/dd");

    setState(() {
      apps.add(app);

      for (var appointment in apps) {
        var scheduleByDay = appointment['scheduleByDay'] as List<dynamic>;

        for (var schedule in scheduleByDay) {
          var date = dateFormatter.parse(schedule['date'] as String);
          final formattedDate = DateFormat('dd MMM yyyy').format(date);

          // Create a list of time slots for the date
          var timeSlots = <Map<String, dynamic>>[];

          if (schedule['timeSlots'] != null) {
            timeSlots = (schedule['timeSlots'] as List<dynamic>)
                .map((slot) => {
                      'time': slot['time'] as String,
                      'is_booked': slot['is_booked'] as bool,
                      '_id': slot['_id'] as String,
                    })
                .toList();
          }

          // Add the time slots to the map
          dateToTimeSlots[formattedDate] = timeSlots;
        }
      }

      appointmentDates = dateToTimeSlots.keys.toList()..sort();
    });
  }
}

  @override
  void initState() {
    super.initState();
    getApps();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        backgroundColor: Color(0xFF0561DD),
        leading: BackButton(
          onPressed: () => {Navigator.of(context).pop()},
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                width: 600,
                height: 230,
                color: Colors.white,
                child: Row(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: ClipOval(
                        child: Container(
                          width:
                              200.0, // Set the width of the circular container
                          height:
                              200.0, // Set the height of the circular container
                          color: Colors
                              .grey, // Background color for the circular container
                          child: Image.network(
                            widget.doctor['image']
                                ['secure_url'], // Replace with your image URL
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 60,
                      ),
                      child: Container(
                        width: 290,
                        height: 400,
                        child: Column(
                          children: [
                            Text(widget.doctor['name'],
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 35,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Salsa')),
                            Padding(
                              padding: const EdgeInsets.only(top: 20, left: 65),
                              child: Row(children: [
                                Container(
                                  width:
                                      50, // Adjust the width and height as needed to make it circular
                                  height: 50,
                                  decoration: BoxDecoration(
                                    shape: BoxShape
                                        .circle, // This makes the container circular
                                    color: Color(0xFF0561DD),
                                    // You can change the background color
                                  ),
                                  child: Center(
                                      child: InkWell(
                                    child: FaIcon(
                                      FontAwesomeIcons.commentMedical,
                                      size: 28.0,
                                      color: Colors.white,
                                    ),
                                    onTap: () => {print("message")},
                                  )),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  width:
                                      50, // Adjust the width and height as needed to make it circular
                                  height: 50,
                                  decoration: BoxDecoration(
                                    shape: BoxShape
                                        .circle, // This makes the container circular
                                    color: Color(
                                        0xFF0561DD), // You can change the background color
                                  ),
                                  child: Center(
                                      child: InkWell(
                                    child: FaIcon(FontAwesomeIcons.video,
                                        color: Colors.white, size: 25.0),
                                    onTap: () => {print("video call")},
                                  )),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  width:
                                      50, // Adjust the width and height as needed to make it circular
                                  height: 50,
                                  decoration: BoxDecoration(
                                    shape: BoxShape
                                        .circle, // This makes the container circular
                                    color: Color(
                                        0xFF0561DD), // You can change the background color
                                  ),
                                  child: Center(
                                      child: InkWell(
                                    child: FaIcon(FontAwesomeIcons.phone,
                                        color: Colors.white, size: 25.0),
                                    onTap: () => {print("phone call")},
                                  )),
                                ),
                              ]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, bottom: 15, top: 15),
                      child: Container(
                        width: 600,
                        child: Text("Availability",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 30,
                                fontWeight: FontWeight.bold
                                // fontFamily: 'Salsa',
                                )),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 5),
                      width: 510,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Color(0xFF0561DD),
                        border: Border.all(
                          color: Colors.grey, // Set the border color here
                          width: 2.0, // Set the border width
                        ),
                      ),
                      child: Text("Address:    " + widget.doctor['address'],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold
                              // fontFamily: 'Salsa',

                              )),
                    )
                  ],
                ),
              ),
              appointmentDates == null || appointmentDates.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(top: 150),
                      child: Column(
                        children: [
                          Container(
                            child: Image.asset('assets/time.png'),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'No Appointment date added until Now!',
                            style: TextStyle(
                              fontFamily: 'salsa',
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      height: 900,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ListView.builder(
                          // Number of items in each row

                          itemBuilder: (context, int index) {
                            return appOfDate(
                              date: appointmentDates[index],
                              onTap: () {
                                // Print the list of time slots for the selected date
                                final selectedDate = appointmentDates[index];
                                final timeSlots = dateToTimeSlots[selectedDate];
                                if (timeSlots != null && timeSlots.isNotEmpty) {
                                  // Navigate to the appTime page
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => appTime(
                                        docId: apps[0]['writtenBy'],
                                        date: selectedDate,
                                        timeSlots: timeSlots,
                                      ),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Center(
                                        child: Text(
                                          "No Appointment available for $selectedDate",
                                          style: TextStyle(
                                            fontFamily: 'salsa',
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      duration: Duration(
                                          seconds:
                                              2), // The duration it will be displayed
                                    ),
                                  );
                                }
                              },
                            );
                          },
                          itemCount: appointmentDates.length,
                          physics: BouncingScrollPhysics(),
                          padding: const EdgeInsets.all(8),
                        ),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
