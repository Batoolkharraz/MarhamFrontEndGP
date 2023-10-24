import 'package:flutter/material.dart';

class patientRec extends StatelessWidget {
  final String diagnosis;
  final String from;

  patientRec({
    required this.diagnosis,
    required this.from,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            width: 2,
            color: Color(0xFF0561DD),
          ),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey, // Shadow color
              offset: Offset(0, 0), // Offset of the shadow
              blurRadius: 15, // Spread of the shadow
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        Icon(
                          Icons.date_range_outlined,
                          color: Color(0xFF0561DD),
                          size: 50,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'at Date:',
                          style: TextStyle(
                            fontSize: 25,
                            fontFamily: 'salsa',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          from,
                          style: TextStyle(
                            fontSize: 25,
                            fontFamily: 'salsa',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: Text(
                      diagnosis,
                      style: TextStyle(
                        fontSize: 30,
                        fontFamily: 'salsa',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
