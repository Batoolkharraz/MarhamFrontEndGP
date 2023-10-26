import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_4/unit/findDoctorList.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;


class searchDoctor extends StatefulWidget {
  const searchDoctor({super.key});

  @override
  State<searchDoctor> createState() => _searchDoctorState();
}

class _searchDoctorState extends State<searchDoctor> {
  List _doctors = [];

  List _foundedDoctors = [];

  Future<List<dynamic>> getDoctorsByCategory() async {
    var url = "https://marham-backend.onrender.com/doctor/";

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var responceBody = response.body.toString();
      responceBody = responceBody.trim();
      responceBody = responceBody.substring(11, responceBody.length - 1);
      var doc = jsonDecode(responceBody);
      print(doc);
      setState(() {
        _doctors.addAll(doc);
      });
    }
    return []; // Return an empty list if there's an error
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDoctorsByCategory();
    setState(() {
      _foundedDoctors = _doctors;
    });
  }

  onSearch(String search) {
    setState(() {
      _foundedDoctors = _doctors
          .where((doctor) => doctor['name'].toLowerCase().contains(search))
          .toList();
    });
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
            'Find Your Doctor',
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
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
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(25.0),
              child: Container(
                child: TextField(
                  onChanged: (value) => onSearch(value),
                  decoration: InputDecoration(
                    labelText: 'Doctor Name',
                    labelStyle: TextStyle(
                        fontSize: 27,
                        fontFamily: 'salsa',
                        fontWeight: FontWeight.bold),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color(
                              0xFF0561DD)), // Change the border color when focused
                    ),
                    prefixIcon: Icon(Icons.search),
                  ),
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'salsa',
                      fontWeight: FontWeight.bold),
                  // Add an icon to the left of the input
                ),
              ),
            ),
            Expanded(
                child: _foundedDoctors.isEmpty || _foundedDoctors == null
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 150),
                          child: Column(
                            children: [
                              Container(
                                  //child: Image.asset('assets/doctor_category.png'),
                                  ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'There is No Doctor Added Yet!',
                                style: TextStyle(
                                  fontFamily: 'salsa',
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _foundedDoctors.length,
                        itemBuilder: (context, index) {
                          return Slidable(
                            actionPane: SlidableDrawerActionPane(),
                            actionExtentRatio: 0.25,
                            child: findDoctorList(
                              doctorPic:
                                  '${_foundedDoctors[index]['image']['secure_url']}',
                              doctorName: '${_foundedDoctors[index]['name']}',
                              doctorCat: '${_foundedDoctors[index]['rate']}',
                              onTap: () {},
                            ),
                          );
                        })),
          ],
        ),
      ),
    );
  }
}
