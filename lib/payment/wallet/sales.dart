import 'package:flutter/material.dart';
import 'package:flutter_application_4/payment/wallet/paymentWallet.dart';

Widget coinssales(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(right: 20.0),
    child: Container(
      width: 400,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey,
          width: 2.0,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Container(
              width: 200,
              child: Text(
                "500 Coins",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 35,
                  fontFamily: 'salsa',
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 65.0),
            child: Container(
                width: 270, child: Image.asset("assets/dollar_10744906.png")),
          ),
          Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: InkWell(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 100, top: 20),
                    child: Text(
                      "Buy Coins",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 35,
                        fontFamily: 'salsa',
                      ),
                    ),
                  ),
                  width: 400,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                ),
                onTap: () {
                  showpaymentalertWallet(context, "5");
                },
              ))
        ],
      ),
    ),
  );
}

Widget coins2(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(right: 20.0),
    child: Container(
      width: 400,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey,
          width: 2.0,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Container(
              width: 200,
              child: Text(
                "1000 Coins",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 35,
                  fontFamily: 'salsa',
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 65.0),
            child: Container(
                width: 270, child: Image.asset("assets/dollar_10744906.png")),
          ),
          Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: InkWell(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 100, top: 20),
                    child: Text(
                      "Buy Coins",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 35,
                        fontFamily: 'salsa',
                      ),
                    ),
                  ),
                  width: 400,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                ),
                onTap: () {
                  showpaymentalertWallet(context, "10");
                },
              ))
        ],
      ),
    ),
  );
}

Widget coins3(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(right: 20.0),
    child: Container(
      width: 400,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey,
          width: 2.0,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Container(
              width: 200,
              child: Text(
                "2000 Coins",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 35,
                  fontFamily: 'salsa',
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 65.0),
            child: Container(
                width: 270, child: Image.asset("assets/dollar_10744906.png")),
          ),
          Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: InkWell(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 100, top: 20),
                    child: Text(
                      "Buy Coins",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 35,
                        fontFamily: 'salsa',
                      ),
                    ),
                  ),
                  width: 400,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                ),
                onTap: () {
                  showpaymentalertWallet(context, "20");
                },
              ))
        ],
      ),
    ),
  );
}

Widget coins4(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(right: 20.0),
    child: Container(
      width: 400,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey,
          width: 2.0,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Container(
              width: 200,
              child: Text(
                "5000 Coins",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 35,
                  fontFamily: 'salsa',
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 65.0),
            child: Container(
                width: 270, child: Image.asset("assets/dollar_10744906.png")),
          ),
          Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: InkWell(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 100, top: 20),
                    child: Text(
                      "Buy Coins",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 35,
                        fontFamily: 'salsa',
                      ),
                    ),
                  ),
                  width: 400,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                ),
                onTap: () {
                  showpaymentalertWallet(context, "50");
                },
              ))
        ],
      ),
    ),
  );
}
