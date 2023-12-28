import 'package:flutter/material.dart';
import 'package:flutter_application_4/Home/userdaily.dart';
import 'package:flutter_application_4/Home/home.dart';
import 'package:flutter_application_4/payment/wallet/points.dart';
import 'package:flutter_application_4/profile/profile.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  List<Widget> page = [const home(), const profile(), const UserDaily(),coinspage()];
  int selectedIndex = 0;

  void navigateBottomBar(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8EEFA),
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
              tabBackgroundColor: const Color(0xFF0561DD),
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
                    GButton(
                    icon: Icons.money,
                    textStyle: TextStyle(
                        fontSize: 20, fontFamily: 'Salsa', color: Colors.white),
                    iconSize: 35,
                    text: ("Wallet")),
              ]),
              
        ),
      ),
      
      body: page[selectedIndex],
    );
  }
}
