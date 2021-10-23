import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:right_to_pride/providers/admin_provider.dart';
import 'package:right_to_pride/providers/api_key.dart';
import 'package:right_to_pride/screens/admin_page.dart';

class AdminAuth extends StatefulWidget {
  const AdminAuth({Key? key}) : super(key: key);

  @override
  _AdminAuthState createState() => _AdminAuthState();
}

class _AdminAuthState extends State<AdminAuth> {
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final AdminDataP = Provider.of<AdminProvider>(context);
    void _showErrorDialog(String message) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('An Error Occurred!'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('Okay'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            )
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Admin"),
      ),
      body: AdminDataP.isFetching
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: Card(
                color: Colors.white70,
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                        width: 1, color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.circular(30)),
                clipBehavior: Clip.antiAlias,
                elevation: 40,
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Column(children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        //border: OutlineInputBorder(
                        // borderRadius: BorderRadius.all(
                        // Radius.circular(10),
                        //),
                        //),
                        labelText: "Email",
                      ),
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Password'),
                      obscureText: true,
                      controller: _passwordController,
                    ),
                    TextButton(
                      onPressed: () async {
                        if (_emailController.text == "admin@rtp.in" &&
                            _passwordController.text == "pass@admin") {
                          try {
                            await Provider.of<AdminProvider>(context,
                                    listen: false)
                                .adminLogin(_emailController.text,
                                    _passwordController.text);

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AdminPage(),
                              ),
                            );
                          } catch (error) {
                            var errorMessage = "Something went wrong";
                            _showErrorDialog(errorMessage);
                          }
                        } else {
                          _showErrorDialog("Invalid Details");
                        }
                      },
                      child: Text("LOGIN"),
                    ),
                  ]),
                ),
              ),
            ),
    );
  }
}
