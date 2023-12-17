import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class cancleuser extends StatelessWidget {
    final String Id;
    final String doctorName;
  final String date;
  final String time;

  const cancleuser({super.key, 
    required this.Id,
    required this.doctorName,
    required this.date,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.white,
          border: Border.all(
            color: Colors.grey, // Set the border color here
            width: 2.0, // Set the border width
          ),
        ),
        width: 600,
        height: 150,
        child: Padding(
          padding: const EdgeInsets.only(top:10,left: 15,right: 15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(doctorName,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Salsa')),
                          
                           const Text("canceled",
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Salsa')),
                  

                ],
              ),
              const SizedBox(height: 10,),
              Row(
                children: [
                  const SizedBox(
                    width: 22,
                  ),
                 Container(
                  decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color:  const Color.fromARGB(255, 228, 235, 248),
          border: Border.all(
            color: const Color.fromARGB(255, 194, 186, 186), // Set the border color here
            width: 2.0, // Set the border width
          ),
        ),
                  
                  width: 450,
                  height: 70,
                  child: Row(
                    children: [
                      const SizedBox(width: 15,),
                      const FaIcon(
                                      FontAwesomeIcons.calendar,
                                      size: 26.0,
                                      color: Color(0xFF0561DD),
                                    ),
                                    const SizedBox(width: 10,),
                      Text(date,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Salsa')),
                          const SizedBox(width:25,),
                           const FaIcon(
                                      FontAwesomeIcons.clock,
                                      size: 26.0,
                                      color: Color(0xFF0561DD),
                                    ),
                                    const SizedBox(width:10,),
                                    Text(time,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Salsa')),

                    ],
                  ),
                 )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
