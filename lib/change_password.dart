import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart'; // Assuming LoginPage is here

void main() {
  runApp(MaterialApp(
    home: ChangePassword(),
  ));
}

class ChangePassword extends StatefulWidget {
  @override
  ChangePasswordState createState() => ChangePasswordState();
}

class ChangePasswordState extends State<ChangePassword> {
  bool cuValidation = false, newValidation = false, coValidation = false;
  final currentPassword = TextEditingController();
  final newPassword = TextEditingController();
  final confirmPassword = TextEditingController();

  String? errorMsg;
  bool passwordVisible = true;

  Future _saveDetails(String currentPassword, String newPassword, String confirmPassword) async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? url = prefs.getString("url");
    String? lid = sh.getString("lid");

    var data = await http.post(
        Uri.parse(url.toString() + "and_change_password"),
        body: {
          "cu_password": currentPassword,
          "new_password": newPassword,
          "co_password": confirmPassword,
          "lid": lid
        }
    );

    var jsonData = json.decode(data.body);

    if (jsonData["res"] == "false") {
      setState(() {
        errorMsg = "Password change failed, please try again.";
      });
    } else {
      // if (jsonData["res"] == "changed") {
      //   setState(() {
      //     errorMsg = "Password changed successfully!";
      //
      //   });
      //
      //
      //   Navigator.pushReplacement(
      //       context,
      //       MaterialPageRoute(builder: (context) => LoginPage()) // Corrected
      //   );
      // }
      if (jsonData["res"] == "changed") {
        setState(() {
          errorMsg = "Password changed successfully!";
        });

        // Show AlertDialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Success'),
              content: Text('Your password has been successfully changed!'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
      else {
        setState(() {
          errorMsg = "Passwords do not match!";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            if (errorMsg != null)
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  errorMsg!,
                  style: TextStyle(color: Colors.red),
                ),
              ),
            Padding(
              padding: EdgeInsets.all(15),
              child: TextField(
                controller: currentPassword,
                obscureText: passwordVisible,
                decoration: InputDecoration(
                  labelText: 'Current Password',
                  labelStyle: TextStyle(color: Colors.black),
                  hintText: 'Enter Your Current Password',
                  hintStyle: TextStyle(color: Colors.blueGrey),
                  prefixIcon: Icon(Icons.lock, color: Colors.black),
                  suffixIcon: IconButton(
                    icon: Icon(passwordVisible ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        passwordVisible = !passwordVisible;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
                style: TextStyle(color: Colors.black),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: TextField(
                controller: newPassword,
                obscureText: passwordVisible,
                decoration: InputDecoration(
                  labelText: 'New Password',
                  labelStyle: TextStyle(color: Colors.black),
                  hintText: 'Enter New Password',
                  hintStyle: TextStyle(color: Colors.blueGrey),
                  prefixIcon: Icon(Icons.lock, color: Colors.black),
                  suffixIcon: IconButton(
                    icon: Icon(passwordVisible ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        passwordVisible = !passwordVisible;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
                style: TextStyle(color: Colors.black),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: TextField(
                controller: confirmPassword,
                obscureText: passwordVisible,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  labelStyle: TextStyle(color: Colors.black),
                  hintText: 'Confirm Your Password',
                  hintStyle: TextStyle(color: Colors.blueGrey),
                  prefixIcon: Icon(Icons.lock, color: Colors.black),
                  suffixIcon: IconButton(
                    icon: Icon(passwordVisible ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        passwordVisible = !passwordVisible;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
                style: TextStyle(color: Colors.black),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: SizedBox(
                width: 100,
                height: 30,
                child: ElevatedButton( // Using ElevatedButton
                  child: Text("Change"),
                  onPressed: () {
                    if (currentPassword.text.isEmpty) {
                      setState(() {
                        cuValidation = true;
                      });
                    }
                    if (newPassword.text.isEmpty) {
                      setState(() {
                        newValidation = true;
                      });
                    }
                    if (confirmPassword.text.isEmpty) {
                      setState(() {
                        coValidation = true;
                      });
                    }

                    if (!cuValidation && !newValidation && !coValidation) {
                      _saveDetails(currentPassword.text, newPassword.text, confirmPassword.text);
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
