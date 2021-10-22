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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
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
                    controller: userNameText,
                    autofocus: false,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      labelText: "Your Name",
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () async {
                      await userComplaintP.sendComplaintData(
                          complaintText: complaintText.text,
                          userName: userNameText.text);
                      complaintText.text = "";
                      userNameText.text = "";
                    },
                    icon: Icon(Icons.send))
              ],
            ),
          );
  }
}
