import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:parkeasy/payment.dart';
import 'package:parkeasy/view_available_slot.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  return runApp(MaterialApp(
    home: view_bill(),
  ));
}

class view_bill extends StatefulWidget {
  @override
  view_bill_state createState() => view_bill_state();
}

class view_bill_state extends State<view_bill> {
  Future<List<bill>> _getJokes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? url = prefs.getString("url");
    String b = prefs.getString("lid").toString();
    String bid = prefs.getString("bid").toString();
    var data = await http.post(Uri.parse(url.toString() + "and_view_bill_and_pay"),
        body: {"id": b, "bid": bid});

    var jsonData = json.decode(data.body);
    List<bill> jokes = [];
    for (var joke in jsonData["message"]) {
      bill newJoke = bill(
          joke["id"].toString(),
          joke["amount"],
          joke["date"].toString(),
          joke["payment_date"].toString(),
          joke["payment_status"].toString(),
          joke["payment_type"].toString());
      jokes.add(newJoke);
    }
    return jokes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Bill'),
      ),
      body: Container(
        child: FutureBuilder(
          future: _getJokes(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: Text("Loading..."),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  // Get the payment status of the current bill
                  String paymentStatus = snapshot.data[index].payment_status;

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: Colors.grey.shade300),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10),
                            _buildRow("Amount:", snapshot.data[index].amount.toString()),
                            _buildRow("Status:", snapshot.data[index].payment_status.toString()),
                            _buildRow("Date:", snapshot.data[index].payment_date.toString()),
                            _buildRow("Payment Type:", snapshot.data[index].payment_type.toString()),

                            // Only show the Pay button if the status is not "paid"
                            if (paymentStatus != "paid")
                              Row(
                                children: [
                                  ElevatedButton(
                                    child: Text('Pay'),
                                    onPressed: () async {
                                      SharedPreferences prefs = await SharedPreferences.getInstance();
                                      String pid = snapshot.data[index].id.toString();
                                      String amount = snapshot.data[index].amount.toString();
                                      prefs.setString("pid", pid);
                                      prefs.setString("amount", amount);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => RazorpayPayment(),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: 5),
          Flexible(
            child: Text(
              value,
              style: TextStyle(
                color: Colors.grey.shade800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class bill {
  final String id;
  final String amount;
  final String date;
  final String payment_date;
  final String payment_status;
  final String payment_type;

  bill(this.id, this.amount, this.date, this.payment_date, this.payment_status, this.payment_type);
}
