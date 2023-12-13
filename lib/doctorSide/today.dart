import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class today extends StatelessWidget {
  @override
  final String Id;
  final String userName;
  final String date;
  final String time;

  today({
    required this.Id,
    required this.userName,
    required this.date,
    required this.time,
  });
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
                  Text(userName,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Salsa')),
                  SizedBox(
                    width: 230,
                  ),
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
                        Text(date,
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
                        Text(time,
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
