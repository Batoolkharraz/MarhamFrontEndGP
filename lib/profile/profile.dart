import 'dart:convert';
import 'package:http/http.dart' as http;
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
  List prescriptions = [];

  Future getPrescription(String userId) async {
    // var url =
    //   "https://marham-backend.onrender.com/prescription/forUser/65109015e44c87b9397e2e19";
    var url =
        "https://marham-backend.onrender.com/prescription/forUser/${userId}";

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var responceBody = response.body.toString();
      responceBody = responceBody.trim();
      responceBody = responceBody.substring(17, responceBody.length - 1);
      var pre = jsonDecode(responceBody);

      setState(() {
        prescriptions.addAll(pre);
      });
    }
  }

  Future<String> getDoctor(String docId) async {
    // var url = "https://marham-backend.onrender.com/doctor/${docId}";
    var url =
        "https://marham-backend.onrender.com/doctor/651c58f32cd651e7a27ac12f";
    var response = await http.get(Uri.parse(url));
    var responceBody = response.body.toString();
    responceBody = responceBody.trim();
    responceBody = responceBody.substring(10, responceBody.length - 1);
    var cat = jsonDecode(responceBody);

    return cat['name'];
  }

  @override
  void initState() {
    super.initState();
    getPrescription('65109015e44c87b9397e2e19');
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
                                        builder: (context) =>medicineSchedule(medicines: prescriptions[index]['medicines']),
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
