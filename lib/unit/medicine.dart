import 'package:flutter/material.dart';

class medicine extends StatelessWidget {
  final String name;
  final String des;

  medicine({required this.name, required this.des});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 25, left: 5, bottom: 20),
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // 1st col
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Image.asset('assets/medicine.png'),
                ),

                SizedBox(
                  width: 20,
                ),

                // 2nd col
                Padding(
                  padding: const EdgeInsets.only(left: 25, top: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // name
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: 25,
                          fontFamily: 'salsa',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      // qty
                      Text(
                        des,
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
          ],
        ),
      ),
    );
  }
}
