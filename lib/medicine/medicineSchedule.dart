import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_4/profile/profile.dart';
import 'package:flutter_application_4/unit/category.dart';
import 'package:http/http.dart' as http;

class medicineSchedule extends StatefulWidget {
  const medicineSchedule({super.key});

  @override
  State<medicineSchedule> createState() => _medicineScheduleState();
}

class _medicineScheduleState extends State<medicineSchedule> {
  List categories = [];

  Future getCategories() async {
    var url = "https://marham-backend.onrender.com/category/";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var responceBody = response.body.toString();
      responceBody = responceBody.trim();
      responceBody = responceBody.substring(14, responceBody.length - 1);
      var cat = jsonDecode(responceBody);

      setState(() {
        categories.addAll(cat);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE8EEFA),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xFF0561DD),
          elevation: 0,
          centerTitle: true,
          title: Text(
            'My Medicine Schedule',
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
                    builder: (context) => profile(),
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
