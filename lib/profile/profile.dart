import 'package:flutter/material.dart';
import 'package:flutter_application_4/medicine/medicineSchedule.dart';
import 'package:flutter_application_4/profile/edit.dart';
import 'package:flutter_application_4/unit/appointmentList.dart';
import 'package:flutter_application_4/unit/medicineList.dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE8EEFA),
      appBar: AppBar(
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
                    builder: (context) => edit(),
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
            Container(
              height: 200,
              child: Row(
                children: [
                  //img
                  Container(
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/doctor2.jpg'),
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
                            'batool kharraz',
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
                                'batoolkhelf@gmail.com',
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
                                '0592689881',
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

                  SizedBox(
                    height: 10,
                  ),

                  //medicine
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: medicineList(
                              diagnosis: 'diagnosis',
                              from: 'from',
                              to: 'to',
                              writtenBy: 'writtenBy',
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => medicineSchedule(),
                                  ),
                                );
                              }));
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
