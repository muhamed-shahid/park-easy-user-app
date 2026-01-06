import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:parkeasy/widget/new_button.dart';
import 'package:parkeasy/widget/primarybutton.dart';
// import 'package:online_vehicle_parking_new/widget/primarybutton.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';



void main(){
  return runApp(MaterialApp(
    home: ip_page(),
      debugShowCheckedModeBanner: false
  ));
}

class ip_page extends StatefulWidget{
  @override
  ip_page_state createState()=>ip_page_state();
}

class ip_page_state extends State<ip_page>{
  bool ip_validation=false;
  final ip_address = new TextEditingController(text: "192.168.43.99");


  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          title: Text('IP Address',style: TextStyle(color: Colors.white,fontWeight:FontWeight.bold)),
          backgroundColor: Colors.black,


        ),

        body: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(15),
                  child: TextField(
                    controller: ip_address,
                    decoration: InputDecoration(
                      error: ip_validation == true ? Text("Please Enter Valid IP"):Text(""),
                      labelText: 'IP Address',
                      labelStyle: TextStyle(color: Colors.black),
                      hintText: 'Enter Your IP Address',
                      hintStyle: TextStyle(color: Colors.blueGrey),
                      prefixIcon: Icon(Icons.verified_user, color: Colors.black),
                      // filled: true,
                      // fillColor: Color(0xFF454D55), // Custom background color for the text field
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color:Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                    style: TextStyle(color: Colors.black),
                  ),

                ),

                Padding(padding: EdgeInsets.all(20),
                  child: SizedBox(
                    width: 100,
                    height: 30,
                    child:
                    PrimaryButton1(
                      // textColor: Colors.white,
                      // color: Colors.blue,
                      text: "Connect",
                      onTap: () async {
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        await prefs.setString("ip", ip_address.text);
                        await prefs.setString("url", "http://${ip_address.text}:8000/");
                        if(ip_address.text.isEmpty){
                          setState(() {
                            ip_validation=true;
                          });
                        }
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context)=>LoginPage(
                            ))
                        );


                      },
                    ),
                  ),
                )
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
