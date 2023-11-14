import 'package:flutter/material.dart';
import 'package:flutter_application_4/Home/cancleuser.dart';
import 'package:flutter_application_4/Home/completeuser.dart';
import 'package:flutter_application_4/Home/upcompleteuser.dart';
import 'package:flutter_application_4/doctorSide/cancle.dart';
import 'package:flutter_application_4/doctorSide/complete.dart';
import 'package:flutter_application_4/doctorSide/upcoming.dart';


class UserDaily extends StatefulWidget {
  const UserDaily({Key? key}) : super(key: key);

  @override
  State<UserDaily> createState() => _UserDailyState();
}


class _UserDailyState extends State<UserDaily> {
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        backgroundColor:  Color(0xFF0561DD),
        elevation: 1,
        title: Center(
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
                  padding: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
                  unselectedLabelColor:Color(0xFF0561DD),
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Color(0xFF0561DD)
                  ),
                  tabs: [
                    Tab(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Color(0xFF0561DD), width: 1)
                        ),
                        child: Align(
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
                            border: Border.all(color:Color(0xFF0561DD), width: 1)
                        ),
                        child: Align(
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
                            border: Border.all(color: Color(0xFF0561DD), width: 1)
                        ),
                        child: Align(
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
                    schedualupcomplete();
                  },
                  itemCount: 5,
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(8),
                ),
                  ),
                  Container(
                    
                     child: ListView.builder(
                  itemBuilder: (context, int i) {
                    return completeuser();
                  },
                  itemCount: 5,
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(8),
                ),
                    
                  ),
                 Container(
                    
                     child: ListView.builder(
                  itemBuilder: (context, int i) {
                    return cancleuser();
                    schedualupcomplete();
                  },
                  itemCount: 5,
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
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
