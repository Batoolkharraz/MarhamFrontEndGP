import 'package:flutter/material.dart';

class patientRec extends StatelessWidget {
  final String diagnosis;
  final String from;

  const patientRec({super.key, 
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
            color: const Color(0xFF0561DD),
          ),
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
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
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.date_range_outlined,
                          color: Color(0xFF0561DD),
                          size: 50,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Text(
                          'at Date:',
                          style: TextStyle(
                            fontSize: 25,
                            fontFamily: 'salsa',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          from,
                          style: const TextStyle(
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
                      style: const TextStyle(
                        fontSize: 30,
                        fontFamily: 'salsa',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
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
