import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_4/doctorSide/doctorHome.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;

class medicine_info {
  String medicine = '';
  String description = '';
  List<String> time = [];

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

class MedicineDetails {
  String name = '';
  String description = '';
  bool morning = false;
  bool noon = false;
  bool night = false;

  MedicineDetails({
    required this.name,
    required this.description,
    required this.morning,
    required this.noon,
    required this.night,
  });
}

class writePrescription extends StatefulWidget {
  final String userId;
  final String userName;
  final String userEmail;

  const writePrescription(
      {super.key, required this.userId, required this.userName, required this.userEmail});

  @override
  _writePrescriptionState createState() => _writePrescriptionState();
}

class _writePrescriptionState extends State<writePrescription> {
  List<medicine_info> medicineList = [];
  final diagnosisController = TextEditingController();
  final emailController = TextEditingController();
  final medNmaeController = TextEditingController();
  final medDesController = TextEditingController();
  final storage = const FlutterSecureStorage();
  String userId = '';
  List<String> selectedTimes = [];
  int numberOfMid = 1;
  DateTime selectedStartDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();

  bool morning = false;
  bool noon = false;
  bool night = false;

  Future<TimeOfDay?> pickTime() => showTimePicker(
      context: context, initialTime: const TimeOfDay(hour: 12, minute: 00));

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

  void createPrescription() async {
    String id = await getTokenFromStorage();
    final startDate =
        '${selectedStartDate.year}-${selectedStartDate.month}-${selectedStartDate.day}';
    final endDate =
        '${selectedEndDate.year}-${selectedEndDate.month}-${selectedEndDate.day}';
    final diagnosis = diagnosisController.text;

    // Convert medicine_info objects to maps using toMap()
    List<Map<String, dynamic>> medList =
        medicineList.map((medicine) => medicine.toMap()).toList();

    if (selectedEndDate.isBefore(selectedStartDate)) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text(
                'End date cannot be before the start date. Please check the dates again.'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      final prescription = {
        "email": widget.userEmail,
        "diagnosis": diagnosis,
        "dateFrom": startDate,
        "dateTo": endDate,
        "medicines": medList,
      };

      final response = await http.post(
        Uri.parse('https://marham-backend.onrender.com/prescription/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(prescription),
      );

      if (response.statusCode == 201) {
        // Show a success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
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
          const SnackBar(
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
      int index, String name, String description, List<String> time) {
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
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color.fromARGB(255, 111, 110, 110),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 10),
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
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: medNmaeController,
                    decoration: InputDecoration(
                      labelText: 'Name of Medicine',
                      labelStyle: const TextStyle(fontSize: 25, fontFamily: 'Salsa'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: medDesController,
                    decoration: InputDecoration(
                      labelText: 'Description (2 Pills after eat)',
                      labelStyle: const TextStyle(fontSize: 25, fontFamily: 'Salsa'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Column(
                    children: [
                      CheckboxListTile(
                        title: const Text('Morning'),
                        value: morning,
                        onChanged: (bool? value) {
                          setState(() {
                            morning = value ?? false;
                            if (value!) {
                              selectedTimes.add('morning');
                            } else {
                              selectedTimes.remove('morning');
                            }
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: const Text('Noon'),
                        value: noon,
                        onChanged: (bool? value) {
                          setState(() {
                            noon = value ?? false;
                            if (value!) {
                              selectedTimes.add('noon');
                            } else {
                              selectedTimes.remove('noon');
                            }
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: const Text('Night'),
                        value: night,
                        onChanged: (bool? value) {
                          setState(() {
                            night = value ?? false;
                            if (value!) {
                              selectedTimes.add('night');
                            } else {
                              selectedTimes.remove('night');
                            }
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        String name = medNmaeController.text;
                        String description = medDesController.text;
                        saveMedicineDetails(
                            index, name, description, selectedTimes);

                        // Clear the input fields or update the UI as needed
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0561DD),
                      ),
                      child: const Text(
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
            const SizedBox(
              height: 20,
            ),
          ],
        );
      },
    );
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 90,
          backgroundColor: const Color(0xFF0561DD),
          elevation: 0,
          centerTitle: true,
          title: const Text(
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
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 25,
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const doctorHome(),
                  ),
                );
              },
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 25, top: 5),
              child: IconButton(
                icon: const Icon(
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
            const SizedBox(
              height: 30,
            ),
            // write pres for user ....
            Container(
              child: Text(
                'Writing Prescription for ${widget.userName}',
                style: const TextStyle(
                    fontFamily: 'salsa',
                    fontSize: 28,
                    fontWeight: FontWeight.bold),
              ),
            ),

            //Diagnosis
            Container(
              padding: const EdgeInsets.only(top: 20, left: 10),
              child: const Text(
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
              padding: const EdgeInsets.only(top: 20, bottom: 30),
              child: TextField(
                controller: diagnosisController,
                style: const TextStyle(fontSize: 30, fontFamily: 'Salsa'),
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
                        backgroundColor: const Color(0xFF0561DD),
                        fixedSize: const Size(200, 60),
                      ).copyWith(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                            side: const BorderSide(
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
                                textTheme: const TextTheme(
                                  bodySmall: TextStyle(fontSize: 24),
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );
                        if (newDate == null) return;
                        setState(() => selectedStartDate = newDate);
                      },
                      child: const Text(
                        "Select Start Date",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Salsa',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      '${selectedStartDate.day}/${selectedStartDate.month}/${selectedStartDate.year}',
                      style: const TextStyle(
                        color: Color(0xFF0561DD),
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Salsa',
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  width: 40,
                ),

                //select end date
                Column(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0561DD),
                        fixedSize: const Size(200, 60),
                      ).copyWith(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                            side: const BorderSide(
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
                                textTheme: const TextTheme(
                                  bodySmall: TextStyle(fontSize: 24),
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );
                        if (newDate == null) return;
                        setState(() => selectedEndDate = newDate);
                      },
                      child: const Text(
                        "Select End Date",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Salsa',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      '${selectedEndDate.day}/${selectedEndDate.month}/${selectedEndDate.year}',
                      style: const TextStyle(
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

            const SizedBox(
              height: 30,
            ),

            // number of mid
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Enter Number of Medicine',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),

                prefixIcon: const Icon(Icons.medication), // Add the medicine icon
              ),
              keyboardType: TextInputType.number,
              style: const TextStyle(fontSize: 25), // Set the font size
              onChanged: (value) {
                setState(() {
                  // Update the number of combinations based on user input
                  numberOfMid = int.tryParse(value) ?? 0;
                });
              },
            ),

            const SizedBox(
              height: 25,
            ),

            // Display the generated combination widgets
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: combinationWidgets,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
