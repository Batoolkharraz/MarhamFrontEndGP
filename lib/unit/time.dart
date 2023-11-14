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
            padding: const EdgeInsets.only(left:15),
            child:
         Container(
          width: 150,
          height:60,
        child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    time,
                    style: TextStyle(
                      color: isSelected ? Color(0xFF0561DD): Colors.black,
                      fontSize: 27,
                      fontFamily: 'salsa',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
                       
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Color(0xFF0561DD), width: 1)
                        ),
                      
                        
                      ),
          ),
         )
       
          
      ],
    );
  }
}
