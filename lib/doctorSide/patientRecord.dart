import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:http/http.dart' as http;

import '../unit/diagnosisList.dart';
import 'doctorHome.dart';

class patientRecord extends StatefulWidget {
  const patientRecord({super.key});

  @override
  State<patientRecord> createState() => _patientRecordState();
}

class _patientRecordState extends State<patientRecord> {
  final TextEditingController emailController = TextEditingController();
  List prescriptions = [];

  Future<String> findPatient() async {
    //to find id of the patient
    print(emailController.text);
    print('65109015e44c87b9397e2e19');
    return '65109015e44c87b9397e2e19';
  }

  Future getPrescriptionById(String Id) async {
    var url = "https://marham-backend.onrender.com/prescription/forUser/${Id}";

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE8EEFA),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xFF0561DD),
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Patient Record',
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Salsa',
            ),
          ),
          leading: Padding(
            padding: const EdgeInsets.only(left: 24.0),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 40,
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => doctorHome(),
                  ),
                );
              },
            ),
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            ElevatedButton(
              onPressed:findPatient,
              child: Text('Send Prescription'),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: prescriptions.length,
              itemBuilder: (context, index) {
                return FutureBuilder(
                  future: getPrescriptionById(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      print(snapshot.data);
                      return Container(
                        child: Text('data'),
                        //  child: diagnosisList(),
                      );
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
