import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_4/doctorSide/doctorHome.dart';
import 'package:flutter_application_4/unit/diagnosisList.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;

class medicine_info {
  String medicine = '';
  String description = '';
  String time = '';

  medicine_info({
    required this.medicine,
    required this.description,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      'medicine': medicine,
      'description': description,
      'time': time,
    };
  }
}

class writePrescription extends StatefulWidget {
  final String userId;
  final String userName;

  writePrescription({required this.userId, required this.userName});

  @override
  _writePrescriptionState createState() => _writePrescriptionState();
}

class _writePrescriptionState extends State<writePrescription> {
  List<medicine_info> medicineList = [];
  final diagnosisController = TextEditingController();
  final emailController = TextEditingController();
  final medNmaeController = TextEditingController();
  final medDesController = TextEditingController();
  final storage = FlutterSecureStorage();
  String userId = '';
  Map<int, String> selectedTimes = {};
  int numberOfMid = 1;
  DateTime selectedStartDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();

  Future<TimeOfDay?> pickTime() => showTimePicker(
      context: context, initialTime: TimeOfDay(hour: 12, minute: 00));

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
      await Future.delayed(Duration(seconds: 2));
      return userId;
    } else {
      print('Token not found in local storage.');
      return '';
    }
  }

  void createPrescription() async {
    //String id = await getTokenFromStorage();
    String id = '656bb1954b14538a5797a185';
    final startDate =
        '${selectedStartDate.year}-${selectedStartDate.month}-${selectedStartDate.day}';
    final endDate =
        '${selectedEndDate.year}-${selectedEndDate.month}-${selectedEndDate.day}';
    final diagnosis = diagnosisController.text;
    final email = emailController.text;

    // Convert medicine_info objects to maps using toMap()
    List<Map<String, dynamic>> medList =
        medicineList.map((medicine) => medicine.toMap()).toList();

    if (selectedEndDate.isBefore(selectedStartDate)) {
      // Show the error dialog for invalid time selection
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              // Your dialog content
              );
        },
      );
    } else {
      final prescription = {
        "email": email,
        "diagnosis": diagnosis,
        "dateFrom": startDate,
        "dateTo": endDate,
        "medicines": medList,
      };

      final response = await http.post(
        Uri.parse(
            'https://marham-backend.onrender.com/prescription/${widget.userId}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(prescription),
      );

      if (response.statusCode == 201) {
        // Show a success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Color(0xFF0561DD),
            content: Center(
              child: Text(
                "Prescription Details have been saved",
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
      } else {
        // Handle the error when the HTTP request fails
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Center(
              child: Text(
                "Please Check the data again!",
                style: TextStyle(
                  fontFamily: 'salsa',
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            duration: Duration(seconds: 2), // The duration it will be displayed
          ),
        );
      }
    }
  }

  void saveMedicineDetails(
      int index, String name, String description, String time) {
    medicine_info medicine = medicine_info(
      medicine: name,
      description: description,
      time: time,
    );

    if (index < medicineList.length) {
      medicineList[index] = medicine; // Update an existing medicine info
    } else {
      medicineList.add(medicine); // Add a new medicine info
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> combinationWidgets = List.generate(
      numberOfMid,
      (index) {
        // Add a variable to store the selected time for each combination
        return Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: Color.fromARGB(255, 111, 110, 110), width: 1)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      'Medicine Details:',
                      style: TextStyle(
                        color: Color(0xFF0561DD),
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Salsa',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: medNmaeController,
                    decoration: InputDecoration(
                      labelText: 'Name of Medicine',
                      labelStyle: TextStyle(fontSize: 25, fontFamily: 'Salsa'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: medDesController,
                    decoration: InputDecoration(
                      labelText: 'Description (2 PillS after eat)',
                      labelStyle: TextStyle(fontSize: 25, fontFamily: 'Salsa'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color.fromARGB(255, 111, 110, 110),
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: DropdownButton<String>(
                          hint: Text(
                            'Select Time',
                            style: TextStyle(
                              fontFamily: 'Salsa',
                              fontSize: 25,
                            ),
                          ),
                          items: <String>['morning', 'noon', 'night']
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            // Handle dropdown value change here
                            setState(() {
                              selectedTimes[index] = newValue ?? '';
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Time: ${selectedTimes[index] ?? ""}',
                        style: TextStyle(
                          fontFamily: 'Salsa',
                          fontSize: 25,
                          color: Color.fromARGB(255, 111, 110, 110),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        String name =
                            medNmaeController.text; // Get name from TextField
                        String description = medDesController.text;
                        String time = selectedTimes[index] ?? '';
                        saveMedicineDetails(index, name, description, time);

                        // Clear the input fields or update the UI as needed
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Color(
                              0xFF0561DD) // Set the background color to green
                          ),
                      child: Text(
                        "Save Medicine",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Salsa',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        );
      },
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 90,
          backgroundColor: Color(0xFF0561DD),
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Prescription Details',
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Salsa',
            ),
          ),
          leading: Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 25,
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => doctorHome(),
                  ),
                );
              },
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 25, top: 5),
              child: IconButton(
                icon: Icon(
                  Icons.save,
                  color: Colors.white,
                  size: 40,
                ),
                onPressed: () {
                  createPrescription();
                },
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 50, right: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            // write pres for user ....
            Container(
              child: Text(
                'Writing Prescription for ' + widget.userName+"kharraz",
                style: TextStyle(
                    fontFamily: 'salsa',
                    fontSize: 28,
                    fontWeight: FontWeight.bold),
              ),
            ),

            //Diagnosis
            Container(
              padding: EdgeInsets.only(top: 20, left: 10),
              child: Text(
                "Diagnosis: ",
                style: TextStyle(
                  color: Color.fromARGB(255, 111, 110, 110),
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Salsa',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20, bottom: 30),
              child: TextField(
                controller: diagnosisController,
                style: TextStyle(fontSize: 30, fontFamily: 'Salsa'),
                decoration: InputDecoration(
                  hintText: "Enter the patient's diagnosis",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
            ),

            //select the date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //select start date
                Column(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF0561DD),
                        fixedSize: Size(200, 60),
                      ).copyWith(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                            side: BorderSide(
                                color: Color(0xFF0561DD), width: 2.0),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        DateTime? newDate = await showDatePicker(
                          context: context,
                          initialDate: selectedStartDate,
                          firstDate: DateTime(2023),
                          lastDate: DateTime(2024),
                          builder: (BuildContext context, Widget? child) {
                            return Theme(
                              data: ThemeData.light().copyWith(
                                textTheme: TextTheme(
                                  caption: TextStyle(fontSize: 24),
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );
                        if (newDate == null) return;
                        setState(() => selectedStartDate = newDate);
                      },
                      child: Text(
                        "Select Start Date",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Salsa',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      '${selectedStartDate.day}/${selectedStartDate.month}/${selectedStartDate.year}',
                      style: TextStyle(
                        color: Color(0xFF0561DD),
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Salsa',
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  width: 40,
                ),

                //select end date
                Column(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF0561DD),
                        fixedSize: Size(200, 60),
                      ).copyWith(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                            side: BorderSide(
                                color: Color(0xFF0561DD), width: 2.0),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        DateTime? newDate = await showDatePicker(
                          context: context,
                          initialDate: selectedEndDate,
                          firstDate: DateTime(2023),
                          lastDate: DateTime(2024),
                          builder: (BuildContext context, Widget? child) {
                            return Theme(
                              data: ThemeData.light().copyWith(
                                textTheme: TextTheme(
                                  caption: TextStyle(fontSize: 24),
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );
                        if (newDate == null) return;
                        setState(() => selectedEndDate = newDate);
                      },
                      child: Text(
                        "Select End Date",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Salsa',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      '${selectedEndDate.day}/${selectedEndDate.month}/${selectedEndDate.year}',
                      style: TextStyle(
                        color: Color(0xFF0561DD),
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Salsa',
                      ),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(
              height: 30,
            ),

            // number of mid
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Enter Number of Medicine',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),

                prefixIcon: Icon(Icons.medication), // Add the medicine icon
              ),
              keyboardType: TextInputType.number,
              style: TextStyle(fontSize: 25), // Set the font size
              onChanged: (value) {
                setState(() {
                  // Update the number of combinations based on user input
                  numberOfMid = int.tryParse(value) ?? 0;
                });
              },
            ),

            SizedBox(
              height: 25,
            ),

            // Display the generated combination widgets
            Expanded(
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: combinationWidgets,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
