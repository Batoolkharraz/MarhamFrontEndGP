import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_4/payment/components/card_alert_dialog.dart';
import 'package:flutter_application_4/payment/components/card_input_formatter.dart';
import 'package:flutter_application_4/payment/components/card_month_input_formatter.dart';
class SecondScreen extends StatefulWidget {
  const SecondScreen({Key? key}) : super(key: key);

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      body:SingleChildScrollView( 
        child:
     Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 230),
        child: Container(
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
            padding: const EdgeInsets.only(top:30),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    width: 500,
                    child: Text(
                      'Card Detalis',
                      style: TextStyle(
                        fontSize: 30,
                        fontFamily: 'salsa',
                        color:  const Color(0xFF0561DD),
                        ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 40),
                Container(
                  width: 475,
                  child: Column(children: [
                    Container(
                    height: 75,
                    width: MediaQuery.of(context).size.width / 1.12,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextFormField(
                      style: TextStyle(
                        fontSize: 28
                      ),
                      controller: cardNumberController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                        var text = value.replaceAll(RegExp(r'\s+\b|\b\s'), ' ');
                        setState(() {
                          cardNumberController.value = cardNumberController.value
                              .copyWith(
                                  text: text,
                                  selection:
                                      TextSelection.collapsed(offset: text.length),
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
                       style: TextStyle(
                        fontSize: 28
                      ),
                      controller: cardHolderNameController,
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        hintText: 'Full Name',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 25,
                        ),
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.grey,
                          size:35
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          cardHolderNameController.value =
                              cardHolderNameController.value.copyWith(
                                  text: value,
                                  selection:
                                      TextSelection.collapsed(offset: value.length),
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
                           style: TextStyle(
                        fontSize: 28
                      ),
                          controller: cardExpiryDateController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                            hintText: 'MM/YY',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 25,
                            ),
                            prefixIcon: Icon(
                              Icons.calendar_today,
                              color: Colors.grey,
                              size:35
                            ),
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(4),
                            CardDateInputFormatter(),
                          ],
                          onChanged: (value) {
                            var text = value.replaceAll(RegExp(r'\s+\b|\b\s'), ' ');
                            setState(() {
                              cardExpiryDateController.value =
                                  cardExpiryDateController.value.copyWith(
                                      text: text,
                                      selection: TextSelection.collapsed(
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
                           style: TextStyle(
                        fontSize: 28
                      ),
                          controller: cardCvvController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                            hintText: 'CVV',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 25,
                            ),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.grey,
                              size:35
                            ),
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(3),
                          ],
                         
                          onChanged: (value) {
                            setState(() {
                              int length = value.length;
                              if (length == 4 || length == 9 || length == 14) {
                                cardNumberController.text = '$value ';
                                cardNumberController.selection =
                                    TextSelection.fromPosition(
                                        TextPosition(offset: value.length + 1));
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
                      minimumSize:
                          Size(MediaQuery.of(context).size.width / 1.12, 55),
                    ),
                    onPressed: () {
                      Future.delayed(const Duration(milliseconds: 300), () {
                        showDialog(
                            context: context,
                            builder: (context) => const CardAlertDialog());
                        cardCvvController.clear();
                        cardExpiryDateController.clear();
                        cardHolderNameController.clear();
                        cardNumberController.clear();
                     
                      });
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
                  ],),
                )
                
                ],
            ),
          ),
        ),
      ),
     )
      )
    );
    
  }
}
