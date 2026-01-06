


import 'dart:convert';
import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:parkeasy/user_home.dart';
import 'package:parkeasy/widget/primarybutton.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'IP.dart';
import 'register.dart';
// import 'package:flutter_login_signup/src/signup.dart';
// import 'package:google_fonts/google_fonts.dart';

 import 'widget/bezierContainer.dart';

void main(){
  runApp(MaterialApp(
    home: LoginPage(),
  ));
}

class LoginPage extends StatefulWidget {
  LoginPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool username_validation=false,password_validation=false;

  final username = TextEditingController(text:"abrar");
  final password = TextEditingController(text:"321");
  bool passwordVisible = true;

  Future _saveDetails(String username, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? url = prefs.getString("url");
    var data = await http.post(
        Uri.parse(url.toString() + "and_login"),
        body: {"username": username, "password": password});

    var jsondata = json.decode(data.body);

    if (jsondata["res"] == "true") {
      String uid = jsondata["lid"].toString();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("lid", uid);
      Navigator.push(context, MaterialPageRoute(builder: (context) => user_home()));
    } else {
      // Handle incorrect login
    }
  }

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ip_page()));
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

       SizedBox(height: 20),
          TextField(

            controller: username,
            decoration: InputDecoration(
              error: username_validation == true ? Text("Please enter a valid username"):Text(""),
              labelText: 'User name',
              labelStyle: TextStyle(color: Colors.black),
              hintText: 'Enter Your Username/email',
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
          SizedBox(height: 15),
          TextField(
            controller: password,
            obscureText: passwordVisible,
            decoration: InputDecoration(
              error: password_validation == true ? Text("Please Enter Valid Password"):Text(""),
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
  //       'Login',
  //       style: TextStyle(fontSize: 20, color: Colors.white),
  //     ),
  //   );
  // }

  Widget _divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          Text('or'),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  // Widget _facebookButton() {
  //   return Container(
  //     height: 50,
  //     margin: EdgeInsets.symmetric(vertical: 20),
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.all(Radius.circular(10)),
  //     ),
  //     child: Row(
  //       children: <Widget>[
  //         Expanded(
  //           flex: 1,
  //           child: Container(
  //             decoration: BoxDecoration(
  //               color: Color(0xff1959a9),
  //               borderRadius: BorderRadius.only(
  //                   bottomLeft: Radius.circular(5),
  //                   topLeft: Radius.circular(5)),
  //             ),
  //             alignment: Alignment.center,
  //             child: Text('f',
  //                 style: TextStyle(
  //                     color: Colors.white,
  //                     fontSize: 25,
  //                     fontWeight: FontWeight.w400)),
  //           ),
  //         ),
  //         Expanded(
  //           flex: 5,
  //           child: Container(
  //             decoration: BoxDecoration(
  //               color: Color(0xff2872ba),
  //               borderRadius: BorderRadius.only(
  //                   bottomRight: Radius.circular(5),
  //                   topRight: Radius.circular(5)),
  //             ),
  //             alignment: Alignment.center,
  //             child: Text('Log in with Facebook',
  //                 style: TextStyle(
  //                     color: Colors.white,
  //                     fontSize: 18,
  //                     fontWeight: FontWeight.w400)),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignUpPage()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Don\'t have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Register',
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

          ]),
    );
  }

  // Widget _emailPasswordWidget() {
  //   return Column(
  //     children: <Widget>[
  //       _entryField(),
  //
  //     ],
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
          height: height,
          child: Stack(
            children: <Widget>[
              Positioned(
                  top: -height * .15,
                  right: -MediaQuery.of(context).size.width * .4,
                  child: BezierContainer()),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: height * .2),
                      _title(),
                      SizedBox(height: 50),
                      _entryField(),
                      SizedBox(height: 20),
                      PrimaryButton(
                        text: "Login",
                        onTap: () {
                          if(username.text.isEmpty){
                            setState(() {
                              username_validation=true;
                            });
                          }
                          if(password.text.isEmpty){
                            setState(() {
                              password_validation=true;
                            });
                          }

                          _saveDetails(username.text, password.text);
                        },

                      ),
                      // Container(
                      //   padding: EdgeInsets.symmetric(vertical: 10),
                      //   alignment: Alignment.centerRight,
                      //   child: Text('Forgot Password ?',
                      //       style: TextStyle(
                      //           fontSize: 14, fontWeight: FontWeight.w500)),
                      // ),
                      _divider(),
                      // _facebookButton(),
                      // SizedBox(height: height * .055),
                      _createAccountLabel(),
                    ],
                  ),
                ),
              ),

              Positioned(top: 40, left: 0, child: _backButton()),
            ],
          ),
        ));
  }
}

