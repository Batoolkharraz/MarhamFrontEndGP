// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_4/Home/userdaily.dart';
import 'package:flutter_application_4/doctorappointment/doctorapp.dart';
import 'package:flutter_application_4/Home/home.dart';
import 'package:flutter_application_4/doctors/doctors.dart';
import 'package:flutter_application_4/profile/profile.dart';
import 'package:flutter_application_4/search/searchDoctor.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:http/http.dart' as http;

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  List<Widget> page = [home(), profile(), UserDaily()];
  int selectedIndex = 0;

  void navigateBottomBar(int index) {
    setState(() {
      selectedIndex = index;
    });
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
