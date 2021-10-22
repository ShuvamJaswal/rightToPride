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
        appBar: AppBar(
          title: const Text(
            'Right To Pride',
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AdminAuth()));
                    },
                    child: Text("Admin")),
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => UserAuth()));
                  },
                  child: Text("User"),
                ),
              ],
            )));
  }
}
