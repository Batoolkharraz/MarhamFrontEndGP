import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_4/doctorSide/maindoctor.dart';
import 'package:flutter_application_4/doctorSide/writePrescription.dart';
import 'package:flutter_application_4/medicine/medicineSchedule.dart';
import 'package:flutter_application_4/unit/patientRec.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'doctorHome.dart';

class userProfile extends StatefulWidget {
  final Map<String, dynamic> user;

  const userProfile({super.key, required this.user});

  @override
  State<userProfile> createState() => _userProfileState();
}

class _userProfileState extends State<userProfile> {
  List prescriptions = [];

  Future<void> getPrescriptionById() async {
    var url =
        "https://marham-backend.onrender.com/prescription/forUser/${widget.user['_id']}";

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var responseBody = response.body.toString();
      responseBody = responseBody.trim();
      responseBody = responseBody.substring(17, responseBody.length - 1);
      var pre = jsonDecode(responseBody);

      pre.sort((a, b) {
        DateTime dateA = DateFormat('MM/dd/yyyy').parse(a['dateFrom']);
        DateTime dateB = DateFormat('MM/dd/yyyy').parse(b['dateFrom']);
        return dateA.compareTo(dateB);
      });

      DateFormat outputFormat = DateFormat('dd/MM/yyyy');
      for (var prescription in pre) {
        prescription['dateFrom'] = outputFormat
            .format(DateFormat('MM/dd/yyyy').parse(prescription['dateFrom']));
      }

      setState(() {
        prescriptions.clear();
        prescriptions.addAll(pre);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getPrescriptionById();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8EEFA),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xFF0561DD),
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Patient Profile',
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Salsa',
            ),
          ),
          leading: Padding(
            padding: const EdgeInsets.only(left: 24.0),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 40,
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const mainDoctorpage(),
                  ),
                );
              },
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 40, right: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.user['username'],
                      style: const TextStyle(
                        fontFamily: 'salsa',
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 70,
                  height: 70,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(widget.user['image']['secure_url']),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            Container(
              child: const Text(
                'Patient Record:',
                style: TextStyle(
                  fontFamily: 'salsa',
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 15),
            prescriptions.isEmpty
                ? Expanded(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 100),
                        child: Column(
                          children: [
                            Container(
                              child: Image.asset(
                                'assets/patient_report.png',
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: prescriptions.length,
                      itemBuilder: (context, index) {
                        return patientRec(
                          diagnosis: prescriptions[index]['diagnosis'],
                          from: prescriptions[index]['dateFrom'],
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => medicineSchedule(
                                  medicines: prescriptions[index]['medicines'],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
            const SizedBox(
                height:
                    15), // Add some space between the list and the GestureDetector
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => writePrescription(
                      userId: widget.user['_id'],
                      userName: widget.user['username'],
                      userEmail: widget.user['email'],
                    ),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    width: 2,
                    color: const Color(0xFF0561DD),
                  ),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0, 0),
                      blurRadius: 15,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: SizedBox(
                        width: 150,
                        child: Image.asset(
                          'assets/prescription.png',
                        ),
                      ),
                    ),
                    const Text(
                      'Write Prescription',
                      style: TextStyle(
                        color: Color(0xFF0561DD),
                        fontSize: 27,
                        fontFamily: 'salsa',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
                height:
                    15),
          ],
        ),
      ),
    );
  }
}
