import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_4/Auth/chat/chatpage.dart';
import 'package:flutter_application_4/doctorappointment/doctorapp.dart';
import 'package:flutter_application_4/doctors/doctorsfF.dart';
import 'package:flutter_application_4/search/searchDoctor.dart';
import 'package:flutter_application_4/unit/category.dart';
import 'package:flutter_application_4/unit/doctor.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  List categories = [];
  List doctors = [];
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
  Future<void> getCategories() async {
    var url = "https://marham-backend.onrender.com/category/";

    try {
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var responceBody = response.body.toString();
        responceBody = responceBody.trim();
        responceBody = responceBody.substring(14, responceBody.length - 1);
        var cat = jsonDecode(responceBody);
        setState(() {
          categories.addAll(cat);
        });
      } else {
        // Handle the error when the HTTP request fails
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      // Handle other types of errors, such as network errors
      print('Error: $error');
    }
  }

  Future<String> getCategory(String catId) async {
    var url = "https://marham-backend.onrender.com/category/$catId";
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var responseBody = response.body.toString();

      if (responseBody.length >= 12) {
        responseBody = responseBody.trim();
        responseBody = responseBody.substring(12, responseBody.length - 1);
        var cat = jsonDecode(responseBody);

        if (cat.containsKey('name')) {
          return cat['name'];
        }
        else{
           return "";
        }
      }
    }

    // Return a default value or an error message in case of issues
    return 'Category not found';
  }

  Future getDoctor() async {
    String userId = await getTokenFromStorage();
    try {
      var url = "https://marham-backend.onrender.com/doctor/Usersearch/$userId";
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var responceBody = response.body.toString();
        responceBody = responceBody.trim();
        var doc = jsonDecode(responceBody);

        setState(() {
          //print(getCategory(doc[0]['categoryId']));
          doctors.addAll(doc);
        });
      }
    } catch (error) {
      print("Error fetching today appointments: $error");
      // Handle the error accordingly
    }
  }

  void navigateToNextPageWithCategory(String categoryId) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DoctorsPage(categoryId: categoryId),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    getCategories();
    getDoctor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Find Your',
                          style: TextStyle(fontSize: 25.0, fontFamily: 'Salsa'),
                        ),
                        SizedBox(
                          height: 2.0,
                        ),
                        Text(
                          ' Specialist',
                          style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Salsa'),
                        )
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(4),
                      margin: const EdgeInsets.only(right: 5.0),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              FontAwesomeIcons.search,
                              size: 30.0,
                            ),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const searchDoctor(),
                                ),
                              );
                            },
                          ),
                          const SizedBox(width: 20.0),
                          IconButton(
                            icon: const Icon(
                              FontAwesomeIcons.commentDots,
                              size: 30.0,
                            ),
                            onPressed: () {
                               Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return const ChatPage(); // Navigate to the home page
            },
          ),
        );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15.0),
///////////////////////////////////////////////////////////////////cards

              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF0561DD),
                  borderRadius:
                      BorderRadius.circular(29), // Set the border radius here
                ),
                padding: const EdgeInsets.all(15),
                height: 260,
                margin: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  children: [
                    Container(
                      color: const Color(0xFF0561DD),
                      width: 280,
                      height: 250,
                      padding: const EdgeInsets.only(top: 20),
                      child: const Column(
                        children: [
                          Text(
                            "Looking For Your derired doctor specialist?",
                            style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: 'Salsa'),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Connect with trusted doctors \nfor expert medical guidance and care.",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      color: const Color(0xFF0561DD),
                      width: 190,
                      height: 250,
                      child: Image.asset("assets/copy.png", fit: BoxFit.cover),
                    ),
                  ],
                ),
              ),

              //category
              Container(
                margin: const EdgeInsets.all(13),
                width: 500,
                child: const Text(
                  "Categories",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 25.0, fontFamily: 'Salsa'),
                ),
              ),
              SizedBox(
                height: 130.0,
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return category(
                        icon: '${categories[index]['image']['secure_url']}',
                        categoryName: '${categories[index]['name']}',
                        onTap: () => navigateToNextPageWithCategory(
                            '${categories[index]['_id']}'),
                      );
                    }),
              ),
              const SizedBox(
                height: 25,
              ),
              //doc
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Suggestion',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontFamily: 'Salsa')),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 335.0,
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: doctors.length,
                    itemBuilder: (context, index) {
                      return FutureBuilder(
                        future: getCategory('${doctors[index]['categoryId']}'),
                        builder: (context, categorySnapshot) {
                          if (categorySnapshot.hasError) {
                            return Text('Error: ${categorySnapshot.error}');
                          } else {
                            return doctor(
                                doctorPic:
                                    '${doctors[index]['image']['secure_url']}',
                                doctorRate: '${doctors[index]['rate']}',
                                doctorName: '${doctors[index]['name']}',
                                doctorCat: categorySnapshot.data.toString(),
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          appointment(doctor: doctors[index]),
                                    ),
                                  );
                                });
                          }
                        },
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
