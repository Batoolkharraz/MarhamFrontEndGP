import 'package:flutter/material.dart';
import 'package:flutter_application_4/doctorSide/dailyapp.dart';
import 'package:flutter_application_4/doctorSide/patientRecord.dart';
import 'package:flutter_application_4/doctorSide/updateyours.dart';
import 'package:flutter_application_4/doctorSide/working.dart';
import 'dart:typed_data';
import 'package:flutter_application_4/doctorSide/writePrescription.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_application_4/Auth/updateinformation/uploadimage.dart';

class doctorHome extends StatefulWidget {
  const doctorHome({super.key});

  @override
  State<doctorHome> createState() => _doctorHomeState();
}

class _doctorHomeState extends State<doctorHome> {
  Uint8List? image;
  final GlobalKey<FormState> signstate = GlobalKey<FormState>();
  void selectImage() async {
    XFile? file = await fileImage(ImageSource.gallery);
    Uint8List img = await pickImage(ImageSource.gallery);
    updateUserInformation(file);
    setState(() {
      image = img;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 231, 233, 237),
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
                      builder: (context) => const EditDoctor(),
                    ),
                  );
                },
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            child: Column(children: [
              SizedBox(
                width: 600,
                height: 200,
                child: Stack(
                  children: [
                    image != null
                        ? Padding(
                            padding: const EdgeInsets.only(
                              top: 50,
                            ),
                            child: Container(
                              width:
                                  180, // Width and height to accommodate the border

                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: const Color(0xFF0561DD), // Blue border color
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
                              child: CircleAvatar(
                                radius: 90,
                                backgroundImage: MemoryImage(image!),
                              ),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(left: 190),
                            child: Container(
                              width:
                                  180, // Width and height to accommodate the border
                              height: 180,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.blue, // Blue border color
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
                              child: const CircleAvatar(
                                radius: 90,
                                backgroundImage:
                                    AssetImage("assets/5bbc3519d674c.jpg"),
                              ),
                            ),
                          ),
                  ],
                ),
              ),

              const Text(
                "Dr Name family",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Salsa',
                ),
              ),
              Text(
                "email address",
                style: TextStyle(
                  fontSize: 23,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Salsa',
                ),
              ),
              const SizedBox(height: 40.0),

              //check patient record

              Container(
                padding: const EdgeInsets.only(top: 50, left: 30, right: 30),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50.0),
                      topRight: Radius.circular(50.0),
                    )),
                height: 800,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const Workingdoctor(),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            width: 2,
                            color: const Color(0xFF0561DD),
                          ),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey, // Shadow color
                              offset: Offset(0, 0), // Offset of the shadow
                              blurRadius: 15, // Spread of the shadow
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 150,
                              child: Image.asset('assets/calendar.png'),
                            ),
                            const Text(
                              'Make Your Schedule',
                              style: TextStyle(
                                color: Color(0xFF0561DD),
                                fontSize: 27,
                                fontFamily: 'salsa',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    const SizedBox(
                      height: 30,
                    ),

                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const patientRecord(),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            width: 2,
                            color: const Color(0xFF0561DD),
                          ),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey, // Shadow color
                              offset: Offset(0, 0), // Offset of the shadow
                              blurRadius: 15, // Spread of the shadow
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 150,
                              child: Image.asset('assets/patient_icon.png'),
                            ),
                            const Text(
                              'Check patient record',
                              style: TextStyle(
                                color: Color(0xFF0561DD),
                                fontSize: 27,
                                fontFamily: 'salsa',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 30,
                    ),

                    //write prescription
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const writePrescription(),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            width: 2,
                            color: const Color(0xFF0561DD),
                          ),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey, // Shadow color
                              offset: Offset(0, 0), // Offset of the shadow
                              blurRadius: 15, // Spread of the shadow
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10),
                              child: SizedBox(
                                width: 150,
                                child: Image.asset('assets/prescription.png'),
                              ),
                            ),
                            const Text(
                              'Write Prescription',
                              style: TextStyle(
                                color: Color(0xFF0561DD),
                                fontSize: 27,
                                fontFamily: 'salsa',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    InkWell
                    (onTap: () => {

                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const AppointmentPage(),
                          ),
                        )
                      
                    }
                      ,child:
                      Container(
                    
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          width: 2,
                          color: const Color(0xFF0561DD),
                        ),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey, // Shadow color
                            offset: Offset(0, 0), // Offset of the shadow
                            blurRadius: 15, // Spread of the shadow
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: SizedBox(
                              width: 150,
                              child: Image.asset('assets/image (18).png'),
                            ),
                          ),
                          const Text(
                            'Daily Appointment',
                            style: TextStyle(
                              color: Color(0xFF0561DD),
                              fontSize: 27,
                              fontFamily: 'salsa',
                            ),
                          ),
                        ],
                      ),
                    ),)
                  ],
                ),
              )
            ]),
          ),
        ));
  }
}
