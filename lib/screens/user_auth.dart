import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:right_to_pride/providers/user_auth_provider.dart';
import 'package:right_to_pride/screens/admin_page.dart';
import 'package:right_to_pride/screens/user_page.dart';

enum AuthMode { Signup, Login }

class UserAuth extends StatefulWidget {
  const UserAuth({Key? key}) : super(key: key);

  @override
  _UserAuthState createState() => _UserAuthState();
}

class _UserAuthState extends State<UserAuth> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  Future<void> _submit() async {
    _authData['email'] = _emailController.text;
    _authData['password'] = _passwordController.text;

    setState(() {
      _isLoading = true;
    });
    try {
      if (_authMode == AuthMode.Login) {
        // Log user in

        await Provider.of<UserAuthProvider>(context, listen: false)
            .logIn(_authData['email']!, _authData['password']!);
      } else {
        // Sign user up

        await Provider.of<UserAuthProvider>(context, listen: false)
            .signUp(_authData['email']!, _authData['password']!);
      }
    } on HttpException catch (error) {
      var errorMessage = error.toString();
      _showErrorDialog(errorMessage);
    } catch (error) {
      var errorMessage = "Something went wrong";
      _showErrorDialog(errorMessage);
    }

    setState(() {
      _isLoading = false;
    });
  }

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

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          color: Colors.white70,
          shape: RoundedRectangleBorder(
              side: BorderSide(width: 1, color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(30)),
          clipBehavior: Clip.antiAlias,
          elevation: 40,
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              children: [
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
                  validator: (value) {
                    if (value!.isEmpty || value.length < 5) {
                      return 'Password is too short!';
                    }
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  controller: _passwordController,
                  validator: (value) {
                    if (value!.isEmpty || value.length < 5) {
                      return 'Password is too short!';
                    }
                  },
                ),
                if (_isLoading)
                  CircularProgressIndicator()
                else
                  TextButton(
                    child:
                        Text(_authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP'),
                    onPressed: () async {
                      await _submit();

                      (Provider.of<UserAuthProvider>(context, listen: false)
                              .loggedIn)
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserPage()))
                          : _switchAuthMode;
                    },
                  ),
                TextButton(
                  child: Text(
                      '${_authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'} INSTEAD'),
                  onPressed: _switchAuthMode,
                ),
                // TextButton(
                //   onPressed: () {
                //     Navigator.push(context,
                //         MaterialPageRoute(builder: (context) => UserPage()));
                //   },
                //   child: Text("LOGIN"),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
