import 'package:flutter/material.dart';
import 'package:flutter_application_4/payment/card.dart';
import 'package:flutter_paypal_checkout/flutter_paypal_checkout.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void showpaymentalertt(BuildContext context,String book,String doc) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
          return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        
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
                    SizedBox(
                      width: 20,
                    ),
                    const Text(
                      "Visa Card",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 28,
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
                                builder: (context) =>SecondScreen(
                                  bookId: book,
                                  docId:doc)),
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
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Electronic wallet",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 28,
                        fontFamily: 'Salsa',
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    InkWell(
                        child: const Icon(
                          FontAwesomeIcons.angleRight,
                          size: 30.0,
                        ),
                        onTap: () async {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => PaypalCheckout(
                sandboxMode: true,
                clientId: "AZ86RqEBr0WWmJ3BxerCjf8uvKAraHbL9eaR6G8KqjPYnQR4ZFYVXLDMEPHny2KPWgw1qq8fpS2pOCHA",
                secretKey: "EJ85V6XMLZcNxef_6ydNeEklpHcKp5UVFCC_TgivllICQBTZitXgyLJ6bfJm5UTcw7-DWx7iG1H86Z1T",
                returnURL: "success.snippetcoder.com",
                cancelURL: "cancel.snippetcoder.com",
                transactions: const [
                  {
                    "amount": {
                      "total": '70',
                      "currency": "USD",
                      "details": {
                        "subtotal": '70',
                        "shipping": '0',
                        "shipping_discount": 0
                      }
                    },
                    "description": "The payment transaction description.",
                    // "payment_options": {
                    //   "allowed_payment_method":
                    //       "INSTANT_FUNDING_SOURCE"
                    // },
                    "item_list": {
                      "items": [
                        {
                          "name": "Apple",
                          "quantity": 4,
                          "price": '5',
                          "currency": "USD"
                        },
                        {
                          "name": "Pineapple",
                          "quantity": 5,
                          "price": '10',
                          "currency": "USD"
                        }
                      ],

                      // shipping address is not required though
                      //   "shipping_address": {
                      //     "recipient_name": "Raman Singh",
                      //     "line1": "Delhi",
                      //     "line2": "",
                      //     "city": "Delhi",
                      //     "country_code": "IN",
                      //     "postal_code": "11001",
                      //     "phone": "+00000000",
                      //     "state": "Texas"
                      //  },
                    }
                  }
                ],
                note: "Contact us for any questions on your order.",
                onSuccess: (Map params) async {
                  print("onSuccess: $params");
                },
                onError: (error) {
                  print("onError: $error");
                  Navigator.pop(context);
                },
                onCancel: () {
                  print('cancelled:');
                },
              ),
            ));
                        }
      
                          
                        )
                  ],
                ),
              )
            ],
          )),
        ));
      });
}
