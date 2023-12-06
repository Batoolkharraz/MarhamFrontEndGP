import 'package:flutter/material.dart';

class findUserList extends StatelessWidget {
  final String userPic;
  final String userName;
  final VoidCallback onTap;

  findUserList({
    required this.userPic,
    required this.userName,
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
                    child: Image.network(userPic),
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(userName,
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w500,fontSize: 25)),
                    SizedBox(
                      height: 5,
                    ),
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
