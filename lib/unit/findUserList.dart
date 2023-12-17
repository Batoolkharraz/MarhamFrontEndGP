import 'package:flutter/material.dart';

class findUserList extends StatelessWidget {
  final String userPic;
  final String userName;
  final VoidCallback onTap;

  const findUserList({super.key, 
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
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 70,
                  height: 70,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(userPic),
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(userName,
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w500,fontSize: 25)),
                    const SizedBox(
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
