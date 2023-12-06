import 'package:flutter/material.dart';
import 'package:flutter_application_4/doctorappointment/workinghour.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

class appTime extends StatefulWidget {
  final String docId;
  final String date;
  final List<Map<String, dynamic>> timeSlots;

  appTime({required this.timeSlots, required this.date, required this.docId});

  @override
  State<appTime> createState() => _appTimeState();
}

class _appTimeState extends State<appTime> {
  final storage = FlutterSecureStorage();

  Future<String> getTokenFromStorage() async {
    final token = await storage.read(key: 'jwt');
    if (token != null) {
      final String userId = getUserIdFromToken(token);
      await Future.delayed(Duration(seconds: 2));
      return userId;
    } else {
      print('Token not found in local storage.');
      return '';
    }
  }

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

  void bookedApp(String appId) async {
    String id = await getTokenFromStorage();
    final response = await http.post(
      Uri.parse(
          'https://marham-backend.onrender.com/schedule/${id}/${appId}/${widget.docId}'), // Replace with your server URL
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Color(0xFF0561DD),
            content: Center(
              child: Text(
                "your appointment has been booked!",
                style: TextStyle(
                  fontFamily: 'salsa',
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            duration: Duration(seconds: 1), // The duration it will be displayed
          ),
        );
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Center(
              child: Text(
                "Something Went Wrong, Please try again!",
                style: TextStyle(
                  fontFamily: 'salsa',
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            duration: Duration(seconds: 1), // The duration it will be displayed
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE8EEFA),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xFF0561DD),
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Available Appointment Time',
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Salsa',
            ),
          ),
          leading: Padding(
            padding: const EdgeInsets.only(left: 24.0),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 40,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: [
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Here are the appointments for this day:',
                  style: TextStyle(
                    fontSize: 25,
                    fontFamily: 'salsa',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, int index) {
                  final slot = widget.timeSlots[index];
                  return working(
                    date: ' ${widget.date}',
                    time: ' ${slot['time']}',
                    is_booked: '${slot['is_booked']}',
                    onTap: () {
                      if (slot['is_booked']) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red,
                            content: Center(
                              child: Text(
                                "This appointment has been booked!",
                                style: TextStyle(
                                  fontFamily: 'salsa',
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else {
                        bookedApp(slot['_id']);
                      }
                    },
                  );
                },
                separatorBuilder: (context, index) =>
                    Divider(), // Add a divider between items
                itemCount: widget.timeSlots.length,
                padding: const EdgeInsets.all(8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
