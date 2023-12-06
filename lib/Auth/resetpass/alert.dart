import 'package:flutter/material.dart';
import 'package:flutter_application_4/Auth/Login/login.dart';
void showalertt(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
    width: 400, // Set the width as desired
    height: 400, // Set the height as desired
    child: Center(
      child: Column(
        children: [
          const SizedBox(height: 40,),
          Image.asset("assets/Animation - 1697148558453.gif"),
          const SizedBox(height: 40,),
          const Text(
            "Password Changed!",
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontFamily: 'Salsa',
            ),
          ),
          const SizedBox(height: 50,),
            Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0561DD),
                fixedSize: const Size(400, 50),
              ),
              child: const Text(
                'OK',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontFamily: 'Salsa',
                ),
              ),
              onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                              builder: (context) {
                                return const Login();
                              },
                            ));// Close the alert dialog
              },
            ),
          ),
        ],
      )
              ),
          )
        );
            
          
        
      }
    );
}