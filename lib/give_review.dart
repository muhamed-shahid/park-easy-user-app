import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:parkeasy/user_home.dart';
import 'package:parkeasy/view_available_slot.dart';
import 'package:parkeasy/view_booking_status.dart';
import 'package:parkeasy/view_review.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main(){
  return runApp(MaterialApp(
    home: give_review(),
  ));
}
class give_review extends StatefulWidget{
  @override
  give_review_state createState()=>give_review_state();
}

class give_review_state extends State<give_review>{
  final vreview = new TextEditingController();

  String? errormsg;
  bool? error, showprogress;
  bool passwordVisible=true;
  Future _saveDetails(String vreview) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? url=prefs.getString("url");


    String lid = prefs.getString("lid").toString();
    String pid= prefs.getString("pid").toString();
    var data = await http.post(
        Uri.parse(url.toString()+"and_give_review"),
        body: {"review":vreview,"pid":pid,"lid":lid});

    var jsondata = json.decode(data.body);
//    if(jsonData["res"])

    if(jsondata["res"]=="false"){
      setState(() {
        print("kkkkkkkkkkkkk");
      });
    }
    else{
      if(jsondata["res"]=="true"){
        setState(() {
          print("lllllllllllllll");
        });
        Navigator.push(context, MaterialPageRoute(
            builder: (context)=>user_home(
            )));
        //user shared preference to save data
      }else{
        print("lllllllllllllllllllllllllllll");
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          title: Text('Give your review'),


        ),

        body: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(15),
                  child: TextField(

                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Review',
                        hintText: 'Enter your review ',
                        prefixIcon: Icon(Icons.reviews)
                    ),
                    controller: vreview,
                  ),
                ),


                Padding(padding: EdgeInsets.all(20),
                  child: SizedBox(
                    width: 100,
                    height: 30,
                    child: ElevatedButton(
                      // textColor: Colors.white,
                      // color: Colors.blue,
                      child: Text('send'),
                      onPressed: (){
                        print("k");
                        _saveDetails(vreview.text);
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context)=>view_booking_status(
                            )));
                      },
                    ),
                  ),
                ),

              ],
            )
        )
    );
  }
}

class Joke1 {
  final String id;
  Joke1(this.id);
}