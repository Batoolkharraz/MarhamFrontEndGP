import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class today extends StatelessWidget {
  @override
  final String bookId;
  final String userName;
  final String date;
  final String time;
  final String userId;
  final VoidCallback onTap;

  const today({super.key, 
    required this.bookId,
    required this.userName,
    required this.date,
    required this.time,
    required this.userId,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
     const storage = FlutterSecureStorage();

    String getUserIdFromToken(String token) {
      try {
        final Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
        final String userId = decodedToken['id'];
        return userId;
      } catch (e) {
        print('Error decoding token: $e');
        return '';
      }
    }

    Future<String> getTokenFromStorage() async {
      final token = await storage.read(key: 'jwt');
      if (token != null) {
        final String userId = getUserIdFromToken(token);
        await Future.delayed(const Duration(seconds: 2));
        return userId;
      } else {
        print('Token not found in local storage.');
        return '';
      }
    }

  Future<String> getDoctorId() async {
    String Id = await getTokenFromStorage();
    var url = "https://marham-backend.onrender.com/doctor/findId/$Id";
    var response = await http.get(Uri.parse(url));
    var responceBody = response.body.toString();
    responceBody = responceBody.trim();
    var id = jsonDecode(responceBody);

    return id;
  }
  
    Future<void> doneAppointment(String bookId, String userId) async {
      try {
      String docid = await getDoctorId();
        var url = Uri.parse(
            'https://marham-backend.onrender.com/schedule/done/$userId/$bookId/$docid');

        var response = await http.patch(
          url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            // You can include additional parameters here if needed
            // For example: 'reason': 'Some reason for cancellation'
          }),
        );
        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context as BuildContext).showSnackBar(
            const SnackBar(
              backgroundColor: Color(0xFF0561DD),
              content: Center(
                child: Text(
                  "the appointment saved as done",
                  style: TextStyle(
                    fontFamily: 'salsa',
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              duration:
                  Duration(seconds: 1), // The duration it will be displayed
            ),
          );
        } else {
          ScaffoldMessenger.of(context as BuildContext).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.red,
              content: Center(
                child: Text(
                  "Appointment does not saved.Try again!",
                  style: TextStyle(
                    fontFamily: 'salsa',
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              duration:
                  Duration(seconds: 1), // The duration it will be displayed
            ),
          );
        }
      } catch (error) {
        print('Error cancelling appointment: $error');
      }
    }

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.white,
            border: Border.all(
              color: Colors.grey, // Set the border color here
              width: 2.0, // Set the border width
            ),
          ),
          width: 600,
          height: 150,
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left:25.0,right:25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(userName,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Salsa')),
                      
                            InkWell(
                              child: const FaIcon(
                                FontAwesomeIcons.circleCheck,
                                size: 26.0,
                                color: Colors.green,
                              ),
                              onTap: () { 
                                doneAppointment(bookId, userId);
                              },
                            ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
               Row(
                children: [
                  const SizedBox(
                    width: 22,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: const Color.fromARGB(255, 228, 235, 248),
                      border: Border.all(
                        color: const Color.fromARGB(
                            255, 194, 186, 186), // Set the border color here
                        width: 2.0, // Set the border width
                      ),
                    ),
                    width: 450,
                    height: 70,
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 15,
                        ),
                        const FaIcon(
                          FontAwesomeIcons.calendar,
                          size: 26.0,
                          color: Color(0xFF0561DD),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(date,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Salsa')),
                        const SizedBox(
                          width: 100,
                        ),
                        const FaIcon(
                          FontAwesomeIcons.clock,
                          size: 26.0,
                          color: Color(0xFF0561DD),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(time,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Salsa')),
                      ],
                    ),
                  )
                ],
              )
             ],
            ),
          ),
        ),
      ),
    );
  }
}
