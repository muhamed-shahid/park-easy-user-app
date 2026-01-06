import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:parkeasy/view_available_slot.dart';
import 'package:parkeasy/view_bill.dart';
import 'package:parkeasy/view_booking_status.dart';
import 'package:parkeasy/view_notification.dart';
import 'package:parkeasy/view_parking_manager.dart';
import 'package:parkeasy/view_profile.dart';
import 'package:parkeasy/view_review.dart';
//import 'package:online_vehicle_parking_new/view_slot.dart';

import 'change_password.dart';
import 'give_review.dart';
import 'login.dart';
import 'send_complaint.dart';
import 'view_reply.dart';

void main(){
  return runApp(MaterialApp(
    home: user_home(),
  ));
}

class user_home extends StatefulWidget{
  @override
  user_home_state createState()=>user_home_state();
}



class user_home_state extends State<user_home> {
  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'Park',
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: Color(0xffe46b10)
          ),
          children: [
            TextSpan(
              text: 'Easy',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),

          ]),
    );
  }
  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.of(context).size.height;
    return Scaffold(


      drawer: Drawer(
        // backgroundColor: Colors.orange.shade200,
        child: Column(
          children: [
            ListTile(
              title: Text("view profile"),
              leading: new Icon(Icons.person),
              onTap: (){


                Navigator.push(context, MaterialPageRoute(
                    builder: (context)=>view_profile(
                    )));
              },
            ),
            ListTile(
              title: Text("view approved parking manager"),
              leading: new Icon(Icons.location_on_sharp),
              onTap: (){


                Navigator.push(context, MaterialPageRoute(
                    builder: (context)=>view_approved_parking_location(
                    )));
              },
            ),

            ListTile(
              title: Text("complaint"),
              leading: new Icon(Icons.message_sharp),
              onTap: (){


                Navigator.push(context, MaterialPageRoute(
                    builder: (context)=>view_reply(
                    )));
              },
            ),


            ListTile(
              title: Text("view booking status"),
              leading: new Icon(Icons.calendar_today_sharp),
              onTap: (){


                Navigator.push(context, MaterialPageRoute(
                    builder: (context)=>view_booking_status(
                    )));
              },
            ),
            // ListTile(
            //   title: Text("view review"),
            //   leading: new Icon(Icons.reviews),
            //   onTap: (){
            //
            //
            //     Navigator.push(context, MaterialPageRoute(
            //         builder: (context)=>view_review(
            //         )));
            //   },
            // ),
            // ListTile(
            //   title: Text("give review"),
            //   leading: new Icon(Icons.reviews),
            //   onTap: (){
            //
            //
            //     Navigator.push(context, MaterialPageRoute(
            //         builder: (context)=>give_review(
            //         )));
            //   },
            // ),
            ListTile(
              title: Text("view notification"),
              leading: new Icon(Icons.notification_important),
              onTap: (){


                Navigator.push(context, MaterialPageRoute(
                    builder: (context)=>view_notification(
                    )));
              },
            ),
            ListTile(
              title: Text("change password"),
              leading: new Icon(Icons.password),
              onTap: (){


                Navigator.push(context, MaterialPageRoute(
                    builder: (context)=>ChangePassword(
                    )));
              },
            ),
            ListTile(
              title: Text("logout"),
              leading: new Icon(Icons.logout),
              onTap: (){


                Navigator.push(context, MaterialPageRoute(
                    builder: (context)=>LoginPage(
                    )));
              },
            ),


          ],
        ),


      ),
      appBar: AppBar(title: _title(),
        centerTitle: true,
        backgroundColor: Colors.white,

      ),
      body: DecoratedBox(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/ok.png"),
                fit: BoxFit.cover,

              ),
          ),
              child: Center(
          child: Text(""),
      ),
      )
    );

  }
}
