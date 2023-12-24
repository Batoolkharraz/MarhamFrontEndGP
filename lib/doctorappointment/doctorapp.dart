import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_4/Auth/chat/mk.dart';
import 'package:flutter_application_4/doctorappointment/appTime.dart';
import 'package:flutter_application_4/unit/appOfDate.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class appointment extends StatefulWidget {
  final Map<String, dynamic> doctor;

  const appointment({super.key, required this.doctor});
  @override
  _appointmentState createState() => _appointmentState();
}

class _appointmentState extends State<appointment> {
  List apps = [];
  List<String> appointmentDates = [];
  Map<String, List<Map<String, dynamic>>> dateToTimeSlots = {};
  Future getApps() async {
    var url =
        "https://marham-backend.onrender.com/schedule/${widget.doctor['_id']}";
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var responceBody = response.body.toString();
      responceBody = responceBody.trim();
      responceBody = responceBody.substring(13, responceBody.length - 1);
      var app = jsonDecode(responceBody);
      final dateFormatter = DateFormat("yyyy/MM/dd");
      if (mounted) {
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
  }

  @override
  void initState() {
    super.initState();
    getApps();
  }

  @override
  Widget build(BuildContext context) {
    String email = widget.doctor[
        'email']; // Assuming widget.doctor['email'] is the email address

    List<String> emailParts = email.split('@');

    String part1 = emailParts[0];
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.doctor['name'],
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w500,
            )),
        toolbarHeight: 90,
        backgroundColor: const Color(0xFF0561DD),
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
                // color:Colors.black,
                // width: 600,
                height: 240,
                // color: Colors.white,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20, left: 14),
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
                    Container(
                      // color: Colors.blue,
                      width: 300,
                      padding: EdgeInsets.only(top: 60, left: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.doctor['description'],
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 35,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Salsa')),
                          SizedBox(height: 10),
                          Container(
                            width: 300,
                            // color: Colors.blue,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Colors.blue, width: 2),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.attach_money,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("70sh ",
                                    style: const TextStyle(
                                        color: Color.fromRGBO(58, 58, 58, 1),
                                        fontSize: 25,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Salsa')),
                                SizedBox(
                                  width: 15,
                                ),
                                FaIcon(
                                  FontAwesomeIcons.locationDot,
                                  size: 26.0,
                                  color: Colors.blue,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(widget.doctor['address'],
                                    style: const TextStyle(
                                        color: Color.fromRGBO(58, 58, 58, 1),
                                        fontSize: 25,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Salsa'))
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            width: 300,
                            child: Row(
                              children: [
                                SizedBox(width: 5),
                                FaIcon(
                                  FontAwesomeIcons.envelope,
                                  size: 26.0,
                                  color: Colors.blue,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(part1,
                                    style: const TextStyle(
                                        color: Color.fromRGBO(58, 58, 58, 1),
                                        fontSize: 25,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Salsa'))
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 25),
                            child: Text("@gmail.com",
                                style: const TextStyle(
                                    color: Color.fromRGBO(58, 58, 58, 1),
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Salsa')),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    InkWell(
                      child: Container(
                        padding: const EdgeInsets.only(top: 5),
                        width: 510,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: const Color(0xFF0561DD),
                          border: Border.all(
                            color: Colors.grey, // Set the border color here
                            width: 2.0, // Set the border width
                          ),
                        ),
                        child: Text("Talk to " + widget.doctor['name'],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold
                                // fontFamily: 'Salsa',

                                )),
                      ),
                      onTap: () => {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ChatScreen(
                                ruseremail: widget.doctor['name'],
                                image: widget.doctor['image']['secure_url'])))
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 20, bottom: 5, top: 15),
                      child: SizedBox(
                        width: 600,
                        child: Text("BooK Apponitment",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 30,
                                fontWeight: FontWeight.bold
                                // fontFamily: 'Salsa',
                                )),
                      ),
                    ),
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
                  : SizedBox(
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
                                          style: const TextStyle(
                                            fontFamily: 'salsa',
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      duration: const Duration(
                                          seconds:
                                              2), // The duration it will be displayed
                                    ),
                                  );
                                }
                              },
                            );
                          },
                          itemCount: appointmentDates.length,
                          physics: const BouncingScrollPhysics(),
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
