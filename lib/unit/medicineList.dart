import 'package:flutter/material.dart';

class medicineList extends StatelessWidget {
  final String diagnosis;
  final String from;
  final String to;
  final String writtenBy;
  final VoidCallback onTap;

  medicineList({
    required this.diagnosis,
    required this.from,
    required this.to,
    required this.writtenBy,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Color(0xFF0561DD),
            width: 3,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        height: 140,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 1st col
                Padding(
                  padding: const EdgeInsets.only(left: 25, top: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Diagnosis
                      Text(
                        'Diagnosis',
                        style: TextStyle(
                          fontSize: 25,
                          fontFamily: 'salsa',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      // Diagnosis
                      Text(
                        diagnosis,
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'salsa',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  width: 20,
                ),

                // 2nd col
                Padding(
                  padding: const EdgeInsets.only(right: 25, top: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Date
                      Text(
                        'Due to',
                        style: TextStyle(
                          fontSize: 25,
                          fontFamily: 'salsa',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      // from
                      Text(
                        from,
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'salsa',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // to
                      Text(
                        to,
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'salsa',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // state
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'By :',
                    style: TextStyle(
                      fontFamily: 'salsa',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    writtenBy,
                    style: TextStyle(
                      fontFamily: 'salsa',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
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
