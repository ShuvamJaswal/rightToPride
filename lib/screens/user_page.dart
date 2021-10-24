import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/utils.dart';
import 'package:provider/provider.dart';
import 'package:right_to_pride/providers/user_auth_provider.dart';
import 'package:right_to_pride/providers/user_provider.dart';
import 'package:right_to_pride/screens/complaint_done.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("User"),
        ),
        body: ComplaintInput());
  }
}

class ComplaintInput extends StatefulWidget {
  ComplaintInput({Key? key}) : super(key: key);
  final complaintText = TextEditingController();
  @override
  _ComplaintInputState createState() => _ComplaintInputState();
}

class _ComplaintInputState extends State<ComplaintInput> {
  final complaintText = TextEditingController();
  final userNameText = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final userComplaintP = Provider.of<UserProvider>(context);
    userNameText.text =
        Provider.of<UserAuthProvider>(context, listen: false).Email;
    return userComplaintP.isSending
        ? Center(child: CircularProgressIndicator())
        : Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    minLines: 4,
                    maxLines: 6,
                    keyboardType: TextInputType.multiline,
                    scrollPhysics: const BouncingScrollPhysics(),
                    controller: complaintText,
                    autofocus: false,
                    decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                          borderSide: BorderSide(color: Colors.black, width: 2),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                          borderSide: BorderSide(color: Colors.black, width: 2),
                        ),
                        labelText: "Type Your Complaint.",
                        labelStyle: TextStyle(color: Colors.black)),
                  ),
                ),
                Expanded(
                  child: TextField(
                    enabled: false,
                    controller: userNameText,
                    decoration: const InputDecoration(
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                          borderSide: BorderSide(color: Colors.black, width: 2),
                        ),
                        labelText: "Your Name",
                        labelStyle: TextStyle(color: Colors.black)),
                  ),
                ),
                SizedBox(
                  height: 66,
                  width: 188,
                  child: TextButton(
                      style: TextButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25))),
                        primary: Colors.black,
                        backgroundColor: Colors.black,
                        onSurface: Colors.grey,
                      ),

                      //   shape: const BeveledRectangleBorder(
                      //       borderRadius: BorderRadius.all(Radius.circular(25))),
                      //   primary: Colors.black,
                      //   backgroundColor: Colors.black,
                      //   onSurface: Colors.grey,
                      // ),
                      onPressed: () async {
                        if (complaintText.text != "" &&
                            userNameText.text != "") {
                          await userComplaintP.sendComplaintData(
                              token: Provider.of<UserAuthProvider>(context,
                                      listen: false)
                                  .token,
                              complaintText: complaintText.text,
                              userName: userNameText.text);

                          complaintText.text = "";
                          userNameText.text = "";
                          printStatus(userComplaintP.isSuccess.toString());
                          !(userComplaintP.isSuccess)
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ComplaintDonePage()))
                              : showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                        title: Text('An Error Occurred!'),
                                        content: Text("There's Some Problem."),
                                        actions: <Widget>[
                                          TextButton(
                                            child: Text('Okay'),
                                            onPressed: () {
                                              Navigator.of(ctx).pop();
                                            },
                                          )
                                        ],
                                      ));
                        }
                      },
                      child: const Text(
                        "Submit",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      )),
                )
              ],
            ),
          );
  }
}
