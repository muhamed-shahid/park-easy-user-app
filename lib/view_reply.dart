import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:parkeasy/send_complaint.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main(){
  return runApp(MaterialApp(
    home: view_reply(),
  ));
}

class view_reply extends StatefulWidget{
  @override
  view_reply_state createState()=>view_reply_state();
}



class view_reply_state extends State<view_reply> {

  Future<List<scomplaint>> _getJokes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? url=prefs.getString("url");
    String b = prefs.getString("lid").toString();
    String foodimage="";
    var data =
    await http.post(Uri.parse(url.toString()+"and_view_reply"),
        body: {"lid":b}
    );

    var jsonData = json.decode(data.body);
//    print(jsonData);
    List<scomplaint> jokes = [];
    for (var joke in jsonData["message"]) {
      print(joke);
      scomplaint newJoke = scomplaint(
        joke["id"].toString(),
        joke["complaint"],
        joke["date"].toString(),
        joke["reply"].toString(),
        joke["reply_date"].toString(),

      );
      jokes.add(newJoke);
    }
    return jokes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // backgroundColor: Colors.black,
          title: Text('Your Complaints')),
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
                          _buildRow("complaint:", snapshot.data[index].complaint.toString()),
                          _buildRow("reply:", snapshot.data[index].reply.toString()),
                          _buildRow("reply date:", snapshot.data[index].reply_date.toString()),


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


      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
              builder: (context)=>send_complaint(
              )));
        },

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


class scomplaint {
  final String id;
  final String complaint;
  final String date;
  final String reply;

  final String reply_date;



  scomplaint(this.id,this.complaint, this.date,this.reply,this.reply_date);
//  print("hiiiii");
}