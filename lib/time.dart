import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:parkeasy/user_home.dart';
import 'package:parkeasy/view_available_slot.dart';
import 'package:parkeasy/view_booking_status.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main(){
  return runApp(MaterialApp(
    home: time(),
  ));
}

class time extends StatefulWidget{
  @override
  time_state createState() => time_state();
}

class time_state extends State<time> {
  final start_time = new TextEditingController();
  final end_time = new TextEditingController();
  String? errormsg;
  bool? error, showprogress;
  bool passwordVisible = true;

  // Function to pick time
  Future<TimeOfDay?> _selectTime(BuildContext context, {required bool isStart}) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          start_time.text = picked.format(context); // Set the start time text
        } else {
          end_time.text = picked.format(context); // Set the end time text
        }
      });
    }
    return picked;
  }

  // Function to save details
  Future _saveDetails(String start_time, String end_time) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? url = prefs.getString("url");

    String lid = prefs.getString("lid").toString();
    String sid = prefs.getString("sid").toString();
    var data = await http.post(
        Uri.parse(url.toString() + "and_book_slot"),
        body: {
          "start_time": start_time,
          "end_time": end_time,
          "sid": sid,
          "lid": lid
        });

    var jsondata = json.decode(data.body);

    if (jsondata["res"] == "false") {
      setState(() {
        print("kkkkkkkkkkkkk");
      });
    } else {
      if (jsondata["res"] == "true") {
        setState(() {
          print("lllllllllllllll");
        });
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => user_home()
        ));
      } else {
        print("lllllllllllllllllllllllllllll");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Set Your Time'),
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
                  labelText: 'Start Time',
                  hintText: 'Select the start time',
                  prefixIcon: Icon(Icons.timer),
                ),
                controller: start_time,
                readOnly: true,
                onTap: () => _selectTime(context, isStart: true),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.timer),
                  border: OutlineInputBorder(),
                  labelText: 'End Time',
                  hintText: 'Select the end time',
                ),
                controller: end_time,
                readOnly: true,
                onTap: () => _selectTime(context, isStart: false),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: SizedBox(
                width: 100,
                height: 30,
                child: ElevatedButton(
                  child: Text('Ok'),
                  onPressed: () {
                    print("k");
                    _saveDetails(start_time.text, end_time.text);
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => view_booking_status())
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Joke1 {
  final String id;
  Joke1(this.id);
}
