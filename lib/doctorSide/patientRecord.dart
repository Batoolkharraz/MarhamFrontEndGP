import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_4/unit/patientRec.dart';
//import 'package:flutter/scheduler.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'doctorHome.dart';

class patientRecord extends StatefulWidget {
  const patientRecord({super.key});

  @override
  State<patientRecord> createState() => _patientRecordState();
}

class _patientRecordState extends State<patientRecord> {
  final TextEditingController emailController = TextEditingController();
  List prescriptions = [];
  String user = '';

  Future<void> findPatient() async {
    try {
      var url = 'https://marham-backend.onrender.com/giveme/userinformation';
      var response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': emailController.text,
        }),
      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        // Replace 'id' with the actual key in the API response.

        if (responseData != null) {
          user = responseData;
        } else {
          print('User not found');
        }
      } else {
        print('Error: Server returned status code ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future getPrescriptionById(String Id) async {
    var url = "https://marham-backend.onrender.com/prescription/forUser/$Id";

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var responceBody = response.body.toString();
      responceBody = responceBody.trim();
      responceBody = responceBody.substring(17, responceBody.length - 1);
      var pre = jsonDecode(responceBody);

      // Convert date strings to DateTime and sort
      pre.sort((a, b) {
        DateTime dateA = DateFormat('MM/dd/yyyy').parse(a['dateFrom']);
        DateTime dateB = DateFormat('MM/dd/yyyy').parse(b['dateFrom']);
        return dateA.compareTo(dateB);
      });

      // Format the sorted date as dd/mm/yyyy
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8EEFA),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 90,
        backgroundColor:  const Color(0xFF0561DD),

          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Patient Record',
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Salsa',
            ),
          ),
          leading: Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 25,
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const doctorHome(),
                  ),
                );
              },
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 40, right: 25),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 60,
              ),
              const Text('Enter Your Patient Email here:',
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'salsa',
                      fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(
                      fontSize: 20,
                      fontFamily: 'salsa',
                      fontWeight: FontWeight.bold),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(
                            0xFF0561DD)), // Change the border color when focused
                  ),
                  prefixIcon: Icon(Icons.email),
                ),
                style: const TextStyle(
                    fontSize: 20,
                    fontFamily: 'salsa',
                    fontWeight: FontWeight
                        .bold), // Add an icon to the left of the input
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  final enteredEmail = emailController.text;
                  findPatient();
                  getPrescriptionById(user);
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(const Color(0xFF0561DD)),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Find Patient Record',
                    style: TextStyle(
                        fontSize: 25,
                        fontFamily: 'salsa',
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              prescriptions.isEmpty
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 100),
                        child: Column(
                          children: [
                            Container(
                              child: Image.asset('assets/patient_report.png'),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'No Patient Record Yet!',
                              style: TextStyle(
                                fontFamily: 'salsa',
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: prescriptions.length,
                      itemBuilder: (context, index) {
                        return patientRec(
                            diagnosis: prescriptions[index]['diagnosis'],
                            from: prescriptions[index]['dateFrom']);
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
