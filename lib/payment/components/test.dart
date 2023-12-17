import 'package:flutter/material.dart';
import 'package:flutter_application_4/Auth/resetpass/alert.dart';
import 'package:flutter_application_4/payment/components/card_alert_dialog.dart';
import 'package:flutter_application_4/payment/payment.dart';

class name extends StatefulWidget {
  const name({super.key});

  @override
  State<name> createState() => _nameState();
}

class _nameState extends State<name> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ElevatedButton(onPressed: (){
showpaymentalertt(context);
      }, child: Text("bb")),
    );
  }
}