import 'package:flutter/material.dart';

class dateList extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;

  const dateList({super.key, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color:  const Color(0xFF0561DD),
              width: 2),
            color: isSelected ? const Color(0xFF0561DD) : Colors.transparent, // Change color on tap
          ),
          child: Center(
            child: Text(
              '25 Sep',
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontSize: 25,
                fontFamily: 'salsa',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
