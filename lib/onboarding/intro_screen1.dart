import 'package:flutter/material.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: const Color.fromARGB(230, 21, 96, 225),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
          // Padding(padding:EdgeInsets.fromLTRB(0, 10, 0,0))
         

            
            
              ClipRRect(
  borderRadius: const BorderRadius.only(
    bottomLeft: Radius.circular(100.0), // Adjust the radius as needed
    bottomRight: Radius.circular(100.0), // Adjust the radius as needed
  ),
  child: Container(
    // margin: EdgeInsets.fromLTRB(0, 80, 0, 100),
   padding: const EdgeInsets.fromLTRB(0, 200, 0,170),
      width: 550,
      color:Colors.white,
   child:Column(
     children: [
       Image.asset('assets/page1.gif'),
        const SizedBox(height: 40,),
      const Text(
              'What is New in Our App?',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontFamily: 'Salsa',
                color: Color.fromARGB(230, 21, 96, 225),

              ),
            ),   
      
            
     ],
   ) ,
    ),
   
  ),
         
          
            
          ],
        ),
      ),
    );
  }
}
