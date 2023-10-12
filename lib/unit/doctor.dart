import 'package:flutter/material.dart';

class doctor extends StatelessWidget {
  final String doctorPic;
  final String doctorRate;
  final String doctorName;
  final String doctorCat;

  doctor({
    required this.doctorPic,
    required this.doctorRate,
    required this.doctorName,
    required this.doctorCat,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: SizedBox(
        height: 300, // Set your desired height here
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: Colors.white,
          ),
          child: Column(
            children: [
              //pic
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image.network(
                    doctorPic,
                    height: 200.0,
                    width: 200.0,
                  ),
                ),
              ),
              //name
              Text(
                doctorName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 23,
                  fontFamily: 'Salsa',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              //category
              Text(
                doctorCat,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  fontFamily: 'Salsa',
                ),
              ),
              SizedBox(
                height: 5,
              ),
              //rate
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.star,
                    color: Color.fromARGB(255, 227, 212, 142),
                  ),
                  SizedBox(height: 15,),
                  Text(
                    doctorRate,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      fontFamily: 'Salsa',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
