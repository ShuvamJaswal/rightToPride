import 'package:flutter/material.dart';
import 'package:right_to_pride/screens/admin_page.dart';
import 'package:right_to_pride/screens/user_page.dart';

class UserAuth extends StatefulWidget {
  const UserAuth({Key? key}) : super(key: key);

  @override
  _UserAuthState createState() => _UserAuthState();
}

class _UserAuthState extends State<UserAuth> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User"),
      ),
      body: TextButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => UserPage()));
        },
        child: Text("LOGIN"),
      ),
    );
  }
}
