import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class working extends StatelessWidget {
  final String date;
  final String time;
  final String is_booked;
  final VoidCallback onTap;

  working({
    required this.date,
    required this.time,
    required this.is_booked,
    required this.onTap,
  });
  
  @override
  Widget build(BuildContext context) {
    final dateParts = date.split(' ');
    final formattedDate = '${dateParts[0]} ${dateParts[1]}\n${dateParts[2]}';

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
                  
                  Text(formattedDate,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Salsa')),
                  SizedBox(
                    width: 25,
                  ),
                  Text(time,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 50,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Salsa')),
                  SizedBox(
                    width: 70,
                  ),
                  InkWell(
                    child: Text(
                      is_booked == 'true' ? 'booked' : 'book',
                      style: TextStyle(
                        color: is_booked == 'true'
                            ? Colors.red
                            : Color(0xFF0561DD),
                        fontSize: 35,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Salsa',
                      ),
                    ),
                    onTap: onTap
                    ,
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
