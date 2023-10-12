import 'package:flutter/material.dart';

class appointment extends StatefulWidget {
  const appointment({super.key});

  @override
  State<appointment> createState() => _appointmentState();
}

class _appointmentState extends State<appointment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('appointment')),
    );
  }
}