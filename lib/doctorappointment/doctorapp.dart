import 'package:flutter/material.dart';
import 'package:flutter_application_4/doctorappointment/workinghour.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class appointment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0561DD),
        leading: BackButton(
          onPressed: () => {Navigator.of(context).pop()},
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                width: 600,
                height: 230,
                color: Colors.white,
                child: Row(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: ClipOval(
                        child: Container(
                          width:
                              200.0, // Set the width of the circular container
                          height:
                              200.0, // Set the height of the circular container
                          color: Colors
                              .grey, // Background color for the circular container
                          child: Image.asset(
                            'assets/doctor2.jpg', // Replace with your image URL
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 60,
                      ),
                      child: Container(
                        width: 290,
                        height: 400,
                        child: Column(
                          children: [
                            Text("Dr .Name Family",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 35,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Salsa')),
                            Padding(
                              padding: const EdgeInsets.only(top: 20, left: 65),
                              child: Row(children: [
                                Container(
                                  width:
                                      50, // Adjust the width and height as needed to make it circular
                                  height: 50,
                                  decoration: BoxDecoration(
                                    shape: BoxShape
                                        .circle, // This makes the container circular
                                    color: Colors
                                        .blue, // You can change the background color
                                  ),
                                  child: Center(
                                    child:InkWell(
                                      child:  FaIcon(
                                      FontAwesomeIcons.commentMedical,
                                      size: 28.0,
                                      color: Colors.white,
                                    ),
                                    onTap: () => {
                                      print("message")
                                    },
                                    )
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  width:
                                      50, // Adjust the width and height as needed to make it circular
                                  height: 50,
                                  decoration: BoxDecoration(
                                    shape: BoxShape
                                        .circle, // This makes the container circular
                                    color: Colors
                                        .blue, // You can change the background color
                                  ),
                                  child: Center(
                                    child: InkWell(
                                      child: FaIcon(FontAwesomeIcons.video,
                                        color: Colors.white, size: 25.0),
                                        onTap:() => {
                                          print("video call")
                                        },
                                    )
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  width:
                                      50, // Adjust the width and height as needed to make it circular
                                  height: 50,
                                  decoration: BoxDecoration(
                                    shape: BoxShape
                                        .circle, // This makes the container circular
                                    color: Colors
                                        .blue, // You can change the background color
                                  ),
                                  child: Center(
                                    child: InkWell(child: 
                                    FaIcon(FontAwesomeIcons.phone,
                                        color: Colors.white, size: 25.0),
                                        onTap: ()=>{
                                          print("phone call")
                                        },)
                                  ),
                                ),
                              ]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
               child:
                     Column(
                        children: [
                          
                          Padding(
                            padding: const EdgeInsets.only(left: 20,
                            bottom: 15,
                            top: 15),
                            child: Container(
                              width: 600,
                              child: Text("Availability",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 30,
                                       fontWeight: FontWeight.bold
                                      // fontFamily: 'Salsa',
                                      )),
                            ),
                          ),
                          Container(
                           padding: EdgeInsets.only(top:5),
                            width: 510,
                            height: 50,
                            decoration: BoxDecoration(
                              
                              borderRadius: BorderRadius.circular(10.0),
                                color: Colors.blue,
                              border: Border.all(
                                color: Colors.grey, // Set the border color here
                                width: 2.0, // Set the border width
                              ),
                            ),
                            child: Text("Clinc Floor and Number",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold
                                      // fontFamily: 'Salsa',
                                      
                                      )),
                          )
                        ],
                      ),
                    
                  
        
              ),
              Container(
                width: 600,
                height: 900,
                child: ListView.builder(
                  itemBuilder: (context, int i) {
                    return working();
                  },
                  itemCount: 7,
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(8),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
