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
    home: send_complaint(),
  ));
}
class send_complaint extends StatefulWidget{
  @override
  send_complaint_state createState()=>send_complaint_state();
}

class send_complaint_state extends State<send_complaint>{
  final scomp = new TextEditingController();

  String? errormsg;
  bool? error, showprogress;
  bool passwordVisible=true;
  Future _saveDetails(String scomp) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? url=prefs.getString("url");


    String lid = prefs.getString("lid").toString();

    var data = await http.post(
        Uri.parse(url.toString()+"and_send_comlaint"),
        body: {"complaint":scomp,"lid":lid});

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
          backgroundColor: Colors.black,
          title: Text('send your complaint'),


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
                        labelText: 'complaint',
                        hintText: 'complaint ',
                        prefixIcon: Icon(Icons.report_rounded)
                    ),
                    controller: scomp,
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
                        _saveDetails(scomp.text);
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