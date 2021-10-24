import 'dart:io';

import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_key.dart';

class UserAuthProvider with ChangeNotifier {
  bool _isLoggedin = false;
  String Email = "";
  String token = "";
  String userId = "";
  bool get loggedIn {
    return _isLoggedin;
  }

  Future<String> _authenticate(
      String email, String password, String type) async {
    this.Email = email;
    _isLoggedin = false;
    String url =
        "https://identitytoolkit.googleapis.com/v1/accounts:$type?key=$apiKey";
    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true,
          }));
      final responseData = json.decode(response.body);

      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      } else {
        type.contains("signUp") ? _isLoggedin = false : _isLoggedin = true;
        token = responseData['idToken'];
        userId = responseData['localId'];
        return type == "signUp" ? "signedUp" : "loggedIn";
      }
    } catch (error) {
      throw error;
    }
  }

  Future<String> signUp(String email, String password) async {
    return _authenticate(email, password, "signUp");
  }

  Future<String> logIn(String email, String password) async {
    return _authenticate(email, password, "signInWithPassword");
  }
}
