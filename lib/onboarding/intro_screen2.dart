import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_svg/flutter_svg.dart';
class IntroPage2 extends StatelessWidget {
  const IntroPage2
({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor:Color.fromARGB(230, 21, 96, 225),
      
      body:Column(
       
        mainAxisAlignment: MainAxisAlignment.start,
        children:[
          Padding(padding:EdgeInsets.fromLTRB(0, 200, 0, 10))
         ,Center(child: CircleAvatar(
          child:Image.asset(
            "assets/Medicine-bro.png",) ,
          radius: 200,


         )
         ,),
     
          // SvgPicture.asset("assets/Doctors-pana.svg",),
            SizedBox(height: 10,),
          Text("Doctor's HelpLine",
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            fontFamily: 'Salsa',
            color: Colors.white

            ),
            ),
            SizedBox(height: 30,),
      Text(
  "streamlines scheduling, provides reminders,\n offers easy access to healthcare providers\n enhancing the patient experience and\n improving healthcare access.",
  style: TextStyle(
    height: 1.3,
    color: Colors.white,
    fontSize: 25,
  ),
  textAlign: TextAlign.center,
),



          
        ],
      ),

    );
  }
}