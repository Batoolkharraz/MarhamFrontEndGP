
import 'package:flutter/material.dart';
import 'package:flutter_application_4/doctorSide/cancle.dart';
import 'package:flutter_application_4/doctorSide/complete.dart';
import 'package:flutter_application_4/doctorSide/upcoming.dart';


class AppointmentPage extends StatefulWidget {
  const AppointmentPage({Key? key}) : super(key: key);

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}


class _AppointmentPageState extends State<AppointmentPage> {

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        backgroundColor:  const Color(0xFF0561DD),
        elevation: 1,
        title: const Center(
          child: Text("Your Appointment",
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
                    return const schedual();
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
                    return const complete();
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
                    return const cancle();
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
