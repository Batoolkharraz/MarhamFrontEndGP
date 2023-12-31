import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_4/payment/components/card_alert_dialog.dart';
import 'package:flutter_application_4/payment/components/card_input_formatter.dart';
import 'package:flutter_application_4/payment/components/card_month_input_formatter.dart';
import 'package:flutter_application_4/payment/components/notvalid.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class SecondScreenWallet extends StatefulWidget {
  final String price;

  const SecondScreenWallet({super.key, required this.price});
  @override
  State<SecondScreenWallet> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreenWallet> {
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController cardHolderNameController =
      TextEditingController();
  final TextEditingController cardExpiryDateController =
      TextEditingController();
  final TextEditingController cardCvvController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
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
void buyPoint() async {
  String id = await getTokenFromStorage();
  final pay = {"price": widget.price};
  final response = await http.post(
    Uri.parse('https://marham-backend.onrender.com/payment/buyPoints/$id/123'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(pay),
  );
  if (response.statusCode == 201 || response.statusCode == 200) {
    // Show a success message
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Center(
            child: Text(
              "congrats, your coins are in your wallet now!",
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
    }
  } else {
    // Handle the error when the HTTP request fails
    showDialog(
      context: context,
      builder: (context) => const CardNotAlertDialog(),
    );
  }
}

  bool isDateExpired(String date) {
    // Split the date string into month and year parts
    if (date.isEmpty) {
      return true;
    }
    List<String> parts = date.split('/');

    // Extract month and year as integers
    int month = int.tryParse(parts[0]) ?? 0;

    // Extract year as integers, considering the year as 2000 + the parsed value
    int year = int.tryParse(parts[1]) ?? 0;
    year = (year < 100) ? 2000 + year : year;

    // Get the current date
    DateTime currentDate = DateTime.now();

    // Check if the year is in the past or if the year is the current year and the month is in the past
    return year < currentDate.year ||
        (year == currentDate.year && month < currentDate.month);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80.0),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            toolbarHeight: 90,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.grey, // Set the color to grey
                size: 30,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.only(right: 40.0, left: 40),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "your final step to buy more coin! ",
                        style: TextStyle(
                            fontFamily: 'salsa',
                            fontSize: 35,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Final price: ",
                            style: TextStyle(
                                fontFamily: 'salsa',
                                fontSize: 28,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            (widget.price),
                            style: TextStyle(
                                fontFamily: 'salsa',
                                fontSize: 28,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ]),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              width: 530.0,
              height: 600.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: Colors.grey, // Set border color to gray
                  width: 2.0, // Set border width
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: SizedBox(
                        width: 500,
                        child: Text(
                          'Card Detalis',
                          style: TextStyle(
                            fontSize: 30,
                            fontFamily: 'salsa',
                            color: Color(0xFF0561DD),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: 475,
                      child: Column(
                        children: [
                          Container(
                            height: 75,
                            width: MediaQuery.of(context).size.width / 1.12,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: TextFormField(
                              style: const TextStyle(fontSize: 28),
                              controller: cardNumberController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 20),
                                hintText: 'Card Number',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 26,
                                ),
                                prefixIcon: Icon(
                                  Icons.credit_card,
                                  color: Colors.grey,
                                  size: 35,
                                ),
                              ),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(16),
                                CardInputFormatter(),
                              ],
                              onChanged: (value) {
                                var text = value.replaceAll(
                                    RegExp(r'\s+\b|\b\s'), ' ');
                                setState(() {
                                  cardNumberController.value =
                                      cardNumberController.value.copyWith(
                                          text: text,
                                          selection: TextSelection.collapsed(
                                              offset: text.length),
                                          composing: TextRange.empty);
                                });
                              },
                            ),
                          ),
                          const SizedBox(height: 12),
                          Container(
                            height: 75,
                            width: MediaQuery.of(context).size.width / 1.12,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: TextFormField(
                              style: const TextStyle(fontSize: 28),
                              controller: cardHolderNameController,
                              keyboardType: TextInputType.name,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 15),
                                hintText: 'Full Name',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 25,
                                ),
                                prefixIcon: Icon(Icons.person,
                                    color: Colors.grey, size: 35),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  cardHolderNameController.value =
                                      cardHolderNameController.value.copyWith(
                                          text: value,
                                          selection: TextSelection.collapsed(
                                              offset: value.length),
                                          composing: TextRange.empty);
                                });
                              },
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 75,
                                width: MediaQuery.of(context).size.width / 2.4,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: TextFormField(
                                  style: const TextStyle(fontSize: 28),
                                  controller: cardExpiryDateController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 15),
                                    hintText: 'MM/YY',
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 25,
                                    ),
                                    prefixIcon: Icon(Icons.calendar_today,
                                        color: Colors.grey, size: 35),
                                  ),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(4),
                                    CardDateInputFormatter(),
                                  ],
                                  onChanged: (value) {
                                    var text = value.replaceAll(
                                        RegExp(r'\s+\b|\b\s'), ' ');
                                    setState(() {
                                      cardExpiryDateController.value =
                                          cardExpiryDateController.value
                                              .copyWith(
                                                  text: text,
                                                  selection:
                                                      TextSelection.collapsed(
                                                          offset: text.length),
                                                  composing: TextRange.empty);
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(width: 14),
                              Container(
                                height: 75,
                                width: MediaQuery.of(context).size.width / 2.4,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: TextFormField(
                                  style: const TextStyle(fontSize: 28),
                                  controller: cardCvvController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 15),
                                    hintText: 'CVV',
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 25,
                                    ),
                                    prefixIcon: Icon(Icons.lock,
                                        color: Colors.grey, size: 35),
                                  ),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(3),
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      int length = value.length;
                                      if (length == 4 ||
                                          length == 9 ||
                                          length == 14) {
                                        cardNumberController.text = '$value ';
                                        cardNumberController.selection =
                                            TextSelection.fromPosition(
                                                TextPosition(
                                                    offset: value.length + 1));
                                      }
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20 * 3),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: const Color(0xFF0561DD),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              minimumSize: Size(
                                  MediaQuery.of(context).size.width / 1.12, 55),
                            ),
                            onPressed: () {
                              /*  showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                },
                              );

                              if (_formKey.currentState?.validate() ?? false) {
                                Future.delayed(const Duration(seconds: 2), () {
                                  Navigator.of(context)
                                      .pop(); // Close the CircularProgressIndicator dialog

                                  showDialog(
                                    context: context,
                                    builder: (context) =>
                                        const CardAlertDialog(),
                                  );

                                  // Clear the controllers
                                  cardCvvController.clear();
                                  cardExpiryDateController.clear();
                                  cardHolderNameController.clear();
                                  cardNumberController.clear();
                                });
                              }
                              if (_formKey.currentState?.validate() ?? true) {
                                Future.delayed(const Duration(seconds: 2), () {
                                  Navigator.of(context)
                                      .pop(); // Close the CircularProgressIndicator dialog

                                  showDialog(
                                    context: context,
                                    builder: (context) =>
                                        const CardNotAlertDialog(),
                                  );

                                  // Clear the controllers
                                  cardCvvController.clear();
                                  cardExpiryDateController.clear();
                                  cardHolderNameController.clear();
                                  cardNumberController.clear();
                                });
                              }
*/

                              bool isExpired =
                                  isDateExpired(cardExpiryDateController.text);

                              if (cardNumberController.text.length != 19 ||
                                  cardCvvController.text.length != 3 ||
                                  isExpired ||
                                  cardNumberController.text.isEmpty ||
                                  cardCvvController.text.isEmpty ||
                                  cardExpiryDateController.text.isEmpty ||
                                  cardHolderNameController.text.isEmpty) {
                                showDialog(
                                  context: context,
                                  builder: (context) =>
                                      const CardNotAlertDialog(),
                                );
                              } else {
                                showDialog(
        context: context,
        builder: (context) => const CardAlertDialog(),
      );
                                buyPoint();
                              }
                            },
                            child: Text(
                              'Add Card'.toUpperCase(),
                              style: const TextStyle(
                                fontSize: 25,
                                fontFamily: 'salsa',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        )));
  }
}
