import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
class IntroPage3 extends StatelessWidget {
  const IntroPage3
({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor:  Color.fromARGB(230, 21, 96, 225),
      body:Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children:[
        ClipRRect(
  borderRadius: BorderRadius.only(
    bottomLeft: Radius.circular(100.0), // Adjust the radius as needed
    bottomRight: Radius.circular(100.0), // Adjust the radius as needed
  ),
  child: Container(
    padding: EdgeInsets.fromLTRB(0, 100, 0, 40),
    child: Image.asset(
      "assets/Doctors-cuate.png",
      width: 550,
      fit: BoxFit.cover,
    ),
    color: Colors.white,
  ),
),

SizedBox(height: 60,),
          Text("WE ARE HERE FOR YOU",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            fontFamily: 'Salsa',
            color: Colors.white

            ),

            ),
            SizedBox(height: 16,),
            Text(
              "Connect with trusted doctors for\n expert medical guidance and care."
              ,style: TextStyle(
    height: 1.5,
    color: Colors.white,
    fontSize: 25,
  ),
   textAlign: TextAlign.center,)

        ]
      ),

    );
  }
}