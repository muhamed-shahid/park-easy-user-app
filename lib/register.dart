import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:parkeasy/widget/primarybutton.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


import 'widget/bezierContainer.dart';
import 'login.dart';
// import 'package:flutter_login_signup/src/Widget/bezierContainer.dart';
// import 'package:flutter_login_signup/src/loginPage.dart';
// import 'package:google_fonts/google_fonts.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key ?key, this.title}) : super(key: key);

  final String? title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool name_validation=false,phone_validation=false,place_validation=false,post_validation=false,pin_validation=false,email_validation=false,pass_validation=false,co_validation=false;
  final name = new TextEditingController();
  final phone = new TextEditingController();
  final place = new TextEditingController();
  final post = new TextEditingController();
  final pin = new TextEditingController();
  final email = new TextEditingController();
  final password = new TextEditingController();
  final confirm_password = new TextEditingController();

  String? errormsg;
  bool? error, showprogress;
  bool passwordVisible=true;
  Future _saveDetails(String name,String phone,String place,String post,String pin ,String email,String password,String confirm_password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? url=prefs.getString("url");
    var data = await http.post(
        Uri.parse(url.toString()+"and_register"),
        body: {"name":name,"phone":phone,"place":place,"post":post,"pin":pin,"email":email,"password":password,"co_password":confirm_password});

    var jsondata = json.decode(data.body);
    print(jsondata);
//    if(jsonData["res"])

    if(jsondata["res"]=="true"){
      setState(() {
        print("success");
        Navigator.push(context, MaterialPageRoute(
            builder: (context)=>LoginPage(
            )));
      });
    }
    else{
      if(jsondata["status"]=="no"){
        setState(() {
          print("Error");
        });

      }else{
        print("lllllllllllllllllllllllllllll");
      }
    }
  }

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Back',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget _entryField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Text(
          //   title,
          //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          // ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: name,
            decoration: InputDecoration(
              labelText: 'User Name',
              labelStyle: TextStyle(color: Colors.black),
              hintText: 'Enter Your Full Name',
              hintStyle: TextStyle(color: Colors.blueGrey),
              prefixIcon: Icon(Icons.person, color: Colors.black),
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
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: phone,
            decoration: InputDecoration(
              labelText: 'Phone Number',
              labelStyle: TextStyle(color: Colors.black),
              hintText: 'Enter Your Phone Number',
              hintStyle: TextStyle(color: Colors.blueGrey),
              prefixIcon: Icon(Icons.phone, color: Colors.black),
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
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: place,
            decoration: InputDecoration(
              labelText: 'Place',
              labelStyle: TextStyle(color: Colors.black),
              hintText: 'Enter Your Place',
              hintStyle: TextStyle(color: Colors.blueGrey),
              prefixIcon: Icon(Icons.location_on_sharp, color: Colors.black),
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
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: post,
            decoration: InputDecoration(
              labelText: 'Post',
              labelStyle: TextStyle(color: Colors.black),
              hintText: 'Enter Your Post',
              hintStyle: TextStyle(color: Colors.blueGrey),
              prefixIcon: Icon(Icons.post_add, color: Colors.black),
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
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: pin,
            decoration: InputDecoration(
              labelText: 'Pin',
              labelStyle: TextStyle(color: Colors.black),
              hintText: 'Enter Your Pin Number',
              hintStyle: TextStyle(color: Colors.blueGrey),
              prefixIcon: Icon(Icons.pin_drop, color: Colors.black),
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
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: email,
            decoration: InputDecoration(
              labelText: 'Email',
              labelStyle: TextStyle(color: Colors.black),
              hintText: 'Enter Your Email',
              hintStyle: TextStyle(color: Colors.blueGrey),
              prefixIcon: Icon(Icons.email_sharp, color: Colors.black),
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
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: password,
            obscureText: passwordVisible,
            decoration: InputDecoration(
              labelText: 'Password',
              labelStyle: TextStyle(color: Colors.black),
              hintText: 'Enter Password',
              hintStyle: TextStyle(color: Colors.blueGrey),
              prefixIcon: Icon(Icons.lock,color: Colors.black,),
              suffixIcon: IconButton(
                icon: Icon(passwordVisible
                    ? Icons.visibility
                    : Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    passwordVisible = !passwordVisible;
                  });
                },
              ),
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
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: confirm_password,
            obscureText: passwordVisible,
            decoration: InputDecoration(
              labelText: 'Confirm Password',
              labelStyle: TextStyle(color: Colors.black),
              hintText: 'Confirm Your Password',
              hintStyle: TextStyle(color: Colors.blueGrey),
              prefixIcon: Icon(Icons.lock,color: Colors.black,),
              suffixIcon: IconButton(
                icon: Icon(passwordVisible
                    ? Icons.visibility
                    : Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    passwordVisible = !passwordVisible;
                  });
                },
              ),
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
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  // Widget _submitButton() {
  //   return Container(
  //     width: MediaQuery.of(context).size.width,
  //     padding: EdgeInsets.symmetric(vertical: 15),
  //     alignment: Alignment.center,
  //     decoration: BoxDecoration(
  //         borderRadius: BorderRadius.all(Radius.circular(5)),
  //         boxShadow: <BoxShadow>[
  //           BoxShadow(
  //               color: Colors.grey.shade200,
  //               offset: Offset(2, 4),
  //               blurRadius: 5,
  //               spreadRadius: 2)
  //         ],
  //         gradient: LinearGradient(
  //             begin: Alignment.centerLeft,
  //             end: Alignment.centerRight,
  //             colors: [Color(0xfffbb448), Color(0xfff7892b)])),
  //     child: Text(
  //       'Register Now',
  //       style: TextStyle(fontSize: 20, color: Colors.white),
  //     ),
  //   );
  // }

  Widget _loginAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Already have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Login',
              style: TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

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
            //   TextSpan(
            //     text: 'rnz',
            //     style: TextStyle(color: Color(0xffe46b10), fontSize: 30),
            //   ),
          ]),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField()

      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -MediaQuery.of(context).size.height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: BezierContainer(),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: height * .2),
                    _title(),
                    SizedBox(
                      height: 50,
                    ),
                    _emailPasswordWidget(),
                    SizedBox(
                      height: 20,
                    ),
                    PrimaryButton(
                      text: "Register",
                      onTap: () {
                        if(name.text.isEmpty){
                          setState(() {
                            name_validation=true;
                          });
                        }
                        if(phone.text.isEmpty){
                          setState(() {
                            phone_validation=true;
                          });
                        }
                        if(place.text.isEmpty){
                          setState(() {
                            place_validation=true;
                          });
                        }
                        if(post.text.isEmpty){
                          setState(() {
                            post_validation=true;
                          });
                        }
                        if(pin.text.isEmpty){
                          setState(() {
                            pin_validation=true;
                          });
                        }
                        if(email.text.isEmpty){
                          setState(() {
                            email_validation=true;
                          });
                        }
                        if(password.text.isEmpty){
                          setState(() {
                            pass_validation=true;
                          });
                        }
                        if(confirm_password.text.isEmpty){
                          setState(() {
                            co_validation=true;
                          });
                        }
                        _saveDetails(name.text, phone.text, place.text, post.text, pin.text, email.text , password.text, confirm_password.text);
                      },

                    ),
                    SizedBox(height: height * .14),
                    _loginAccountLabel(),
                  ],
                ),
              ),
            ),
            Positioned(top: 40, left: 0, child: _backButton()),
          ],
        ),
      ),
    );
  }

}
