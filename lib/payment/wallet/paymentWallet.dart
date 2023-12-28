import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_4/payment/card.dart';
import 'package:flutter_application_4/payment/wallet/cardWallet.dart';
import 'package:flutter_paypal_checkout/flutter_paypal_checkout.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;

final storage = const FlutterSecureStorage();
String point = '';
int p = 0;
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

void buyPoint(String price) async {
  String id = await getTokenFromStorage();
  final pay = {"price": price};
  final response = await http.post(
    Uri.parse('https://marham-backend.onrender.com/payment/buyPoints/$id/123'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(pay),
  );
  if (response.statusCode == 201 || response.statusCode == 200) {
  } else {}
}

void showpaymentalertWallet(BuildContext buildContext, String price) {
  showDialog(
      context: buildContext,
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
                  Padding(
                    padding: const EdgeInsets.only(left: 100.0),
                    child: Row(
                      children: [
                        const FaIcon(
                          FontAwesomeIcons.moneyBill,
                          color: Colors.blue,
                          size: 40.0,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Container(
                          child: Text(
                            "price: " + price,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 35,
                              fontFamily: 'Salsa',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
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
                        Image.asset("assets/visa_196578.png"),
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
                                  builder: (context) =>
                                      SecondScreenWallet(price: price)),
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
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Image.asset("assets/paypal_174861.png"),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "PayPal",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 28,
                            fontFamily: 'Salsa',
                          ),
                        ),
                        const SizedBox(
                          width: 140,
                        ),
                        InkWell(
                            child: const Icon(
                              FontAwesomeIcons.angleRight,
                              size: 30.0,
                            ),
                            onTap: () async {
                              String p = price;
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    PaypalCheckout(
                                  sandboxMode: true,
                                  clientId:
                                      "AZ86RqEBr0WWmJ3BxerCjf8uvKAraHbL9eaR6G8KqjPYnQR4ZFYVXLDMEPHny2KPWgw1qq8fpS2pOCHA",
                                  secretKey:
                                      "EJ85V6XMLZcNxef_6ydNeEklpHcKp5UVFCC_TgivllICQBTZitXgyLJ6bfJm5UTcw7-DWx7iG1H86Z1T",
                                  returnURL: "success.snippetcoder.com",
                                  cancelURL: "cancel.snippetcoder.com",
                                  transactions: [
                                    {
                                      "amount": {
                                        "total": p,
                                        "currency": "USD",
                                        "details": {
                                          "subtotal": p,
                                          "shipping": '0',
                                          "shipping_discount": 0
                                        }
                                      },
                                      "description":
                                          "The payment transaction description.",
                                      // "payment_options": {
                                      //   "allowed_payment_method":
                                      //       "INSTANT_FUNDING_SOURCE"
                                      // },
                                      "item_list": {
                                        "items": [
                                          {
                                            "name": "Points Price",
                                            "quantity": 1,
                                            "price": p,
                                            "currency": "USD"
                                          },
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
                                  note:
                                      "Contact us for any questions on your order.",
                                  onSuccess: (Map params) async {
                                    print("onSuccess: $params");
                                    buyPoint(price);
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
                            })
                      ],
                    ),
                  )
                ],
              )),
            ));
      });
}
