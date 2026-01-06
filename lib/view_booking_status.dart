import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:parkeasy/view_bill.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'give_review.dart';
void main(){
  return runApp(MaterialApp(
    home: view_booking_status(),
  ));
}

class view_booking_status extends StatefulWidget{
  @override
  view_booking_status_state createState()=>view_booking_status_state();
}

class view_booking_status_state extends State<view_booking_status>{

  Future<List<booking>> _getJokes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? url=prefs.getString("url");
    String b = prefs.getString("lid").toString();
    String foodimage="";
    var data =
    await http.post(Uri.parse(url.toString()+"and_view_booking_status"),
        body: {"lid":b}
    );

    var jsonData = json.decode(data.body);
//    print(jsonData);
    List<booking> jokes = [];
    for (var joke in jsonData["message"]) {
      print(joke);
      booking newJoke = booking(
          joke["id"].toString(),
          joke["date"],
          joke["status"].toString(),
          joke["start_time"].toString(),
          joke["end_time"].toString(),
          joke["pid"].toString()

      );
      jokes.add(newJoke);
    }
    return jokes;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(


        title: Text('Booking status')),
      body: Container(

      child:
      FutureBuilder(
        future: _getJokes(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
//              print("snapshot"+snapshot.toString());
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
                          _buildRow("Date:", snapshot.data[index].date.toString()),
                          _buildRow("status:", snapshot.data[index].status.toString()),
                          _buildRow("start_time:", snapshot.data[index].start_time.toString()),
                          _buildRow("end_time:", snapshot.data[index].end_time.toString()),
                          _buildRow("parking_id:", snapshot.data[index].pid.toString()),

                          Row(children: [
                            ElevatedButton(
                              // textColor: Colors.white,
                              // color: Colors.blue,
                              child: Text('view bill'),
                              onPressed: () async {
                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                String bid=snapshot.data[index].id.toString();
                                prefs.setString("bid",bid);
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context)=>view_bill(
                                    )),
                                );
                              },
                            ),


                            ElevatedButton(
                              // textColor: Colors.white,
                              // color: Colors.blue,
                              child: Text('give review'),
                              onPressed: () async {
                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                String bid=snapshot.data[index].pid.toString();
                                prefs.setString("pid",bid);
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context)=>give_review(
                                    )),
                                );
                              },
                            ),
                          ],)

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





    ),);
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

class booking {
  final String id;
  final String date;

  final String status;
  final String start_time;
  final String end_time;
  final String pid;




  booking(this.id,this.date, this.status,this.start_time,this.end_time,this.pid);
//  print("hiiiii");
}