
import 'package:flutter/material.dart';
import 'package:flutter_application_4/Auth/Login/login.dart';
import 'package:flutter_application_4/Auth/resetpass/reset.dart';
import 'package:flutter_application_4/doctorSide/working.dart';
import 'package:flutter_application_4/doctorSide/writePrescription.dart';
import 'package:flutter_application_4/splashScreen.dart';
void main() {
  runApp( MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,//عند الدراور
      home:writePrescription(),
    );
}
}
