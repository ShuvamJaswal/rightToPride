import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:right_to_pride/providers/admin_provider.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin"),
      ),
      body: ChangeNotifierProvider<AdminProvider>(
          create: (_) => AdminProvider(), child: AdminPageView()),
    );
  }
}

class AdminPageView extends StatefulWidget {
  const AdminPageView({Key? key}) : super(key: key);

  @override
  _AdminPageViewState createState() => _AdminPageViewState();
}

class _AdminPageViewState extends State<AdminPageView> {
  @override
  Widget build(BuildContext context) {
    final AdminDataP = Provider.of<AdminProvider>(context);

    return Padding(
      padding: EdgeInsets.all(20),
      child: AdminDataP.isFetching
          ? CircularProgressIndicator()
          : Column(
              children: [
                TextButton(
                    onPressed: () {
                      AdminDataP.fetchComplaintData();
                    },
                    child: Text("View Complaints.")),
                //  if (AdminDataP.complaintsResponse!=null){Text()}
                //
                Text(AdminDataP.complaintsResponse)
              ],
            ),
    );
  }
}
