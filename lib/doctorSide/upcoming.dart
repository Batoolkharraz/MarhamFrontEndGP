import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

class schedual extends StatelessWidget {
  @override
  final String bookId;
  final String userId;
  final String userName;
  final String date;
  final String time;
  final String doctorId;

  const schedual({super.key, 
    required this.bookId,
    required this.userId,
    required this.userName,
    required this.date,
    required this.time,
    required this.doctorId,
  });

  @override
  Widget build(BuildContext context) {

    Future<void> cancelAppointment(String bookId, String userId) async {
      try {
        var url = Uri.parse(
            'https://marham-backend.onrender.com/schedule/cancelByDoc/$userId/$bookId/$doctorId');

        var response = await http.patch(
          url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            // You can include additional parameters here if needed
            // For example: 'reason': 'Some reason for cancellation'
          }),
        );
        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Color(0xFF0561DD),
              content: Center(
                child: Text(
                  "your appointment has been canceled",
                  style: TextStyle(
                    fontFamily: 'salsa',
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              duration:
                  Duration(seconds: 1), // The duration it will be displayed
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.red,
              content: Center(
                child: Text(
                  "Appointment does not canceled.Try again!",
                  style: TextStyle(
                    fontFamily: 'salsa',
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              duration:
                  Duration(seconds: 1), // The duration it will be displayed
            ),
          );
        }
      } catch (error) {
        print('Error cancelling appointment: $error');
      }
    }

    Future<void> doneAppointment(String bookId, String userId) async {
      try {
        var url = Uri.parse(
            'https://marham-backend.onrender.com/schedule/done/$userId/$bookId/$doctorId');

        var response = await http.patch(
          url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            // You can include additional parameters here if needed
            // For example: 'reason': 'Some reason for cancellation'
          }),
        );
        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Color(0xFF0561DD),
              content: Center(
                child: Text(
                  "the appointment saved as done",
                  style: TextStyle(
                    fontFamily: 'salsa',
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              duration:
                  Duration(seconds: 1), // The duration it will be displayed
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.red,
              content: Center(
                child: Text(
                  "Appointment does not saved.Try again!",
                  style: TextStyle(
                    fontFamily: 'salsa',
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              duration:
                  Duration(seconds: 1), // The duration it will be displayed
            ),
          );
        }
      } catch (error) {
        print('Error cancelling appointment: $error');
      }
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.white,
          border: Border.all(
            color: Colors.grey, // Set the border color here
            width: 2.0, // Set the border width
          ),
        ),
        width: 600,
        height: 150,
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(userName,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Salsa')),
                    Container(
                      child: Row(
                        children: [
                          InkWell(
                            child: const FaIcon(
                              FontAwesomeIcons.circleCheck,
                              size: 26.0,
                              color: Colors.green,
                            ),
                            onTap: () { 
                              doneAppointment(bookId, userId);
                            },
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          InkWell(
                            child: const FaIcon(
                              FontAwesomeIcons.circleXmark,
                              size: 26.0,
                              color: Colors.blue,
                            ),
                            onTap: () {
                              cancelAppointment(bookId, userId);
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 22,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: const Color.fromARGB(255, 228, 235, 248),
                      border: Border.all(
                        color: const Color.fromARGB(
                            255, 194, 186, 186), // Set the border color here
                        width: 2.0, // Set the border width
                      ),
                    ),
                    width: 450,
                    height: 70,
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 15,
                        ),
                        const FaIcon(
                          FontAwesomeIcons.calendar,
                          size: 26.0,
                          color: Color(0xFF0561DD),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(date,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Salsa')),
                        const SizedBox(
                          width: 100,
                        ),
                        const FaIcon(
                          FontAwesomeIcons.clock,
                          size: 26.0,
                          color: Color(0xFF0561DD),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(time,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Salsa')),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
