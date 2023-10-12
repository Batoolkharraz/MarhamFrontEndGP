import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_4/Home/home.dart';
import 'package:flutter_application_4/appointment/appointment.dart';
import 'package:flutter_application_4/profile/profile.dart';
import 'package:flutter_application_4/unit/category.dart';
import 'package:flutter_application_4/unit/doctor.dart';
import 'package:flutter_application_4/Home/homePage.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:http/http.dart' as http;

class DoctorsPage extends StatefulWidget {
  final String categoryId;

  DoctorsPage({required this.categoryId});

  @override
  _DoctorsPageState createState() => _DoctorsPageState();
}

class _DoctorsPageState extends State<DoctorsPage> {
  List categories = [];
  List doctors = [];

  Future getCategories() async {
    var url = "https://marham-backend.onrender.com/category/";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var responceBody = response.body.toString();
      responceBody = responceBody.trim();
      responceBody = responceBody.substring(14, responceBody.length - 1);
      var cat = jsonDecode(responceBody);

      setState(() {
        categories.addAll(cat);
      });
    }
  }

  Future<String> getCategory(String catId) async {
    var url = "https://marham-backend.onrender.com/category/${catId}";
    var response = await http.get(Uri.parse(url));
    var responceBody = response.body.toString();
    responceBody = responceBody.trim();
    responceBody = responceBody.substring(12, responceBody.length - 1);
    var cat = jsonDecode(responceBody);

    return cat['name'];
  }

  Future<List<dynamic>> getDoctorsByCategory(String catId) async {
    var url = "https://marham-backend.onrender.com/doctor/category/${catId}";
    if (catId == '') {
      url = "https://marham-backend.onrender.com/doctor/";
    }
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var responceBody = response.body.toString();
      responceBody = responceBody.trim();
      responceBody = responceBody.substring(11, responceBody.length - 1);
      return jsonDecode(responceBody);
    }
    return []; // Return an empty list if there's an error
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
    super.initState();
    getCategories();
    getDoctorsByCategory(widget.categoryId).then((doctorList) {
      setState(() {
        doctors.addAll(doctorList);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: Scaffold(
        backgroundColor: Color(0xFFE8EEFA),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xFF0561DD),
          elevation: 0,
          centerTitle: true,
          title: Text(
            'doctor list',
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
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => homePage(),
                  ),
                );
              },
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 24.0),
              child: IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 40,
                ),
                onPressed: () {
                  // account button tapped
                },
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Column(
            children: [
              // other category
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  height: 130.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return category(
                        icon: '${categories[index]['image']['secure_url']}',
                        categoryName: '${categories[index]['name']}',
                        onTap: () => navigateToNextPageWithCategory(
                          '${categories[index]['_id']}',
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),

              //see all
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      navigateToNextPageWithCategory('');
                    },
                    child: Text('see all',
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 25,
                            fontFamily: 'Salsa')),
                  ),
                ],
              ),

              SizedBox(
                height: 15.0,
              ),

              // doctors
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15.0,
                    childAspectRatio: 0.77,
                  ),
                  itemCount: doctors.length,
                  itemBuilder: (context, index) {
                    return FutureBuilder(
                      future: getCategory('${doctors[index]['categoryId']}'),
                      builder: (context, categorySnapshot) {
                        if (categorySnapshot.hasError) {
                          return Text('Error: ${categorySnapshot.error}');
                        } else {
                          return Container(
                            //height: 300, // Adjust the height as needed
                            child: doctor(
                              doctorPic:
                                  '${doctors[index]['image']['secure_url']}',
                              doctorRate: '${doctors[index]['rate']}',
                              doctorName: '${doctors[index]['name']}',
                              doctorCat: categorySnapshot.data.toString(),
                            ),
                          );
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
