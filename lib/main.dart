import 'package:flutter/material.dart';
import 'package:flutter_application_4/Auth/Login/login.dart';
import 'package:flutter_application_4/doctorSide/dailyapp.dart';
import 'package:flutter_application_4/doctorSide/doctorHome.dart';

void main() {
  runApp( MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,//عند الدراور
      home:Login(),
    );
}
}
