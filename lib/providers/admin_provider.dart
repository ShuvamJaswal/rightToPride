import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:right_to_pride/helper.dart';
import 'package:right_to_pride/providers/api_key.dart';

class AdminProvider with ChangeNotifier {
  List<complaintModel> complaintList = [];

  bool _somethingIsntGood = false;
  bool _isFetchingComplaint = false;
  bool get isFetching {
    return _isFetchingComplaint;
  }

  String token = "";
  String userId = "";
  Future<void> adminLogin(String email, String password) async {
    _isFetchingComplaint = true;
    notifyListeners();
    String url =
        "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$apiKey";
    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true,
          }));
      final responseData = json.decode(response.body);
      _isFetchingComplaint = false;
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      } else {
        token = responseData['idToken'];
        userId = responseData['localId'];
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> fetchComplaintData() async {
    complaintList = [];
    _somethingIsntGood = false;
    _isFetchingComplaint = true;
    notifyListeners();
    print(token);
    String fetchComplaintUrl =
        "https://right-to-pride-default-rtdb.firebaseio.com/complaints.json?auth=$token";
    try {
      final response = await http.get(
        Uri.parse(
          fetchComplaintUrl,
        ),
      );
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      extractedData.forEach((complaintId, Complaint) {
        complaintList.add(complaintModel(
            id: complaintId,
            complaint: Complaint["Complaint"],
            userName: Complaint["UserName"]));
      });
    } catch (error) {
      _somethingIsntGood = true; //to show error dialog.
      notifyListeners();
    }

    _isFetchingComplaint = false;
    notifyListeners();
  }
}
