import 'package:flutter/material.dart';
import 'package:right_to_pride/screens/choose_user_screen.dart';
import 'package:right_to_pride/screens/user_page.dart';

class ComplaintDonePage extends StatefulWidget {
  const ComplaintDonePage({Key? key}) : super(key: key);
  @override
  _ComplaintDonePageState createState() => _ComplaintDonePageState();
}

class _ComplaintDonePageState extends State<ComplaintDonePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User"),
      ),
      body: ComplaintDoneUi(),
    );
  }
}

class ComplaintDoneUi extends StatelessWidget {
  ComplaintDoneUi({Key? key}) : super(key: key);
  List quotes = [
    """“Love him and let him love you. Do you think anything else under heaven really matters?” – James Baldwin""",
    """“If I wait for someone else to validate my existence, it will mean that I’m short-changing myself.” – Zanele Muholi""",
    """“I am proud, that I found the courage to deal the initial blow to the hydra of public contempt.” – Karl Heinrich Ulrichs
""",
    """“Every LGBTQ+ refugee has a unique situation—but the fear and pain they endured before coming to Canada is universal.” – Arsham Parsi""",
    """“Equality means more than passing laws. The struggle is really won in the hearts and minds of the community, where it really counts.” – Barbara Gittings"""
  ];
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        const Padding(
          padding: EdgeInsets.all(80.0),
          child: Icon(
            Icons.done_outline,
            size: 100,
            color: Colors.blue,
          ),
        ),
        Center(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            quotes[0],
            style: TextStyle(
                fontStyle: FontStyle.italic, fontSize: 40, color: Colors.blue),
          ),
        )),
        TextButton(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.fromLTRB(80, 10, 80, 10),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25))),
              primary: Colors.white,
              backgroundColor: Colors.black,
              onSurface: Colors.grey,
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => UserPage()));
            },
            child: Text("Submit New Complaint")),
        TextButton(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.fromLTRB(80, 10, 80, 10),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25))),
              primary: Colors.white,
              backgroundColor: Colors.black,
              onSurface: Colors.grey,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ChooseUserScreen()));
            },
            child: Text("Go To Home")),
      ]),
    );
  }
}
