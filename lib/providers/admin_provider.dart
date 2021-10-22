import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:right_to_pride/helper.dart';

class AdminProvider with ChangeNotifier {
  List<complaintModel> complaintList = [];

  bool _somethingIsntGood = false;
  bool _isFetchingComplaint = false;
  bool get isFetching {
    return _isFetchingComplaint;
  }

  Future<void> fetchComplaintData() async {
    complaintList = [];
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
