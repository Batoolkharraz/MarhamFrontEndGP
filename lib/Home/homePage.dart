// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_4/unit/category.dart';
import 'package:flutter_application_4/unit/doctor.dart';
import 'package:flutter_application_4/Home/home.dart';
import 'package:flutter_application_4/appointment/appointment.dart';
import 'package:flutter_application_4/doctors/doctors.dart';
import 'package:flutter_application_4/profile/profile.dart';
import 'package:lottie/lottie.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:http/http.dart' as http;

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  List<Widget> page = [home(), profile(), appointment()];
  int selectedIndex = 0;
  List categories = [];
  List doctors = [];

  void navigateBottomBar(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  Future getCategories() async {
    var url = "https://marham-backend.onrender.com/category/";
    var response = await http.get(Uri.parse(url));
    var responceBody = response.body.toString();
    responceBody = responceBody.trim();
    responceBody = responceBody.substring(14, responceBody.length - 1);
    var cat = jsonDecode(responceBody);

    setState(() {
      categories.addAll(cat);
    });
  }

  Future<String> getCategory(String catId) async {
    var url = "https://marham-backend.onrender.com/category/${catId}";
    var response = await http.get(Uri.parse(url));
    var responceBody = response.body.toString();
    responceBody = responceBody.trim();
    responceBody = responceBody.substring(12, responceBody.length - 1);
    var cat = jsonDecode(responceBody);

    return cat['name'];
  }

  Future getDoctor() async {
    var url = "https://marham-backend.onrender.com/doctor/";
    var response = await http.get(Uri.parse(url));
    var responceBody = response.body.toString();
    responceBody = responceBody.trim();
    responceBody = responceBody.substring(11, responceBody.length - 1);
    var doc = jsonDecode(responceBody);

    setState(() {
      //print(getCategory(doc[0]['categoryId']));
      doctors.addAll(doc);
    });
  }

  void navigateToNextPageWithCategory(String categoryId) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DoctorsPage(categoryId: categoryId),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    getCategories();
    //getCategory();
    getDoctor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE8EEFA),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 7),
          child: GNav(
            onTabChange: navigateBottomBar,
              gap: 8,
              backgroundColor: Colors.white,
              color: Colors.black,
              activeColor: Colors.white,
              tabBackgroundColor: Color(0xFF0561DD),
              tabs: const [
                GButton(
                  icon: Icons.home,
                  textStyle: TextStyle(
                      fontSize: 20, fontFamily: 'Salsa', color: Colors.white),
                  iconSize: 35,
                  text: "Home",
                ),
                GButton(
                    icon: Icons.person,
                    textStyle: TextStyle(
                        fontSize: 20, fontFamily: 'Salsa', color: Colors.white),
                    iconSize: 35,
                    text: "Personal Account"),
                GButton(
                    icon: Icons.event,
                    textStyle: TextStyle(
                        fontSize: 20, fontFamily: 'Salsa', color: Colors.white),
                    iconSize: 35,
                    text: ("Appointments")),
              ]),
        ),
      ),
      
      body: page[selectedIndex],
    );
  }
}
