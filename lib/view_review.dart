import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

void main(){
  return runApp(MaterialApp(
    home: view_review(),
  ));
}

class view_review extends StatefulWidget{
  @override
  view_review_state createState()=>view_review_state();
}



class view_review_state extends State<view_review> {

  Future<List<vreview>> _getJokes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? url=prefs.getString("url");
    String b = prefs.getString("pid").toString();
    String foodimage="";
    var data =
    await http.post(Uri.parse(url.toString()+"and_view_review"),
        body: {"pid":b}
    );

    var jsonData = json.decode(data.body);
//    print(jsonData);
    List<vreview> jokes = [];
    for (var joke in jsonData["message"]) {
      print(joke);
      vreview newJoke = vreview(
        joke["id"].toString(),
        joke["vreview"],
        joke["date"].toString(),
        joke["email"].toString(),
        joke["name"].toString(),

      );
      jokes.add(newJoke);
    }
    return jokes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // backgroundColor: Colors.grey,
          title: Text('Reviews')),
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
                          _buildRow("review:", snapshot.data[index].review.toString()),


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


class vreview {
  final String id;
  final String review;
  final String name;
  final String email;

  final String date;



  vreview(this.id,this.review, this.date,this.email,this.name);
//  print("hiiiii");
}