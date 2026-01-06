import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

void main(){
  return runApp(MaterialApp(
    home: view_profile(),
  ));
}

class view_profile extends StatefulWidget{
  @override
  view_profile_state createState()=>view_profile_state();
}

class view_profile_state extends State<view_profile> {
  String name="",email="",phone="",pin="",post="",place="";
  Future _getJokes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? url=prefs.getString("url");
    String b = prefs.getString("lid").toString();
    String foodimage="";
    var data =
    await http.post(Uri.parse(url.toString()+"and_view_profile"),
        body: {"lid":b}
    );

    var jsonData = json.decode(data.body);
//    print(jsonData);

  setState(() {
    name=jsonData['name'];
    phone=jsonData['phone'];
    email=jsonData['email'];
    pin=jsonData['pin'];
    post=jsonData['post'];
    place=jsonData['place'];

  });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getJokes();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // backgroundColor: Colors.black,
          title: Text('View Profile')),
      body: Container(

      child: Padding(
    padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Colors.grey.shade300),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(height: 10),
              _buildRow("name:",name),
              _buildRow("email:", email),
              _buildRow("phone:", phone),
              _buildRow("pin:", pin),
              _buildRow("post:", post),
              _buildRow("place:", place),

            ],
          ),
        ),
      ),
    )






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


class profile {
  final String id;
  final String name;
  final String phone;
  final String email;
  final String pin;
  final String post;
  final String place;




  profile(this.id,this.name, this.phone,this.email,this.pin,this.post,this.place);
//  print("hiiiii");
}