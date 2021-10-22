import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class UserProvider with ChangeNotifier {
  bool _somethingIsntGood = false;
  bool _isSendingComplaint = false;
  bool get isSending {
    return _isSendingComplaint;
  }

  Future<void> sendComplaintData(
      {required String userName, required String complaintText}) async {
    _somethingIsntGood = false;
    _isSendingComplaint = true;
    notifyListeners();
    String sendComplaintUrl =
        "https://right-to-pride-default-rtdb.firebaseio.com/complaints/${userName}/ComplaintData.json";
    try {
      final response = await http.post(
        Uri.parse(
          sendComplaintUrl,
        ),
        body: json.encode({
          'Complaint': complaintText,
          'UserName': userName,
        }),
      );
    } catch (error) {
      _somethingIsntGood = true; //to show error dialog.
      notifyListeners();
    }
    _isSendingComplaint = false;
    notifyListeners();
  }
}
