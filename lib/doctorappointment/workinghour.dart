import 'package:flutter/material.dart';

class working extends StatelessWidget {
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
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 25,
                  ),
                  Text("Sat \n07 Dec,2023",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Salsa')),
                  SizedBox(
                    width: 29,
                  ),
                  Text("4 PM",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 50,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Salsa')),
                  SizedBox(
                    width: 70,
                  ),
                  InkWell(
                    child: Text("Book",
                        style: TextStyle(
                            color: Color(0xFF0561DD),
                            fontSize: 38,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Salsa')),
                    onTap: () {
                      print("Booked");
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
