import 'package:flutter/material.dart';

class timeList extends StatelessWidget {
  final String time;
  final bool isSelected;
  final VoidCallback onTap;

  timeList({required this.time,required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Container(
              height: 60,
              width: 120,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    time,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontSize: 25,
                      fontFamily: 'salsa',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color:  Color(0xFF0561DD),
                  width: 2),
                color: isSelected ? Color(0xFF0561DD) : Colors.transparent, // Change color on tap
              ),
            ),
          ),
        ),
      ],
    );
  }
}
