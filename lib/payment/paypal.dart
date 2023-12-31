import 'package:flutter/material.dart';
import 'package:flutter_paypal_checkout/flutter_paypal_checkout.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "PayPal Checkout",
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Center(
        child: TextButton(
          onPressed: () async {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => PaypalCheckout(
                sandboxMode: true,
                clientId: "AZ86RqEBr0WWmJ3BxerCjf8uvKAraHbL9eaR6G8KqjPYnQR4ZFYVXLDMEPHny2KPWgw1qq8fpS2pOCHA",
                secretKey: "AZ86RqEBr0WWmJ3BxerCjf8uvKAraHbL9eaR6G8KqjPYnQR4ZFYVXLDMEPHny2KPWgw1qq8fpS2pOCHA",
                returnURL: "success.snippetcoder.com",
                cancelURL: "cancel.snippetcoder.com",
                transactions: const [
                 
                ],
                note: "Contact us for any questions on your order.",
                onSuccess: (Map params) async {
                  print("true");
                },
                onError: (error) {
                  print("onError: $error");
                  Navigator.pop(context);
                },
                onCancel: () {
                  print('cancelled');
                },
              ),
            ));
          },
          style: TextButton.styleFrom(
            backgroundColor: Colors.teal,
            foregroundColor: Colors.white,
            shape: const BeveledRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(1),
              ),
            ),
          ),
          child: const Text('Checkout'),
        ),
      ),
    );
  }
}
