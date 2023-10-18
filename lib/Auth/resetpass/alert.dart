import 'package:flutter/material.dart';
import 'package:flutter_application_4/Auth/Login/login.dart';
void showalertt(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
    width: 400, // Set the width as desired
    height: 400, // Set the height as desired
    child: Center(
      child: Column(
        children: [
          SizedBox(height: 40,),
          Image.asset("assets/Animation - 1697148558453.gif"),
          SizedBox(height: 40,),
          Text(
            "Password Changed!",
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontFamily: 'Salsa',
            ),
          ),
          SizedBox(height: 50,),
            Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF0561DD),
                fixedSize: Size(400, 50),
              ),
              child: Text(
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
                                return Login();
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