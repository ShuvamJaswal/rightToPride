import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:right_to_pride/screens/admin_auth.dart';
import 'package:right_to_pride/screens/admin_page.dart';
import 'package:right_to_pride/screens/user_auth.dart';

class ChooseUserScreen extends StatefulWidget {
  const ChooseUserScreen({Key? key}) : super(key: key);

  @override
  _ChooseUserScreenState createState() => _ChooseUserScreenState();
}

class _ChooseUserScreenState extends State<ChooseUserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueAccent,
        appBar: AppBar(
          title: const Text(
            'Right To Pride',
          ),
        ),
        body: Center(
          child: Card(
            margin: EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(80))),
            elevation: 20,
            color: Colors.blue,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Text(
                    "Who's Using The Application?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(80, 10, 80, 10),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      primary: Colors.black,
                      backgroundColor: Colors.white,
                      onSurface: Colors.grey,
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AdminAuth()));
                    },
                    child: Text("Admin")),
                SizedBox(
                  height: 40,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.fromLTRB(80, 10, 80, 10),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                    primary: Colors.black,
                    backgroundColor: Colors.white,
                    onSurface: Colors.grey,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => UserAuth()));
                  },
                  child: Text("User"),
                ),
              ],
            ),
          ),
        ));
  }
}
