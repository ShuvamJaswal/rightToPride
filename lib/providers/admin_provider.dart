import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class AdminProvider with ChangeNotifier {
  String complaintsResponse = "";
  bool _somethingIsntGood = false;
  bool _isFetchingComplaint = false;
  bool get isFetching {
    return _isFetchingComplaint;
  }

  Future<void> fetchComplaintData() async {
    _somethingIsntGood = false;
    _isFetchingComplaint = true;
    notifyListeners();
    String fetchComplaintUrl =
        "https://right-to-pride-default-rtdb.firebaseio.com/complaints.json";
    try {
      final response = await http.get(
        Uri.parse(
          fetchComplaintUrl,
        ),
      );
      complaintsResponse = response.body;
    } catch (error) {
      _somethingIsntGood = true; //to show error dialog.
      notifyListeners();
    }

    _isFetchingComplaint = false;
    notifyListeners();
  }
}
