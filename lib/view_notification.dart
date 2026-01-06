import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

void main(){
  return runApp(MaterialApp(
    home: view_notification(),
  ));
}

class view_notification extends StatefulWidget{
  @override
  view_notification_state createState()=>view_notification_state();
}



class view_notification_state extends State<view_notification> {

  Future<List<notification>> _getJokes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? url=prefs.getString("url");
    String b = prefs.getString("lid").toString();
    String foodimage="";
    var data =
    await http.post(Uri.parse(url.toString()+"and_view_notification"),
        body: {"id":b}
    );

    var jsonData = json.decode(data.body);
//    print(jsonData);
    List<notification> jokes = [];
    for (var joke in jsonData["message"]) {
      print(joke);
      notification newJoke = notification(
          joke["id"].toString(),
          joke["notifiaction"],
          joke["date"].toString()

      );
      jokes.add(newJoke);
    }
    return jokes;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(

        title: Text('Notifications')),
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
                          _buildRow("notification:", snapshot.data[index].notifiaction.toString()),


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

class notification {
  final String id;
  final String notifiaction;

  final String date;



  notification(this.id,this.notifiaction,this.date);
//  print("hiiiii");
}