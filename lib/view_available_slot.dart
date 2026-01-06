import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:parkeasy/time.dart';
import 'package:parkeasy/user_home.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main(){
  return runApp(MaterialApp(
    home: view_available_slot(),
  ));
}

class view_available_slot extends StatefulWidget{
  @override
  view_available_slot_state createState()=>view_available_slot_state();
}


class view_available_slot_state extends State< view_available_slot> {
  Future<List<slot>> _getJokes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? url=prefs.getString("url");

    String b = prefs.getString("lid").toString();
    String pid= prefs.getString("pid").toString();

    var data =
    await http.post(Uri.parse(url.toString()+"and_view_available_slot"),
        body: {"lid":b,"pid":pid}
    );

    var jsonData = json.decode(data.body);
//    print(jsonData);
    List<slot> jokes = [];
    for (var joke in jsonData["message"]) {
      print(joke);
      slot newJoke = slot(
          joke["id"].toString(),
          joke["status"],
          joke["slot_count"].toString(),
          joke["min_charge"].toString(),
          joke["date"].toString()
      );
      jokes.add(newJoke);
    }
    return jokes;
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.black,
        title: Text('Slots'),


      ),
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
                          _buildRow("Status:", snapshot.data[index].status.toString()),
                          _buildRow("Minimum_charge:", snapshot.data[index].min_charge.toString()),
                          _buildRow("Slot_count:", snapshot.data[index].slot_count.toString()),
                          _buildRow("Date:", snapshot.data[index].date.toString()),
                          Row(children: [
                            ElevatedButton(
                              // textColor: Colors.white,
                              // color: Colors.blue,
                              child: Text('Book slot'),
                              onPressed: () async {
                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                String sid=snapshot.data[index].id.toString();

                                prefs.setString("sid", sid);
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context)=>time(
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
class slot {
  final String id;
  final String status;

  final String slot_count;
  final String min_charge;
  final String date;




  slot(this.id,this.status, this.slot_count,this.min_charge,this.date);
//  print("hiiiii");
}