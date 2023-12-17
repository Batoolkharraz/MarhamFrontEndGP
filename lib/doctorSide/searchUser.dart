import 'package:flutter/material.dart';
import 'package:flutter_application_4/doctorSide/userProfile.dart';
import 'dart:convert';
import 'package:flutter_application_4/unit/findUserList.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

class searchUser extends StatefulWidget {
  const searchUser({super.key});

  @override
  State<searchUser> createState() => _searchUserState();
}

class _searchUserState extends State<searchUser> {
  List users = [];
  List _foundedUsers = [];
  List addresses = [
    'Nablus',
    'Ramallah',
    'Betlahem',
    'Jenin',
  ];
  List<String> searchCat = [];
  List<String> searchAddress = [];
  bool display = false;
  final storage = const FlutterSecureStorage();



Future<List<dynamic>> getUsers() async {
  var url = "https://marham-backend.onrender.com/update/getUser";

  try {
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var responseBody = response.body.toString();
      responseBody = responseBody.trim();
      responseBody = responseBody.substring(9, responseBody.length - 1);
      var user = jsonDecode(responseBody);
      
      // Assuming users is a list in your widget's state
      setState(() {
        users.addAll(user);
      });

      // Return the list of users
      return user;
    } else {
      print("Failed to load users. Status code: ${response.statusCode}");
      // Return an empty list if there's an error
      return [];
    }
  } catch (error) {
    print("Error loading users: $error");
    // Return an empty list if there's an error
    return [];
  }
}

void _showSearchOptionsBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Filters',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'salsa',
              ),
            ),
            const SizedBox(height: 15),
            const Padding(
              padding: EdgeInsets.only(left: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Select Address',
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'salsa',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 2.0,
                ),
                itemCount: addresses.length, // Assuming you have a list of addresses
                itemBuilder: (context, index) {
                  var address = addresses[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {/*
                        _foundedUsers = users
                            .where((user) =>
                                user['address'].contains(address))
                            .toList();*/
                      });
                      display = true;
                      searchAddress.add(address);
                      print(searchAddress);
                      Navigator.pop(context);
                    },
                    child: Card(
                      child: Center(
                        child: Text(
                          address,
                          style: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'salsa',
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}


  onSearch(String search) {
    setState(() {
      _foundedUsers = users
          .where((user) => user['username'].toLowerCase().contains(search))
          .toList();
    });
  }


  @override
  void initState() {
    super.initState();
    getUsers();
    setState(() {
      _foundedUsers = users;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 90,
        backgroundColor: const Color(0xFF0561DD),
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Find Patient',
          style: TextStyle(
            fontFamily: 'salsa',
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 25,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 25, right: 15, bottom: 25, top: 25),
                  child: SizedBox(
                    height: 60,
                    width: 450,
                    child: TextField(
                      onTap: () {
                        display = true;
                      },
                      onChanged: (value) => onSearch(value),
                      decoration: const InputDecoration(
                        labelText: 'Search',
                        labelStyle: TextStyle(
                          fontSize: 25,
                          fontFamily: 'salsa',
                          fontWeight: FontWeight.bold,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF0561DD),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF0561DD),
                          ),
                        ),
                        prefixIcon: Icon(Icons.search),
                      ),
                      style: const TextStyle(
                        fontSize: 20,
                        fontFamily: 'salsa',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                    width:
                        10), // Adjust the spacing between TextField and IconButton
                InkWell(
                  child: const FaIcon(
                    FontAwesomeIcons.filter,
                    size: 26.0,
                    color: Colors.grey,
                  ),
                  onTap: () {
                    _showSearchOptionsBottomSheet(context);
                  },
                ),
              ],
            ),
            Expanded(
              child: _foundedUsers.isEmpty ||
                      display == false
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 150),
                        child: Column(
                          children: [
                            Container(
                              child: Image.asset('assets/patient_report.png'),
                            ),
                          ],
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _foundedUsers.length,
                      itemBuilder: (context, index) {
                        return Slidable(
                          actionPane: const SlidableDrawerActionPane(),
                          actionExtentRatio: 0.25,
                          child: findUserList(
                            userPic:
                                '${_foundedUsers[index]['image']['secure_url']}',
                            userName: '${_foundedUsers[index]['username']}',
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => userProfile(
                                    user: _foundedUsers[index]),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
