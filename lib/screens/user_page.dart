import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:right_to_pride/providers/user_provider.dart';

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
      body: ChangeNotifierProvider<UserProvider>(
          create: (_) => UserProvider(), child: ComplaintInput()),
    );
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
                    minLines: 2,
                    maxLines: 4,
                    keyboardType: TextInputType.multiline,
                    scrollPhysics: const BouncingScrollPhysics(),
                    controller: complaintText,
                    autofocus: false,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      labelText: "Type Your Complaint.",
                    ),
                  ),
                ),
                Expanded(
                  child: TextField(
                    cursorColor: Colors.black,
                    controller: userNameText,
                    autofocus: false,
                    decoration: const InputDecoration(
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                          borderSide:
                              const BorderSide(color: Colors.black, width: 2),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                          borderSide:
                              const BorderSide(color: Colors.black, width: 2),
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
                        await userComplaintP.sendComplaintData(
                            complaintText: complaintText.text,
                            userName: userNameText.text);
                        complaintText.text = "";
                        userNameText.text = "";
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
