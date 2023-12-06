import 'package:flutter/material.dart';
class IntroPage3 extends StatelessWidget {
  const IntroPage3
({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor:  const Color.fromARGB(230, 21, 96, 225),
      body:Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children:[
        ClipRRect(
  borderRadius: const BorderRadius.only(
    bottomLeft: Radius.circular(100.0), // Adjust the radius as needed
    bottomRight: Radius.circular(100.0), // Adjust the radius as needed
  ),
  child: Container(
    padding: const EdgeInsets.fromLTRB(0, 100, 0, 40),
    color: Colors.white,
    child: Image.asset(
      "assets/Doctors-cuate.png",
      width: 550,
      fit: BoxFit.cover,
    ),
  ),
),

const SizedBox(height: 60,),
          const Text("WE ARE HERE FOR YOU",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            fontFamily: 'Salsa',
            color: Colors.white

            ),

            ),
            const SizedBox(height: 16,),
            const Text(
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