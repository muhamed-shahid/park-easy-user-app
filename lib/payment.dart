import 'dart:convert';
import 'dart:js' as js; // For Web
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:parkeasy/user_home.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: RazorpayPayment(),
  ));
}

class RazorpayPayment extends StatefulWidget {
  @override
  _RazorpayPaymentState createState() => _RazorpayPaymentState();
}

class _RazorpayPaymentState extends State<RazorpayPayment> {
  Razorpay? _razorpay; // Nullable since Web doesn't support it

  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      // Web-specific handler for payment success
      js.context['onPaymentSuccess'] = (paymentData) {
        print("Payment successful on Web: ${paymentData['payment_id']}");
        _handlePaymentSuccess(paymentData);
      };
    } else {
      _razorpay = Razorpay();
      _razorpay!.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
      _razorpay!.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
      _razorpay!.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    }
  }

  @override
  void dispose() {
    _razorpay?.clear(); // Only clear if initialized
    super.dispose();
  }

  void _openPayment() {
    if (kIsWeb) {
      _openRazorpayWeb(); // Web Payment
    } else {
      _openRazorpayMobile(); // Android/iOS Payment
    }
  }

  // ✅ Razorpay for Android/iOS
  void _openRazorpayMobile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? amount = prefs.getString("amount"); // Retrieve the amount dynamically

    var options = {
      'key': 'rzp_test_HKCAwYtLt0rwQe',
      'amount': (int.tryParse(amount ?? "0") ?? 0) * 100, // Convert amount to paise
      'name': 'Easy Tank',
      'description': 'Fuel Purchase',
      'theme': {'color': '#008000'},
    };

    try {
      _razorpay!.open(options);
    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }

  // ✅ Razorpay for Web using JavaScript
  void _openRazorpayWeb() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? amount = prefs.getString("amount"); // Retrieve the amount dynamically

    js.context.callMethod("eval", [
      """
      var options = {
          "key": "rzp_test_HKCAwYtLt0rwQe",
          "amount": "${(int.tryParse(amount ?? "0") ?? 0) * 100}",  // Convert amount to paise
          "currency": "INR",
          "name": "Easy Tank",
          "description": "Fuel Purchase",
          "handler": function(response) {
              console.log("Payment Successful: " + response.razorpay_payment_id);
              // Send the payment response back to Dart
              var paymentData = {
                  'payment_id': response.razorpay_payment_id
              };
              // Call Dart method to handle success
              window.onPaymentSuccess(paymentData);
          },
          "prefill": {
              "name": "John Doe",
              "email": "johndoe@example.com",
              "contact": "9876543210"
          }
      };
      var rzp1 = new Razorpay(options);
      rzp1.open();
      """
    ]);
  }

  Future<void> _handlePaymentSuccess(dynamic response) async {
    // String paymentId = response['payment_id'];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? url = prefs.getString("url");
    String? bid = prefs.getString("pid");
    String? amount = prefs.getString("amount");

    var data = await http.post(
      Uri.parse(url.toString() + "make_payment"),
      body: {"bid": bid, "amount": amount},
    );

    var jsondata = json.decode(data.body);

    if (jsondata["res"] == "false") {
      setState(() {
        print("Error in registration");
      });
    } else {
      if (jsondata["status"] == "ok") {
        setState(() {
          print("Registration successful");
        });
        // Save the data and navigate to the login page
        Navigator.push(context, MaterialPageRoute(builder: (context) => user_home()));
      } else {
        print("Registration failed");
      }
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("Payment Failed: ${response.message}");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("External Wallet Used: ${response.walletName}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Razorpay Payment")),
      body: Center(
        child: ElevatedButton(
          onPressed: _openPayment,
          child: Text("Pay with Razorpay"),
        ),
      ),
    );
  }
}
