import 'package:flutter/material.dart';

class category extends StatelessWidget {
  final icon;
  final String categoryName;
  final VoidCallback onTap;

  category({
    required this.icon,
    required this.categoryName,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Container(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 5),
          width: 150.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.white,
            /*border: Border.all(
              color: Color(0xFF0561DD),
              width: 3.0,
            ),*/
          ),
          child: Column(
            children: [
              Image.network(
                icon,
                height: 50.0,
              ),
              // ignore: prefer_const_constructors
              SizedBox(
                height: 25,
              ),
              Center(
                child: Text(
                  categoryName,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Salsa',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
