import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:right_to_pride/providers/admin_provider.dart';
import 'package:right_to_pride/screens/complaint_detail.dart';

class AdminPage extends StatefulWidget {
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
      body: AdminPageView(),
    );
  }
}

class AdminPageView extends StatefulWidget {
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
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: TextButton(
                        onPressed: () {
                          AdminDataP.fetchComplaintData();
                        },
                        child: Text("Get Complaints")),
                  ),
                  //  if (AdminDataP.complaintsResponse!=null){Text()}
                  //
                  AdminDataP.complaintList.length == 0
                      ? Text("Refresh The Page")
                      : ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          primary: false,
                          shrinkWrap: true,
                          itemCount: AdminDataP.complaintList.length,
                          itemBuilder: (context, index) {
                            return Card(
                              color: Colors.blue,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(80))),
                              elevation: 20,
                              margin: EdgeInsets.all(10),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  trailing: IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ComplaintDetail(
                                                    complaint: AdminDataP
                                                        .complaintList[index]
                                                        .complaint,
                                                    userName: AdminDataP
                                                        .complaintList[index]
                                                        .userName,
                                                  )));
                                    },
                                    icon: Icon(Icons.navigate_next),
                                  ),
                                  title: Text(
                                    AdminDataP.complaintList[index].complaint,
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  subtitle: Text(
                                    "By: ${AdminDataP.complaintList[index].userName}",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            );
                          })
                ],
              ),
            ),
    );
  }
}
