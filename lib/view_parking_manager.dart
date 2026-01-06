// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:parkeasy/view_available_slot.dart';
// import 'package:parkeasy/view_review.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// void main(){
//   return runApp(MaterialApp(
//     home: view_approved_parking_location(),
//   ));
// }
//
// class view_approved_parking_location extends StatefulWidget{
//   @override
//   view_approved_parking_location_state createState()=>view_approved_parking_location_state();
// }
//
//
//
// class view_approved_parking_location_state extends State<view_approved_parking_location> {
//
//   Future<List<parking>> _getJokes() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? url=prefs.getString("url");
//     String b = prefs.getString("lid").toString();
//     String foodimage="";
//     var data =
//     await http.post(Uri.parse(url.toString()+"and_view_approved_parking_location"),
//         body: {"id":b}
//     );
//
//     var jsonData = json.decode(data.body);
// //    print(jsonData);
//     List<parking> jokes = [];
//     for (var joke in jsonData["message"]) {
//       print(joke);
//       parking newJoke = parking(
//           joke["id"].toString(),
//           joke["name"],
//           joke["phone"].toString(),
//           joke["place"].toString(),
//           joke["post"].toString(),
//           joke["pin"].toString(),
//           joke["photo"].toString(),
//           joke["proof"].toString(),
//           joke["email"].toString(),
//           joke["latitude"].toString(),
//           joke["longitude"].toString()
//
//       );
//       jokes.add(newJoke);
//     }
//     return jokes;
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//             // backgroundColor: Colors.black,
//         title: Text('Parking managers')),
//       body:Container(
//
//       child:
//       FutureBuilder(
//         future: _getJokes(),
//         builder: (BuildContext context, AsyncSnapshot snapshot) {
// //              print("snapshot"+snapshot.toString());
//           if (snapshot.data == null) {
//             return Container(
//               child: Center(
//                 child: Text("Loading..."),
//               ),
//             );
//           } else {
//             return ListView.builder(
//               itemCount: snapshot.data.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Card(
//                     elevation: 3,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       side: BorderSide(color: Colors.grey.shade300),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//
//                           SizedBox(height: 10),
//                           _buildRow("Name:", snapshot.data[index].name.toString()),
//                           _buildRow("Phone:", snapshot.data[index].phone.toString()),
//                           _buildRow("Place:", snapshot.data[index].place.toString()),
//                           _buildRow("Post:", snapshot.data[index].post.toString()),
//                           _buildRow("Pin:", snapshot.data[index].pin.toString()),
//                           // _buildRow("Photo:", snapshot.data[index].photo.toString()),
//                           // _buildRow("Proof:", snapshot.data[index].proof.toString()),
//                           _buildRow("Email:", snapshot.data[index].email.toString()),
//                           // _buildRow("Latitude:", snapshot.data[index].latitude.toString()),
//                           // _buildRow("Longitude:", snapshot.data[index].longitude.toString()),
//                           ElevatedButton(
//                             // textColor: Colors.white,
//                             // color: Colors.blue,
//                             child: Text('Locate'),
//                             onPressed: () async {
//                               SharedPreferences prefs = await SharedPreferences.getInstance();
//                               String pid=snapshot.data[index].id.toString();
//                               prefs.setString("pid",pid);
//                               Navigator.push(context, MaterialPageRoute(
//                                   builder: (context)=>view_available_slot(
//                                   )),
//                               );
//                             },
//                           ),
//                           SizedBox(height: 10,),
//                           Row(children: [
//                             ElevatedButton(
//                               // textColor: Colors.white,
//                               // color: Colors.blue,
//                               child: Text('Slot'),
//                               onPressed: () async {
//                                 SharedPreferences prefs = await SharedPreferences.getInstance();
//                                 String pid=snapshot.data[index].id.toString();
//                                 prefs.setString("pid",pid);
//                                 Navigator.push(context, MaterialPageRoute(
//                                     builder: (context)=>view_available_slot(
//                                     )),
//                                 );
//                               },
//                             ),
//                             ElevatedButton(
//                               // textColor: Colors.white,
//                               // color: Colors.blue,
//                               child: Text('view review'),
//                               onPressed: () async {
//                                 SharedPreferences prefs = await SharedPreferences.getInstance();
//                                 String bid=snapshot.data[index].id.toString();
//                                 prefs.setString("pid",bid);
//                                 Navigator.push(context, MaterialPageRoute(
//                                     builder: (context)=>view_review(
//                                     )),
//                                 );
//                               },
//                             ),
//                           ],)
//
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             );
//
//
//           }
//         },
//
//
//       ),
//
//
//
//
//
//     ),);
//   }
//
//   Widget _buildRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         children: [
//           SizedBox(
//             width: 100,
//             child: Text(
//               label,
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           SizedBox(width: 5),
//           Flexible(
//             child: Text(
//               value,
//               style: TextStyle(
//                 color: Colors.grey.shade800,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
// }
//
//
// class parking {
//   final String id;
//   final String name;
//   final String phone;
//   final String place;
//   final String post;
//   final String pin;
//   final String photo;
//   final String proof;
//   final String email;
//   final String latitude;
//   final String longitude;
//
//
//
//
//
//   parking(this.id,this.name, this.phone,this.place,this.post,this.pin,this.photo,this.proof,this.email,this.latitude,this.longitude);
// //  print("hiiiii");
// }



import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:parkeasy/view_available_slot.dart';
import 'package:parkeasy/view_review.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  runApp(MaterialApp(
    home: view_approved_parking_location(),
  ));
}

class view_approved_parking_location extends StatefulWidget {
  @override
  view_approved_parking_location_state createState() =>
      view_approved_parking_location_state();
}

class view_approved_parking_location_state
    extends State<view_approved_parking_location> {
  TextEditingController _searchController = TextEditingController();
  List<parking> _allParking = [];
  List<parking> _filteredParking = [];

  // Fetch parking data
  Future<void> _getJokes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? url = prefs.getString("url");
    String b = prefs.getString("lid").toString();
    var data = await http.post(Uri.parse(url.toString() + "and_view_approved_parking_location"),
        body: {"id": b});

    var jsonData = json.decode(data.body);
    List<parking> jokes = [];
    for (var joke in jsonData["message"]) {
      parking newJoke = parking(
        joke["id"].toString(),
        joke["name"],
        joke["phone"].toString(),
        joke["place"].toString(),
        joke["post"].toString(),
        joke["pin"].toString(),
        joke["photo"].toString(),
        joke["proof"].toString(),
        joke["email"].toString(),
        joke["latitude"].toString(),
        joke["longitude"].toString(),
      );
      jokes.add(newJoke);
    }

    setState(() {
      _allParking = jokes;  // Set all fetched parking data
      _filteredParking = jokes;  // Initialize filtered parking with all parking data
    });
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterParking);
    _getJokes();  // Fetch parking data as soon as the widget is initialized
  }

  void _filterParking() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredParking = _allParking
          .where((parking) => parking.place.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Parking Managers'),
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  labelText: 'Search by Place',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Expanded(
              child: _allParking.isEmpty
                  ? Center(child: CircularProgressIndicator())  // Show loading spinner until data is loaded
                  : ListView.builder(
                itemCount: _filteredParking.length,
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
                            _buildRow("Name:", _filteredParking[index].name),
                            _buildRow("Phone:", _filteredParking[index].phone),
                            _buildRow("Place:", _filteredParking[index].place),
                            _buildRow("Post:", _filteredParking[index].post),
                            _buildRow("Pin:", _filteredParking[index].pin),
                            _buildRow("Email:", _filteredParking[index].email),
                            _buildRow("Latitude:", _filteredParking[index].latitude),
                           _buildRow("Longitude:", _filteredParking[index].longitude),

                            // ElevatedButton(
                            //   child: Text('Locate'),
                            //   onPressed: () async {
                            //     SharedPreferences prefs =
                            //     await SharedPreferences.getInstance();
                            //     String pid = _filteredParking[index].id;
                            //     prefs.setString("pid", pid);
                            //     Navigator.push(
                            //       context,
                            //       MaterialPageRoute(
                            //         builder: (context) => view_available_slot(),
                            //       ),
                            //     );
                            //   },
                            // ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                ElevatedButton(
                                  child: Text('Slot'),
                                  onPressed: () async {
                                    SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                    String pid = _filteredParking[index].id;
                                    prefs.setString("pid", pid);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => view_available_slot(),
                                      ),
                                    );
                                  },
                                ),
                                ElevatedButton(
                                  child: Text('View Review'),
                                  onPressed: () async {
                                    SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                    String bid = _filteredParking[index].id;
                                    prefs.setString("pid", bid);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => view_review(),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
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

class parking {
  final String id;
  final String name;
  final String phone;
  final String place;
  final String post;
  final String pin;
  final String photo;
  final String proof;
  final String email;
  final String latitude;
  final String longitude;

  parking(
      this.id,
      this.name,
      this.phone,
      this.place,
      this.post,
      this.pin,
      this.photo,
      this.proof,
      this.email,
      this.latitude,
      this.longitude,
      );
}
