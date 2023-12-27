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

class SecondScreen extends StatefulWidget {
  final String bookId;
  final String docId;
  final String price;

  const SecondScreen(
      {super.key,
      required this.bookId,
      required this.docId,
      required this.price});
  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
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
  String discount = '';
  double d = 0;
  String finalP = '';
  double f = 0;
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

  void payment() async {
    String finalPrice = (p == 0 ? widget.price : finalP);
    print(finalPrice);
    String id = await getTokenFromStorage();
    final pay = {
      "payMethod": "card",
      "price": finalPrice,
    };
    final response = await http.post(
      Uri.parse(
          'https://marham-backend.onrender.com/payment/$id/${widget.bookId}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(pay),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      // Show a success message
      print('Data sent successfully');
      showDialog(
        context: context,
        builder: (context) => const CardAlertDialog(),
      );
      bookedApp();
    } else {
      // Handle the error when the HTTP request fails
      print('Error in sending data');
      showDialog(
        context: context,
        builder: (context) => const CardNotAlertDialog(),
      );
    }
  }

  void bookedApp() async {
    String id = await getTokenFromStorage();
    final response = await http.post(
      Uri.parse(
          'https://marham-backend.onrender.com/schedule/$id/${widget.bookId}/${widget.docId}'), // Replace with your server URL
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Color(0xFF0561DD),
            content: Center(
              child: Text(
                "your appointment has been booked!",
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
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Center(
              child: Text(
                "Something Went Wrong, Please try again!",
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
    }
  }

  Future getPrice() async {
    String id = await getTokenFromStorage();
    var url =
        "https://marham-backend.onrender.com/payment/points/$id/${widget.bookId}";

    try {
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var responseBody = response.body.toString();
        responseBody = responseBody.trim();
        var app = jsonDecode(responseBody);

        print(response.body);
        print(app);
        if (app != null && app is Map<String, dynamic>) {
          setState(() {
            p = app['point'];
            point = p.toString();
            calcPrice();
          });
        } else {
          print('Unexpected response structure: $app');
        }
      } else {
        print('Failed to fetch data. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error during network request: $error');
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

  String calcPrice() {
    int Number = int.parse(widget.price);
    d = (((p / 100) * Number) / 100);
    f = Number - (((p / 100) * Number) / 100);
    print(d);
    discount = d.toString();
    finalP = f.toString();
    return discount;
  }

  @override
  void initState() {
    super.initState();
    getPrice();
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
                padding:
                    const EdgeInsets.only( right: 40.0, left: 40),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "your final step for booing! ",
                        style: TextStyle(
                            fontFamily: 'salsa',
                            fontSize: 35,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        
                    crossAxisAlignment: CrossAxisAlignment.spaceBetween,
                        children: [
                      Text(
                        "Appointment price: ",
                        style: TextStyle(
                            fontFamily: 'salsa',
                            fontSize: 35,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                         widget.price,
                        style: TextStyle(
                            fontFamily: 'salsa',
                            fontSize: 35,
                            fontWeight: FontWeight.bold),
                      ),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          Text(
                            "your Points: ",
                            style: TextStyle(
                                fontFamily: 'salsa',
                                fontSize: 35,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            (point.isEmpty ? "0" : point),
                            style: TextStyle(
                                fontFamily: 'salsa',
                                fontSize: 35,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        
                        children: [
                      Text(
                        "Discount: ",
                        style: TextStyle(
                            fontFamily: 'salsa',
                            fontSize: 35,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                         (point.isEmpty ? "0" : discount),
                        style: TextStyle(
                            fontFamily: 'salsa',
                            fontSize: 35,
                            fontWeight: FontWeight.bold),
                      ),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Divider(
                        color:
                            Colors.grey, // You can change the color of the line
                        thickness:
                            2, // You can adjust the thickness of the line
                      ),
                      Row(
                        
                        children: [
                      Text(
                            (point.isEmpty ? widget.price : finalP),
                        style: TextStyle(
                            fontFamily: 'salsa',
                            fontSize: 35,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Final price: ",
                        style: TextStyle(
                            fontFamily: 'salsa',
                            fontSize: 35,
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
                                payment();
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
