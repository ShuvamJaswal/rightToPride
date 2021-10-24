import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:right_to_pride/providers/user_auth_provider.dart';

class UserProvider with ChangeNotifier {
  bool _somethingIsntGood = false;
  bool _isSendingComplaint = false;
  bool get isSending {
    return _isSendingComplaint;
  }

  bool get isSuccess {
    return _somethingIsntGood;
  }

  Future<void> sendComplaintData(
      {required String userName,
      required String complaintText,
      required token}) async {
    _somethingIsntGood = false;
    _isSendingComplaint = true;
    notifyListeners();
    String sendComplaintUrl =
        "https://right-to-pride-default-rtdb.firebaseio.com/complaints.json?auth=$token";
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
      _somethingIsntGood = false;
      notifyListeners();
    } catch (error) {
      _somethingIsntGood = true; //to show error dialog.
      notifyListeners();
    }
    _isSendingComplaint = false;
    notifyListeners();
  }
}
