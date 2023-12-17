import 'package:flutter/material.dart';

class mainDoctorpage extends StatefulWidget {
  const mainDoctorpage({super.key});

  @override
  State<mainDoctorpage> createState() => _mainDoctorpageState();
}

class _mainDoctorpageState extends State<mainDoctorpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
           padding: EdgeInsets.only(top: 50, left: 30, right: 30),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50.0),
                      topRight: Radius.circular(50.0),
                    )),
        ),
      ),
    );
  }
}