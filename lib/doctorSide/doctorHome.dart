import 'package:flutter/material.dart';
import 'package:flutter_application_4/doctorSide/writePrescription.dart';

class doctorHome extends StatefulWidget {
  const doctorHome({super.key});

  @override
  State<doctorHome> createState() => _doctorHomeState();
}

class _doctorHomeState extends State<doctorHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE8EEFA),
      body: Padding(
        padding: const EdgeInsets.only(top: 50, left: 25, right: 25),
        child: Container(
          child: Column(children: [
            //app bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello,',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 6.0,
                    ),
                    Text(
                      ' batool kh',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                //profile pic
                Container(
                  padding: EdgeInsets.all(12),
                  margin: EdgeInsets.only(right: 5.0),
                  decoration: BoxDecoration(
                      color: Colors.deepPurple[100],
                      borderRadius: BorderRadius.circular(50)),
                  child: Icon(
                    Icons.person,
                    size: 45.0,
                  ),
                ),
              ],
            ),

            SizedBox(height: 50.0),

            //check patient record
            GestureDetector(
              onTap: () {},
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
                      child: Image.asset('assets/patient_icon.png'),
                    ),
                    Text(
                      'Check patient record',
                      style: TextStyle(
                        fontFamily: 'salsa',
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(
              height: 30,
            ),

            //write prescription
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => writePrescription(),
                  ),
                );
              },
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
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Container(
                        child: Image.asset('assets/prescription.png'),
                      ),
                    ),
                    Text(
                      'Write Prescription',
                      style: TextStyle(
                        fontFamily: 'salsa',
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(
              height: 30,
            ),

          ]),
        ),
      ),
    );
  }
}
