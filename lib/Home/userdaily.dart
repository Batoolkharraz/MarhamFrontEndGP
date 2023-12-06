import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_4/Home/cancleuser.dart';
import 'package:flutter_application_4/Home/completeuser.dart';
import 'package:flutter_application_4/Home/upcompleteuser.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;


class UserDaily extends StatefulWidget {
  const UserDaily({Key? key}) : super(key: key);

  @override
  State<UserDaily> createState() => _UserDailyState();
}


class _UserDailyState extends State<UserDaily> {
    final storage = const FlutterSecureStorage();

 Future<String> getTokenFromStorage() async {
    final token = await storage.read(key: 'jwt');
    if (token != null) {
      final String userId = getUserIdFromToken(token);
      await Future.delayed(const Duration(seconds: 2));
      return userId;
    } else {
      print('Token not found in local storage.');
      return '';
    }
  }

  String getUserIdFromToken(String token) {
    try {
      final Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      final String userId = decodedToken['id'];
      return userId;
    } catch (e) {
      print('Error decoding token: $e');
      return '';
    }
  }


  Future getAllAppointment() async {
    String id = await getTokenFromStorage();
    var url = "https://marham-backend.onrender.com/schedule/byUser/all/654bbfeb25275580d9d2aed0$id";

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var responceBody = response.body.toString();
      responceBody = responceBody.trim();
      responceBody = responceBody.substring(17, responceBody.length - 1);
      var AllApp = jsonDecode(responceBody);


      setState(() {
      });
    }
  }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        backgroundColor:  const Color(0xFF0561DD),
        elevation: 1,
        title: const Center(
          child: Text("Appointment",
           style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Salsa',
                ),
           ),
        ),
      ),
      body:DefaultTabController(
        length: 3,
        child: Column(
          children: [
            Material(
              child: Container(
                height: 70,
                color: Colors.white,
                child: TabBar(
                  physics: const ClampingScrollPhysics(),
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
                  unselectedLabelColor:const Color(0xFF0561DD),
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: const Color(0xFF0561DD)
                  ),
                  tabs: [
                    Tab(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: const Color(0xFF0561DD), width: 1)
                        ),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text("upcoming"
                         , style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Salsa',
                ),),
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color:const Color(0xFF0561DD), width: 1)
                        ),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text("complete",
                          
                          style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Salsa',
                ),),
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: const Color(0xFF0561DD), width: 1)
                        ),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text("cancle",
                          style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Salsa',
                ),),
                        ),
                      ),
                    )
                  ],
               ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Container(
                  
                
                child: ListView.builder(
                  itemBuilder: (context, int i) {
                    return 
                    const schedualupcomplete();
                  },
                  itemCount: 5,
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(8),
                ),
                  ),
                  Container(
                    
                     child: ListView.builder(
                  itemBuilder: (context, int i) {
                    return const completeuser();
                  },
                  itemCount: 5,
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(8),
                ),
                    
                  ),
                 Container(
                    
                     child: ListView.builder(
                  itemBuilder: (context, int i) {
                    return const cancleuser();
                  },
                  itemCount: 5,
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(8),
                ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    
    );
  }
}
