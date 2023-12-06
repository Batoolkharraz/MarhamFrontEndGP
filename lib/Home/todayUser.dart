import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

class todayUser extends StatefulWidget {
  final String id;
  final String doctorName;
  final String date;
  final String time;

  todayUser({
    required this.id,
    required this.doctorName,
    required this.date,
    required this.time,
  });

  @override
  _todayUserState createState() => _todayUserState();
}

class _todayUserState extends State<todayUser> {
  @override
  Widget build(BuildContext context) {
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
              Row(
                children: [
                  SizedBox(
                    width: 25,
                  ),
                  Text( widget.doctorName,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Salsa')),
                  
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 22,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Color.fromARGB(255, 228, 235, 248),
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
                        SizedBox(
                          width: 15,
                        ),
                        FaIcon(
                          FontAwesomeIcons.calendar,
                          size: 26.0,
                          color: Color(0xFF0561DD),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(widget.date,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Salsa')),
                        SizedBox(
                          width: 25,
                        ),
                        FaIcon(
                          FontAwesomeIcons.clock,
                          size: 26.0,
                          color: Color(0xFF0561DD),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(widget.time,
                            style: TextStyle(
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
