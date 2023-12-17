import 'package:flutter/material.dart';
import 'package:flutter_application_4/payment/card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void showalertt(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            content: SizedBox(
          width: 400, // Set the width as desired
          height: 400, // Set the height as desired
          child: Center(
              child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              const SizedBox(
                width: 400,
                height: 40,
                child: Text(
                  "Payment Mode",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontFamily: 'Salsa',
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: 400,
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey, // Set border color to gray
                    width: 2.0, // Set border width
                  ),
                  // color: Colors.blue,
                  borderRadius:
                      BorderRadius.circular(20), // Set circular radius
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Image.asset("assets/credit-card_8336730.png"),
                    const SizedBox(
                      width: 20,
                    ),
                    const Text(
                      "Visa Card",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 27,
                        fontFamily: 'Salsa',
                      ),
                    ),
                    const SizedBox(
                      width: 100,
                    ),
                    InkWell(
                      child: const Icon(
                        FontAwesomeIcons.angleRight,
                        size: 30.0,
                      ),
                      onTap: () {
                       Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SecondScreen()),
                          );
                      },
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: 400,
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey, // Set border color to gray
                    width: 2.0, // Set border width
                  ),

                  borderRadius:
                      BorderRadius.circular(20), // Set circular radius
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Image.asset("assets/payment-method_7368522.png"),
                    const SizedBox(
                      width: 20,
                    ),
                    const Text(
                      "Electronic wallet",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 27,
                        fontFamily: 'Salsa',
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    InkWell(
                        child: const Icon(
                          FontAwesomeIcons.angleRight,
                          size: 30.0,
                        ),
                        onTap: () {
                          
                        })
                  ],
                ),
              )
            ],
          )),
        ));
      });
}
