import 'package:flutter/material.dart';
import 'package:flutter_application_4/doctorSide/doctorHome.dart';

class writePrescription extends StatefulWidget {
  const writePrescription({super.key});

  @override
  State<writePrescription> createState() => _writePrescriptionState();
}

class _writePrescriptionState extends State<writePrescription> {
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
            'Prescription Details',
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
      

    );
  }
}