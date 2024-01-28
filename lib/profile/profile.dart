import 'dart:convert';
import 'package:flutter_application_4/Auth/updateinformation/edit.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_application_4/medicine/medicineSchedule.dart';
import 'package:flutter_application_4/unit/medicineList.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  List prescriptions = [];
  Map<String, dynamic> User = {};
  final storage = const FlutterSecureStorage();
  String userId = '';
  String point = '';
  int p = 0;

  @override
  void initState() {
    super.initState();
    getPrescription();
    getUserInfo();
    getPrice();
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

  Future<void> getPrescription() async {
    try {
      String id = await getTokenFromStorage();
      var url = "https://marham-backend.onrender.com/prescription/forUser/$id";
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var responseBody = response.body.toString();
        responseBody = responseBody.trim();
        responseBody = responseBody.substring(17, responseBody.length - 1);
        var pre = jsonDecode(responseBody);

        // Convert date strings to DateTime and sort by dateFrom in descending order
        pre.sort((a, b) {
          DateTime dateA = DateFormat('MM/dd/yyyy').parse(a['dateFrom']);
          DateTime dateB = DateFormat('MM/dd/yyyy').parse(b['dateFrom']);
          return dateB.compareTo(dateA);
        });

        // Format the sorted date as dd/mm/yyyy
        DateFormat fromFormat = DateFormat('dd/MM/yyyy');
        for (var prescription in pre) {
          prescription['dateFrom'] = fromFormat
              .format(DateFormat('MM/dd/yyyy').parse(prescription['dateFrom']));
          prescription['dateTo'] = fromFormat
              .format(DateFormat('MM/dd/yyyy').parse(prescription['dateTo']));
        }
        // Check if the widget is still mounted before calling setState
        if (mounted) {
          setState(() {
            prescriptions.clear();
            prescriptions.addAll(pre);
          });
        }
      }
    } catch (e) {
      // Handle the error, e.g., print or log it
      print('Error fetching prescriptions: $e');
    }
  }

  Future getUserInfo() async {
    String userid = await getTokenFromStorage();
    var url = "https://marham-backend.onrender.com/giveme/getUser/$userid";

    try {
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var responceBody = response.body.toString();
        responceBody = responceBody.trim();
        var user = jsonDecode(responceBody);

        // Check if the widget is still mounted before calling setState
        if (mounted) {
          setState(() {
            User.addAll(user);
          });
        }
      }
    } catch (e) {
      // Handle the error, e.g., print or log it
      print('Error fetching user info: $e');
    }
  }

  Future<String> getDoctor(String docId) async {
    var url = "https://marham-backend.onrender.com/doctor/$docId";
    var response = await http.get(Uri.parse(url));
    var responceBody = response.body.toString();
    responceBody = responceBody.trim();
    var doc = jsonDecode(responceBody);

    return doc['name'];
  }

  Future getAppointment() async {
    String id = await getTokenFromStorage();
    var url = "https://marham-backend.onrender.com/prescription/forUser/$id";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var responceBody = response.body.toString();
      responceBody = responceBody.trim();
      responceBody = responceBody.substring(17, responceBody.length - 1);
      var pre = jsonDecode(responceBody);

      // Convert date strings to DateTime and sort by dateFrom in descending order
      pre.sort((a, b) {
        DateTime dateA = DateFormat('MM/dd/yyyy').parse(a['dateFrom']);
        DateTime dateB = DateFormat('MM/dd/yyyy').parse(b['dateFrom']);
        return dateB.compareTo(dateA);
      });

      // Format the sorted date as dd/mm/yyyy
      DateFormat fromFormat = DateFormat('dd/MM/yyyy');
      for (var prescription in pre) {
        prescription['dateFrom'] = fromFormat
            .format(DateFormat('MM/dd/yyyy').parse(prescription['dateFrom']));
        prescription['dateTo'] = fromFormat
            .format(DateFormat('MM/dd/yyyy').parse(prescription['dateTo']));
      }
      if (mounted) {
        setState(() {
          prescriptions.clear();
          prescriptions.addAll(pre);
        });
      }
    }
  }

  Future getPrice() async {
    String id = await getTokenFromStorage();
    var url = "https://marham-backend.onrender.com/payment/points/$id/12";

    try {
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var responseBody = response.body.toString();
        responseBody = responseBody.trim();
        var app = jsonDecode(responseBody);

        print(response.body);
        print(app);
        if (app != null && app is Map<String, dynamic>) {
          if (mounted) {
            setState(() {
              p = app['point'];
              point = p.toString();
            });
          }
        } else {
          print('Unexpected response structure: $app');
        }
      } else {
        print('Failed to fetch data. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error during network request: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 214, 219, 223),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
              child: IconButton(
                icon: const Icon(
                  Icons.edit_note_sharp,
                  color: Color(0xFF0561DD),
                  size: 40,
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const EditUser(),
                    ),
                  );
                },
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
            child: Center(
          child: Container(
            child: Column(children: [
              User.isEmpty
                  ? const SizedBox(
                      height: 270,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : SizedBox(
                      height: 270,
                      child: Column(
                        children: [
                          Container(
                            width:
                                180, // Width and height to accommodate the border
                            height: 180,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(
                                    0xFF0561DD), // Blue border color
                                width: 3, // Adjust the border width as needed
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF0561DD)
                                      .withOpacity(0.3), // Shadow color
                                  offset: const Offset(0, 4), // Shadow position
                                  blurRadius: 15, // Shadow blur radius
                                ),
                              ],
                            ),
                            child: User['image'] != null
                                ? CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    backgroundImage: NetworkImage(
                                        User['image']['secure_url']),
                                    radius: 90,
                                  )
                                : const CircleAvatar(
                                    backgroundImage:
                                        AssetImage('assets/5bbc3519d674c.jpg'),
                                    radius: 90,
                                  ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            User['username'] ?? 'userName',
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Salsa',
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            User['email'] ?? 'email not found',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Salsa',
                            ),
                          ),
                        ],
                      ),
                    ),

              ///////////////////////////////////////////info
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50.0),
                      topRight: Radius.circular(50.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title

                        const Text(
                          'Personal Information',
                          style: TextStyle(
                            color: Color(0xFF0561DD),
                            fontSize: 28,
                            fontFamily: 'salsa',
                          ),
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        // Appointment

                        User.isEmpty
                            ? const SizedBox(
                                height: 250,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              )
                            : SizedBox(
                                height:
                                    250, // Set a fixed height or use a different value based on your design

                                child: ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: 1,
                                  itemBuilder: (context, index) {
                                    //  final appointment = appointmentList[index];

                                    return Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Container(
                                        height: 230,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                            width: 2,
                                            color: const Color(0xFF0561DD),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Column(
                                          children: [
                                            const SizedBox(
                                              height: 25,
                                            ),
                                            Row(
                                              children: [
                                                const SizedBox(
                                                  width: 25,
                                                ),
                                                const FaIcon(
                                                  FontAwesomeIcons.user,
                                                  color: Colors.blue,
                                                  size: 30.0,
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  User['username'] ??
                                                      'not found',
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 26,
                                                    fontFamily: 'salsa',
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Row(
                                              children: [
                                                const SizedBox(
                                                  width: 25,
                                                ),
                                                const FaIcon(
                                                  FontAwesomeIcons.locationDot,
                                                  color: Colors.blue,
                                                  size: 30.0,
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  User['address'] ??
                                                      'Nablus',
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 26,
                                                    fontFamily: 'salsa',
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Row(
                                              children: [
                                                const SizedBox(
                                                  width: 25,
                                                ),
                                                const FaIcon(
                                                  FontAwesomeIcons.mobileScreen,
                                                  color: Colors.blue,
                                                  size: 30.0,
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  User['phone'] ?? 'not found',
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 26,
                                                    fontFamily: 'salsa',
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Row(
                                              children: [
                                                const SizedBox(
                                                  width: 25,
                                                ),
                                                const FaIcon(
                                                  FontAwesomeIcons.coins,
                                                  color: Colors.blue,
                                                  size: 30.0,
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  point.isEmpty ? '0' : point,
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 26,
                                                    fontFamily: 'salsa',
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
              /////////////////////////////////////med

              Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //title

                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Your medicine',
                          style: TextStyle(
                            color: Color(0xFF0561DD),
                            fontSize: 30,
                            fontFamily: 'salsa',
                          ),
                        ),
                        Text(
                          'see all',
                          style: TextStyle(
                            color: Color(0xFF0561DD),
                            fontSize: 20,
                            fontFamily: 'salsa',
                          ),
                        ),
                      ],
                    ),

                    prescriptions.isEmpty
                        ? Center(
                            child: Column(
                              children: [
                                Container(
                                  height: 250,
                                  child: Image.asset('assets/medicine.png'),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          )
                        : SizedBox(
                            height: 260,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: prescriptions.length,
                              itemBuilder: (context, index) {
                                return FutureBuilder(
                                  future: getDoctor(
                                      '${prescriptions[index]['writtenBy']}'),
                                  builder: (context, categorySnapshot) {
                                    if (categorySnapshot.hasError) {
                                      return Text(
                                          'Error: ${categorySnapshot.error}');
                                    } else {
                                      return Container(
                                        child: medicineList(
                                          diagnosis: prescriptions[index]
                                              ['diagnosis'],
                                          from: prescriptions[index]
                                              ['dateFrom'],
                                          to: prescriptions[index]['dateTo'],
                                          writtenBy:
                                              categorySnapshot.data.toString(),
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    medicineSchedule(
                                                  medicines:
                                                      prescriptions[index]
                                                          ['medicines'],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      );
                                    }
                                  },
                                );
                              },
                              physics: const BouncingScrollPhysics(),
                            ),
                          ),
                  ],
                ),
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              ),

              //////////////////////////////
            ]),
          ),
        )));
  }
}
