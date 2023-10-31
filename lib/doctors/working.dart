import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



class Workingdoctor extends StatefulWidget {
  const Workingdoctor({Key? key}) : super(key: key);

  @override
  _WorkingdoctorState createState() => _WorkingdoctorState();
}

class _WorkingdoctorState extends State<Workingdoctor> {
  DateTime dateTime = DateTime(2023, 10, 30, 8, 00);
  DateTime dateTime2 = DateTime(2023, 10, 30, 8, 00);
  Future<TimeOfDay?> pickTime() => showTimePicker(
      context: context, initialTime: TimeOfDay(hour: 12, minute: 00));
  Widget build(BuildContext context) {
    
    final starthour = dateTime.hour.toString().padLeft(2, '0');
    final startminutes = dateTime.minute.toString().padLeft(2, '0');
    return Scaffold( resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          height: 1200,
          color: Colors.blue,
          child: Column(
            children: [
              Container(
                  width: 500,
                  height: 400,
                  child: Image.asset("assets/Doctors-bro.png")),
              Container(
                
                  width: 600,
                  height: 800,
                  decoration: BoxDecoration(
                    
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 50),
                        width: 500,
                        child: Row(
                          children: [
                            FaIcon(FontAwesomeIcons.calendarDays,
                                color: Colors.blue, size: 30.0),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Make your schedule",
                              style: TextStyle(
                                color: Color.fromARGB(255, 111, 110, 110),
                                fontSize: 30,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Salsa',
                              ),
                            ),
                          ],
                        ),
                      ),
                     SizedBox(height: 40,),
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Container(
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    '${dateTime.year}/${dateTime.month}/${dateTime.day}',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 25,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Salsa',
                                    ),
                                  ),
                                  ElevatedButton(
                                    style:ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF0561DD),
    fixedSize: Size(200, 60),
  ).copyWith(
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100),
        side: BorderSide(color: Color(0xFF0561DD), width: 2.0),
      ),
    ),
  ),
                                      onPressed: () async {
                                        DateTime? newDate =
                                            await showDatePicker(
                                          context: context,
                                          initialDate: dateTime,
                                          firstDate: DateTime(2023),
                                          lastDate: DateTime(2024),
                                          builder: (BuildContext context,
                                              Widget? child) {
                                            return Theme(
                                              data: ThemeData.light().copyWith(
                                                textTheme: TextTheme(
                                                  caption: TextStyle(
                                                      fontSize:
                                                          24), // Adjust the font size
                                                ),
                                              ),
                                              child: child!,
                                            );
                                          },
                                        );
                                        if (newDate == null) return;
                                        setState(() => dateTime = newDate);
                                      },
                                      child: Text(
                                        "Select Date",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Salsa',
                                        ),
                                      )),
                                ],
                              ),
                              SizedBox(
                                width: 70,
                              ),
                             
                                Column(
                                  children: [
                                    
                                    ElevatedButton(
                                    
                                       style:ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF0561DD),
    fixedSize: Size(200, 60),
  ).copyWith(
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100),
        side: BorderSide(color: Color(0xFF0561DD), width: 2.0),
      ),
    ),
  ),
                                      onPressed: () async {
                                        final time = await pickTime();
                                        if (time == null) return;
                                        final newDate = DateTime(
                                          dateTime.year,
                                          dateTime.month,
                                          dateTime.day,
                                          time.hour,
                                          time.minute,
                                        );
                                        setState(() => dateTime = newDate);
                                        print(dateTime);
                                      },
                                      child: Text(
                                        "Start Time",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Salsa',
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10,),
                                    ElevatedButton(
                                       style:ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF0561DD),
    fixedSize: Size(200, 60),
  ).copyWith(
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100),
        side: BorderSide(color: Color(0xFF0561DD), width: 2.0),
      ),
    ),
  ),
                                        onPressed: () async {
                                          final time2 = await pickTime();
                                          if (time2 == null) return;
                                          final newDate = DateTime(
                                              dateTime2.year,
                                              dateTime2.month,
                                              dateTime2.day,
                                              time2.hour,
                                              time2.minute);
                                          setState(() => dateTime2 = newDate);
                                          print(dateTime2);
                                        },
                                        child: Text(
                                          " End  Time ",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 25,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Salsa',
                                          ),
                                        )),
                                  ],
                                ),
                              
                            ],
                          ),
                        ),
                      ),
                       Row(
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                                "Duration of Each appointment",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 111, 110, 110),
                                  fontSize: 30,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Salsa',
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 70, left: 10),
                              width: 80,
                              height: 200,
                              child: TextField(
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 30),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        20.0), // Adjust the border radius as needed
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      SizedBox(height: 10,),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF0561DD),
    fixedSize: Size(500, 60),
  ).copyWith(
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100),
        side: BorderSide(color: Color(0xFF0561DD), width: 2.0),
      ),
    ),
  ),
                                       
                          onPressed: (){

                  }, child:Text("Save",
                   style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Salsa',
                                ),))
                      
                    ],
                    
                  )
                  ),
                 
            ],
          ),
        ),
      ),
    );
  }
}


