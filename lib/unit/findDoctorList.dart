import 'package:flutter/material.dart';

class findDoctorList extends StatelessWidget {
  final String doctorPic;
  final String doctorName;
  final String doctorCat;
  final VoidCallback onTap;

  findDoctorList({
    required this.doctorPic,
    required this.doctorName,
    required this.doctorCat,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
      return 
      GestureDetector(
      onTap: onTap,
        child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        padding: EdgeInsets.only(top: 10, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 70,
                  height: 70,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(doctorPic),
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(doctorName,
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w500,fontSize: 25)),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      doctorCat,
                      style: TextStyle(color: Colors.grey[500],fontSize: 15),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
          ),
      );
  }
  }
