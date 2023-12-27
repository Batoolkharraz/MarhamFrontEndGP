import 'package:flutter/material.dart';
import 'package:flutter_application_4/payment/wallet/sales.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class coinspage extends StatefulWidget {
  const coinspage({super.key});

  @override
  State<coinspage> createState() => _coinspageState();
}

class _coinspageState extends State<coinspage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
    appBar: AppBar(   toolbarHeight: 90,
        backgroundColor: const Color(0xFF0561DD),
        elevation: 1,
        title: Center(
          child: Row(
            children: [
              SizedBox(width: 160),
              Text(
                "Electroic Wallet",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  // fontFamily: 'Salsa',
                ),
              ),
              SizedBox(width: 100),
             
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
      
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Column(
            children: [
            
              
              Container(
                height: 200,
                width: 600,
                decoration: BoxDecoration(
                    color: Color.fromARGB(222, 6, 100, 222),
                    border: Border.all(
                      color: Colors.grey, // Set the color of the border
                      width: 2.0, // Set the width of the border
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    )),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                      child: Container(
                        width: 450,
                        child: Row(
                          children: [
                            Text(
                              "Your Collected coins",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 27,
                                fontFamily: 'salsa',
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            const FaIcon(
                              FontAwesomeIcons.coins,
                              color: Colors.white,
                              size: 30.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Container(
                        width: 420,
                        child: Text(
                          "200",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontFamily: 'salsa',
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 450,
                      child: Text(
                        "Each time you book you get free coins",
                        style: TextStyle(
                          color: const Color.fromARGB(255, 196, 195, 195),
                          fontSize: 20,
                          fontFamily: 'salsa',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 40, left: 10, right: 20),
                  child: Column(children: [
                    Container(
                      width: 600,
                      child: Text("Coins Shopping",
                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 30,
                                          fontFamily: 'salsa',
                                                                      ),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:40),
                      child: Container(
                        
                      height: 500, // Set a specific height or adjust as needed
                      child: ListView(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                       children: [
                        coinssales(context),
                        coins2(context),
                        coins3(context),
                        coins4(context),
                       ],
                      ),
                    ),
                    )
,
                  ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
